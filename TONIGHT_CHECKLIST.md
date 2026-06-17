# Tonight Checklist — DropKit launch infra

Run these in order. Each is ~5 minutes except where noted.

## 1. Register domain — Cloudflare Registrar (~$12/yr at cost)
- Go to https://dash.cloudflare.com/ → sign up if needed
- Top menu → "Domain Registration" → "Register Domains"
- Search `dropkit.app` (fallbacks if taken: `dropkit.fm`, `dropkitapp.com`, `getdropkit.com`, `mochimix.app`)
- Pay. Cloudflare sells at wholesale — no markup.
- Domain auto-attaches to your Cloudflare account.

## 2. Apple Developer Program signup (24–48h approval)
- https://developer.apple.com/programs/enroll/
- Use your Apple ID, $99/yr, individual enrollment (not org)
- Bring out a driver's license — Apple verifies identity
- You'll get an email "Your enrollment is being processed"
- While it processes, install Xcode if you don't have it (free, from Mac App Store, ~10GB)

## 3. Push the landing repo to GitHub
- Make a new repo at https://github.com/new
  - Name: `dropkit-landing`
  - Public or private — your call (public is fine, it's just HTML)
  - Don't init with README (we have one)
- Then from your terminal:
```bash
cd ~/.openclaw/workspace/projects/dj-engine-landing
git remote add origin git@github.com:YOUR_USERNAME/dropkit-landing.git
git branch -M main
git push -u origin main
```
- Tell me your GitHub username when done and I'll write the remaining commands

## 4. Cloudflare Pages — deploy
- Cloudflare Dashboard → "Workers & Pages" → Create → Pages → Connect to Git
- Authorize GitHub, pick `dropkit-landing` repo
- Build settings:
  - Framework preset: **None**
  - Build command: leave blank
  - Build output directory: `/`
- Click Save and Deploy
- First deploy takes ~30 seconds
- You'll get a URL like `dropkit-landing.pages.dev`

## 5. Connect domain to Pages
- In the Pages project → Custom domains → Set up a custom domain
- Enter `dropkit.app` and `www.dropkit.app`
- Cloudflare auto-creates DNS records since domain is already on Cloudflare
- SSL auto-provisions in ~1 minute

## 6. Email capture — Formspree (free tier, 50/mo)
- Sign up at https://formspree.io
- Create a new form, copy the form endpoint (looks like `https://formspree.io/f/xqkzplab`)
- Tell me the endpoint and I'll wire it into the landing page

## 7. (Optional tonight) Reserve social handles
- Twitter/X: @dropkit_app (or whatever's free)
- Instagram: @dropkit.app
- TikTok: @dropkit.app
- Reserve them even if you don't post yet — names get squatted fast

---

## What I'll do once you're done with the above

- Write proper PyInstaller + .dmg build script
- Write GitHub Actions workflow that auto-builds + signs + notarizes on `git tag v*`
- Write the `codesign` + `notarytool` commands using your Apple Dev cert
- Take a real screenshot of the DropKit app and swap out the SVG mock on the landing page
- Write the dev recruiting page (separate from landing) with the plan, tech stack, what we need

## What this whole thing costs tonight
- Domain (Cloudflare): ~$12
- Apple Developer: $99
- Cloudflare Pages: $0
- GitHub: $0
- Formspree: $0
- **Total: ~$111**

## Editing flow after launch
1. Edit `index.html` locally
2. `git commit -m "...your change..." && git push`
3. Cloudflare rebuilds in ~30 sec, site is live
4. Done. No server, no sysadmin, no SSL renewals, nothing to remember.

