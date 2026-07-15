/* math-coding-ui client-side runtime.
 *
 * Loaded as a single deferred script. Provides:
 *   - theme toggle (light/dark/auto)
 *   - keyboard shortcuts (vim/arrows)
 *   - search overlay (lunr-compatible index at /search.json)
 *   - mermaid client-side rendering (if enabled)
 *   - graph interactivity (when JS is loaded)
 *
 * No dependencies. No bundler-runtime. Plain ES2020.
 */

(function () {
  "use strict";

  const root = document.documentElement;
  const body = document.body;

  // === Theme toggle ===

  const THEME_KEY = "math-coding-ui.theme";
  const initTheme = () => {
    const saved = localStorage.getItem(THEME_KEY);
    if (saved === "light" || saved === "dark") {
      root.setAttribute("data-theme", saved);
    }
  };

  const cycleTheme = () => {
    const current = root.getAttribute("data-theme") || "auto";
    const next = current === "light" ? "dark" : current === "dark" ? "auto" : "light";
    root.setAttribute("data-theme", next);
    if (next === "auto") {
      localStorage.removeItem(THEME_KEY);
    } else {
      localStorage.setItem(THEME_KEY, next);
    }
  };

  const themeBtn = document.querySelector(".theme-toggle");
  if (themeBtn) themeBtn.addEventListener("click", cycleTheme);
  initTheme();

  // === Keyboard navigation ===

  let currentPacketIdx = 0;
  const packetLinks = Array.from(document.querySelectorAll(".packet-list a"));
  if (packetLinks.length > 0) {
    packetLinks[currentPacketIdx]?.classList.add("focused");
  }

  const setFocus = (idx) => {
    if (idx < 0) idx = packetLinks.length - 1;
    if (idx >= packetLinks.length) idx = 0;
    packetLinks.forEach((a) => a.classList.remove("focused"));
    currentPacketIdx = idx;
    packetLinks[idx]?.classList.add("focused");
    packetLinks[idx]?.scrollIntoView({ behavior: "smooth", block: "nearest" });
  };

  // === Search overlay ===

  let searchIndex = null;
  const searchOverlay = document.createElement("div");
  searchOverlay.className = "search-overlay";
  searchOverlay.innerHTML = `
    <div class="search-box">
      <input type="search" placeholder="Search… (Esc to close)" autocomplete="off">
      <div class="search-results"></div>
    </div>`;
  document.body.appendChild(searchOverlay);

  const searchInput = searchOverlay.querySelector("input");
  const searchResults = searchOverlay.querySelector(".search-results");

  const openSearch = () => {
    searchOverlay.classList.add("active");
    setTimeout(() => searchInput.focus(), 10);
    if (!searchIndex) loadSearchIndex();
  };

  const closeSearch = () => {
    searchOverlay.classList.remove("active");
    searchInput.value = "";
    searchResults.innerHTML = "";
  };

  searchOverlay.addEventListener("click", (e) => {
    if (e.target === searchOverlay) closeSearch();
  });

  const loadSearchIndex = async () => {
    try {
      const r = await fetch("/search.json");
      if (!r.ok) return;
      searchIndex = await r.json();
    } catch (e) {
      console.warn("math-ui: search index unavailable", e);
    }
  };

  const runSearch = (q) => {
    if (!searchIndex) return;
    const query = q.toLowerCase().trim();
    if (!query) {
      searchResults.innerHTML = "";
      return;
    }
    const matches = searchIndex
      .map((entry) => {
        const haystack = `${entry.title}\n${entry.excerpt}\n${entry.body}`.toLowerCase();
        const idx = haystack.indexOf(query);
        if (idx === -1) return null;
        return { entry, score: -idx };
      })
      .filter(Boolean)
      .sort((a, b) => b.score - a.score)
      .slice(0, 20);

    searchResults.innerHTML = matches.length
      ? matches
          .map(
            ({ entry }) => `
        <div class="search-result" data-url="${entry.url}">
          <div class="title">${entry.title}</div>
          <div class="excerpt">${entry.excerpt.slice(0, 140)}…</div>
        </div>`,
          )
          .join("")
      : `<p style="padding:1rem;color:var(--color-text-muted)">No matches.</p>`;

    searchResults.querySelectorAll(".search-result").forEach((el) => {
      el.addEventListener("click", () => {
        window.location.href = el.dataset.url;
      });
    });
  };

  searchInput?.addEventListener("input", (e) => runSearch(e.target.value));

  // === Keyboard handlers ===

  document.addEventListener("keydown", (e) => {
    if (e.target.matches("input, textarea")) {
      if (e.key === "Escape") e.target.blur();
      return;
    }

    if (e.key === "/") {
      e.preventDefault();
      openSearch();
      return;
    }
    if (e.key === "Escape") {
      closeSearch();
      return;
    }

    // g-prefix navigation
    if (e.key === "g") {
      window.__mcuGPrefix = true;
      setTimeout(() => { window.__mcuGPrefix = false; }, 800);
      return;
    }
    if (window.__mcuGPrefix) {
      window.__mcuGPrefix = false;
      if (e.key === "f") return (window.location.href = "/fsm/");
      if (e.key === "g") return (window.location.href = "/graph/");
      if (e.key === "a") return (window.location.href = "/axioms/");
      if (e.key === "t") return (window.location.href = "/theories/");
      if (e.key === "p") return (window.location.href = "/math/");
    }

    // j/k packet navigation
    if (packetLinks.length > 0) {
      if (e.key === "j") {
        e.preventDefault();
        setFocus(currentPacketIdx + 1);
      } else if (e.key === "k") {
        e.preventDefault();
        setFocus(currentPacketIdx - 1);
      } else if (e.key === "Enter" && packetLinks[currentPacketIdx]) {
        window.location.href = packetLinks[currentPacketIdx].href;
      }
    }
  });

  // === Mermaid (lightweight client-side, optional) ===

  if (window.__mcuMermaidEnabled) {
    const blocks = document.querySelectorAll("pre.mermaid");
    blocks.forEach((block, idx) => {
      const id = `mermaid-${idx}`;
      block.id = id;
      block.textContent = block.textContent;
      block.style.display = "block";
      // Mermaid rendering is delegated to the bundled library
      // (loaded separately if available). When not available,
      // the raw mermaid source is shown as fallback.
    });
  }

  // === Graph interactivity ===

  const graphHost = document.getElementById("graph-canvas-host");
  const graphDataEl = document.getElementById("graph-data");
  if (graphHost && graphDataEl) {
    try {
      const data = JSON.parse(graphDataEl.textContent || "{}");
      makeGraphInteractive(graphHost, data);
    } catch (e) {
      console.warn("graph data parse failed", e);
    }
  }

  function makeGraphInteractive(host, data) {
    let scale = 1;
    let panX = 0;
    let panY = 0;
    let dragging = false;
    let dragStart = null;

    const svg = host.querySelector("svg");
    if (!svg) return;

    const wrap = document.createElement("div");
    wrap.style.cssText = "width:100%;height:100%;overflow:hidden;cursor:grab;";
    svg.style.transformOrigin = "0 0";
    svg.style.transition = "transform 0.1s";
    while (host.firstChild) wrap.appendChild(host.firstChild);
    host.appendChild(wrap);

    const apply = () => {
      svg.style.transform = `translate(${panX}px, ${panY}px) scale(${scale})`;
    };

    wrap.addEventListener("mousedown", (e) => {
      dragging = true;
      dragStart = { x: e.clientX - panX, y: e.clientY - panY };
      wrap.style.cursor = "grabbing";
    });
    window.addEventListener("mousemove", (e) => {
      if (!dragging) return;
      panX = e.clientX - dragStart.x;
      panY = e.clientY - dragStart.y;
      apply();
    });
    window.addEventListener("mouseup", () => {
      dragging = false;
      wrap.style.cursor = "grab";
    });

    wrap.addEventListener(
      "wheel",
      (e) => {
        e.preventDefault();
        const factor = e.deltaY < 0 ? 1.1 : 0.9;
        scale = Math.max(0.2, Math.min(5, scale * factor));
        apply();
      },
      { passive: false },
    );

    // Click handler: navigate to packet
    svg.querySelectorAll(".graph-node").forEach((node) => {
      node.style.cursor = "pointer";
      node.addEventListener("click", () => {
        const id = node.getAttribute("data-id");
        const kind = node.getAttribute("data-kind");
        if (kind === "packet") {
          window.location.href = `/math/${id}/`;
        } else if (kind === "theory") {
          window.location.href = `/theories/${id}.html`;
        } else if (kind === "axiom") {
          window.location.href = `/axioms/#${id.toLowerCase()}`;
        }
      });
    });

    // Filter controls
    const filters = {
      "show-axiom-chain": "axiom-chain",
      "show-depends": "depends_on",
      "show-wikilinks": "wikilink",
      "show-theory-link": "theory-link",
    };
    for (const [id, kind] of Object.entries(filters)) {
      const cb = document.getElementById(id);
      if (!cb) continue;
      cb.addEventListener("change", () => {
        svg.querySelectorAll("line").forEach((line) => {
          // Edge color encodes kind (via stroke attribute); filter by kind label
          const isKind =
            (kind === "depends_on" && line.getAttribute("stroke") === "var(--color-edge-depends, #888)") ||
            (kind === "axiom-chain" && line.getAttribute("stroke") === "var(--color-edge-axiom, #c7472b)") ||
            (kind === "theory-link" && line.getAttribute("stroke") === "var(--color-edge-theory, #1f6feb)") ||
            (kind === "wikilink" && line.getAttribute("stroke") === "var(--color-edge-wiki, #aaa)");
          if (isKind) {
            line.style.display = cb.checked ? "" : "none";
          }
        });
      });
    }
  }

  // === Initial focus for keyboard nav ===

  if (packetLinks.length > 0 && packetLinks[0]) {
    packetLinks[0].classList.add("focused");
  }
})();