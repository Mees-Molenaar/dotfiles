# claude-config

My personal [Claude Code](https://claude.com/claude-code) global configuration:
the `CLAUDE.md` instructions and custom skills, versioned and reusable across
machines.

## Contents

- `CLAUDE.md` — global instructions (learning mode, design principles, how
  decisions/learnings are captured, session logs).
- `skills/` — custom skills:
  - `jira` — fetch Jira ticket details via `acli`.
  - `propose-next` — TDD mentor that proposes the next smallest step.
  - `simple-architecture` — Socratic design review (Hickey's *Simple Made Easy*).
  - `small-batches` — slice work into independently shippable batches (DORA).

## Layout

These files live in this repo and are **symlinked** into `~/.claude` so Claude
Code reads them in place:

```
~/.claude/CLAUDE.md  ->  ~/dotfiles/claude-config/CLAUDE.md
~/.claude/skills     ->  ~/dotfiles/claude-config/skills
```

## Install on a new machine

```sh
git clone git@github.com:Mees-Molenaar/claude-config.git ~/dotfiles/claude-config
cd ~/dotfiles/claude-config
./install.sh
```

The script backs up any existing `~/.claude/CLAUDE.md` and `~/.claude/skills`
before creating the symlinks.
