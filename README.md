# shell-snippets

Commands and scripts I actually use — tested on my own VPS/dev setups, not copy-pasted theory.

## Contents

- `vps-hardening.sh` — SSH hardening, UFW, fail2ban setup for a fresh Ubuntu VPS
- `deploy.sh` — rsync-based deploy flow (code sync without full git clone)
- `docker.md` — Docker one-liners I keep forgetting
- `django-laravel.md` — migrate, venv, artisan commands for Django/Laravel projects
- `cm/` — [add what this is]

## Usage

Most scripts are meant to be read, not blindly run. Check the comments before executing on a live server.

## Why this exists

Built while setting up and hardening real infrastructure (ParsVDS Ubuntu VPS, mini-digi deployment). Kept here so I stop re-Googling the same fail2ban jail config every time.
