# Website Setup and Deployment

This folder is the source for the **Quantitative Economics Interactive Dashboard** hosted on GitHub Pages at:

> **https://ryann-teo.github.io/QE/**

The repository is at:

> **https://github.com/Ryann-teo/QE**

## How it works

- This folder is a git repository connected to the remote on GitHub.
- `index.html` is the entire site: every lesson is embedded inline with KaTeX math, Plotly widgets, and concept-map navigation.
- When you push to the `main` branch, GitHub Pages auto-rebuilds within 30 to 60 seconds.

## One-time setup (you only need to do this once)

**Easiest path: run the included setup script.**

Open a terminal in this folder and run:

```bash
# Mac / Linux / Git Bash
./setup-website.sh
```

```cmd
:: Windows command prompt
setup-website.bat
```

The script does git init, stages everything, commits, adds the remote, and pushes. It then prints the next step (enabling Pages on GitHub).

**Manual path** (if you prefer to run each command yourself):

```bash
cd "C:/Users/ryant/Documents/Big Brain/Areas/Economics/Quantitative Economics/QE Dashboard"
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/Ryann-teo/QE.git
git branch -M main
git push -u origin main
```

If git is already initialised, you only need to push:

```bash
git push -u origin main
```

### Authentication

GitHub no longer accepts plain passwords from the command line. Use one of:

1. **Personal Access Token (easiest).** GitHub.com → Settings → Developer settings → Personal access tokens → Tokens (classic) → Generate new token. Give it `repo` scope. Use the token as your password when git prompts.
2. **SSH keys.** Set up at https://docs.github.com/en/authentication/connecting-to-github-with-ssh and change the remote with `git remote set-url origin git@github.com:Ryann-teo/QE.git`.

## Enable GitHub Pages

After your first push:

1. Go to https://github.com/Ryann-teo/QE
2. Settings → Pages (left sidebar)
3. Source: "Deploy from a branch"
4. Branch: **main**, folder: **/ (root)**
5. Save

The first build takes about a minute. Subsequent builds take 30 seconds.

## Workflow: every time you update the dashboard

After Claude updates `index.html` (or you do), run:

### Mac / Linux / Git Bash

```bash
./push-updates.sh
```

### Windows command prompt

```cmd
push-updates.bat
```

### Or manually (any platform)

```bash
git add .
git commit -m "Update dashboard"
git push origin main
```

The `push-updates` scripts handle staging, commit message, and push in one step. They also print the live URL.

## Verifying the site

Live at https://ryann-teo.github.io/QE/

If it does not appear:

- Wait 60 seconds for the first build.
- Repository → Actions tab: check that the "pages build and deployment" workflow succeeded.
- Settings → Pages: confirm the source branch is `main` and folder is `/ (root)`.

## Folder structure on GitHub

```
/                                        (live root)
├── index.html                           (the dashboard)
├── README.md
├── WEBSITE_SETUP.md
├── setup-website.sh
├── setup-website.bat
├── push-updates.sh
└── push-updates.bat
```

URLs:
- Dashboard: https://ryann-teo.github.io/QE/
- Direct lesson link: https://ryann-teo.github.io/QE/#lesson-1-3 (for example)

## Troubleshooting

- **`git push` rejected with "non-fast-forward"**. Run `git pull --rebase` then `git push`.
- **GitHub Pages does not update**. Check Settings → Pages and confirm source. Wait a minute. Check the Actions tab.
- **HTML renders as raw code**. The file name must end in `.html` and start with `<!DOCTYPE html>`.
- **KaTeX or Plotly does not load**. The CDN links are absolute https URLs. Check the browser console for blocked content. (GitHub Pages serves over https.)
