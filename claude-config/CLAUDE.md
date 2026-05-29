# Global instructions

## Learning mode

When I say I'm in **learning mode** (or invoke `propose-next`), the goal is *me building
expertise*, not shipping fast. In this mode:

- **Never apply code edits unless I literally say "apply".** Propose patches; I type them
  by hand. The hand-typing is deliberate — it's where the retention comes from. Do not
  offer to "just do it for me".
- Work in the smallest TDD steps: one failing test + the minimal code to pass it
  (≈≤15 LOC). Drive this with the `propose-next` skill.
- Optimise for *understanding over speed*. Every step should say why it's the next move
  and what idea makes it click.

## Design — Simple Made Easy

Hold to Rich Hickey's *Simple Made Easy*: **simple = one role / one concept**, and that is
not the same as *easy* (familiar / close at hand). At a real design fork, use the
`simple-architecture` skill (Socratic What/Who/Why/How/When-Where, names complecting in
real time). Before reaching for state, inheritance, syntax/DSLs, or imperative loops, ask
whether values, à-la-carte polymorphism, plain data, or sequence functions cover it.

For slicing work into shippable pieces, use `small-batches`.

## Capturing decisions and learnings

Two separate stores, kept deliberately distinct:

- **Decisions** → markdown ADR-style files **in the project repo**, versioned with the
  code (e.g. `docs/decisions/NNN-title.md`). A decision worth recording is worth a short
  pass through `simple-architecture`; small implicit forks can be a one-liner in the
  session log. Don't make this a heavy ADR process for every diff.
- **Learnings** → two stages, never mixed:
  1. **Capture** (cheap, append-only, in the project): `learn capture "<insight>" --topic <tag>`
     appends to `learning/<date>/learnings-inbox.md`. Can never touch my vault.
  2. **Promote** (deliberate, into Obsidian): I review the inbox and promote keepers with
     `learn promote "<title>" --body "..."`. This uses exclusive-create and **never
     overwrites** an existing note. The vault path comes from `$OBSIDIAN_VAULT` /
     `~/.config/learn/vault` so it always lands in the right place.

**Do not write my learnings for me.** You may offer a one-line draft, but I rewrite it in
my own words — generating the sentence is the point. Mechanical capture (timestamps, the
diff) is fine to automate; the understanding is mine to write.

## Session log

Each learning session keeps `learning/<date>/log.md`: the goal, the open thread, and a
timestamped line as each step closes (so step duration is recoverable later).
