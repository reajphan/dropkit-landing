# DropKit Landing

Static landing page for DropKit — the AI DJ for macOS.

## Deploy

This is a single-file static site. Deploy anywhere that serves HTML.

### Cloudflare Pages (recommended)
1. Push this repo to GitHub.
2. Cloudflare Dashboard → Pages → Create project → Connect to Git.
3. Build settings: leave everything blank, output directory `/`.
4. Custom domain → `dropkit.app`.

### Local preview
```bash
python3 -m http.server 8000
# open http://localhost:8000
```

## Edits

- All content + styles live in `index.html`. Edit, commit, push → live in ~30 seconds.
- Replace `FORMSPREE_ID` in the waitlist `<form action>` with a real Formspree endpoint, or swap for Cloudflare's built-in form-handler.
- Replace the SVG mock in the hero with a real screenshot of the app at `assets/mixing-screen.png` once available.
