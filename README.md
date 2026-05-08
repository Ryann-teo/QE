# Quantitative Economics Interactive Dashboard

An interactive single-page revision site for Quantitative Economics (Trinity 2026, J. A. Duffy, Oxford). Covers every examinable concept from the lecture notes, slides, and Question Types catalogue (86 lessons in five modules) with full derivations, intuitive explanations, and live interactive visualisations.

> **Live site**: https://ryann-teo.github.io/QE/
> **Source repo**: https://github.com/Ryann-teo/QE

## What is in here

- `index.html`: the central dashboard with all 86 lessons embedded inline. KaTeX renders math, Plotly powers the interactive simulators (distribution explorer, CLT, OLS, OVB direction, AR(1) trajectories, Binomial/Normal approximation), and a sticky sidebar lets you jump between modules.
- `setup-website.sh` / `setup-website.bat`: one-time scripts to initialise the git repo and push to GitHub.
- `push-updates.sh` / `push-updates.bat`: convenience scripts to commit and push changes any time you edit `index.html`.
- `WEBSITE_SETUP.md`: step-by-step deployment guide.

## Modules

- **Module 0**: Probability and statistics primer (16 lessons)
- **Module 1**: Linear regression and causality (14 lessons)
- **Module 2**: Linear regression and statistical inference (15 lessons)
- **Module 3**: Endogeneity, RCTs, and instrumental variables (18 lessons)
- **Module 4**: Time series (23 lessons)

**Total: 86 lessons.**

Each lesson card has tabs for Idea, Formal definition, Full derivation, Intuition, Interactive visualisation, Why it matters (concept links and exam role), and Self-test prompts.

## Quick start

1. Open `index.html` directly in a browser to use the dashboard locally.
2. Run `./setup-website.sh` once to deploy to GitHub Pages.
3. Run `./push-updates.sh` whenever you (or Claude) edit content.

## Sources

- `Reference Materials/notes-1` to `notes-5-appendix.pdf`
- `Reference Materials/slides-1` to `slides-4.pdf`
- `Reference Materials/Quantitative Economics Key Facts.md`
- `Study Guide/Question Types/` (four files)
- `QE Interactive Dashboard - Lesson Outline.md` (the master outline this site renders)
