---
name: "essence-driven-product-development"
description: "Gate and keep an Essence-Driven Product Development (EDPD) ledger: one source of truth of essence-form, marked, linked records (assumptions, decisions, constraints, open questions) held in whatever system the team already uses, with every document generated as a temporary view on request. Use whenever the user creates, reviews, or discusses product material, requirements, strategy, or decisions (even without saying EDPD), asks what a change affects, asks for a view, summary, deck, or explanation of the product, works with a ledger, decision log, or ADRs, or mentions essence-driven or \"our product system\". Requires find-essence."
---

Intent: Make Claude keep a product's knowledge as one ledger of essence-form, marked, linked records in whatever system is already in place, and answer every request for a document with a view generated from it.

# Essence-Driven Product Development (EDPD)

EDPD is a product methodology, as Agile and Lean are. Agile organizes work around iteration, Lean around removing waste from flow. EDPD organizes work around one invariant:

> Everything the product system knows is in its essence, and everything that is not verified fact is marked.

The purpose is traceability. Padding hides the thread: a vague strategy lets everyone read in what they want, a bloated requirement hides the real constraint, an unmarked assumption becomes "fact" after a few retellings (EDPD-A1). When every statement is minimal and every non-fact is marked, the chain vision → strategy → requirement → execution stays visible, and the impact of any change is a search.

## Core and form

EDPD fixes a few mechanisms, the same for all material, and nothing else (EDPD-D1, EDPD-D11).

**Core — always enforced:**

1. **One ledger** is the single source of truth (EDPD-D7).
2. **Essence** — every statement passes find-essence.
3. **Markers** — every non-fact is an assumption, decision, constraint, or open question, with a stable ID.
4. **Links** — every record names the IDs it depends on.
5. **No deletion** — records change state; changes are logged and traced.
6. **Views** — documents are generated from the ledger on request, add nothing, and are not a source of truth.
7. **Authorship** — every record and every state change names the person behind it (EDPD-D12).

**Form — adapt to what exists:** where the ledger lives, its layout, field names, ID scheme, state names, record templates (ADR, RAID, database row, list entry), and how views are named, formatted, and delivered. Use the existing convention. Do not restructure a working system to match this skill.

## Dependencies

Read the **find-essence** skill first. It supplies the removal test; this skill adds the product rules and does not restate it.

## The ledger

Whatever holds the product's records is the ledger: a Notion database, a decision-log file, ADRs in a repository, a spreadsheet, a RAID log. Before anything else, find it.

- **One exists** → use it as it is. Map its fields and states onto the core: a Notion "Status" is the state, an ADR's "Context" carries the basis, ADR numbers are the D IDs. Where it has no place for something the core needs (a dependency, a marker type), put it in the nearest existing field or in the text. Add a field or file only if the user agrees.
- **Several candidates** → ask which one is the ledger.
- **None exists** → ask where the ledger should live. Create nothing until the user answers, then create the smallest thing that holds the core.

One product system has one ledger.

Every record, in whatever form, must carry: an **ID**, its **type** (A, D, C, Q), a **statement** in essence form, a **state**, and a **basis** — source, reason, or owner — naming any IDs it depends on, and an **author**. Keep a dated trace of state changes where the system allows.

### Authorship

Essence-form records carry less context than people are used to, so the person who raised an item is the way back to the rest (EDPD-A6).

- **Author** = the person who raised the item, not whoever typed it. For a state change: the person who verified, decided, or answered.
- **Rely on the system** only where it records this automatically and reliably, and it names the same person: Notion "Created by" and page history, Git commit authors. If Claude writes the record, the system shows the writer, not the raiser; record the raiser explicitly.
- **Otherwise record it** in the record and in each state-change line: `by: <name>`.
- **Unknown author** → ask. A record without a known author is held, like any record that needs the author.

If the system has nothing yet, this is enough:

```
A1  Users abandon onboarding after ~60s.   open      source: support tickets Apr–Jun   by: Lena
C1  App Store review guideline 4.3.        active    source: Apple                     by: Tom
D1  Mobile first.                          active    reason: A1, C1                    by: Lena
Q1  Is offline mode required?              open      owner: Tom                        by: Sam
```

## Views

A view renders ledger records to answer one question or serve one purpose for one reader: a pitch deck for Project X, an onboarding spec, a stakeholder update, an impact report.

- **Only on request.** Do not create pages, docs, or files about the product unless asked. A question gets its answer in the reply.
- **Any name and format** the user wants. A saved view carries a light provenance note — a comment, footer, or subtitle such as `View on <ledger>, <date>` — not a fixed header.
- **Adds nothing.** Every statement comes from a record. Cite IDs where the format allows (inline, footnotes, speaker notes). If the view needs something the ledger lacks, name the gap and propose the record instead of filling it in.
- **Not a source of truth.** To change the product, change the ledger, then regenerate the view.

Incoming material — notes, drafts, meeting outcomes, existing documents — is not stored as-is. It goes through the gate and becomes records.

## Vocabulary

An intent and four markers (EDPD-D2, EDPD-D6).

**Intent** — what incoming material must make true, or what a view is for. find-essence's "same meaning" is judged relative to it. It can be a line, a title, or the user's request.

| Marker | Meaning | Test | Basis |
|---|---|---|---|
| `A` | **Assumption** — believed, not verified | Could this be false without anyone having made an error? | source |
| `D` | **Decision** — a choice among alternatives | Could a reasonable team have chosen differently? | reason |
| `C` | **Constraint** — imposed from outside (law, budget, platform, contract) | Is this given to us, not chosen or believed by us? | source |
| `Q` | **Open question** — unresolved | Does something depend on an answer we don't have? | owner |

> **Marker update:** The open-question marker changed from `?` to `Q` (`?1` → `Q1`) (EDPD-D4). Convert legacy `?` markers with the same number and mention the conversion.

If the existing system names these types differently, keep its names and map them.

### Classifying

Apply in order; the first match wins:

1. Verified, with a stated source → an assumption in its verified state. Facts stay in the ledger so it is complete on its own (EDPD-D9).
2. Imposed from outside → C.
3. Chosen among alternatives, with a reason → D. Without a reason → A until the reason is supplied.
4. Believed → A.
5. Unknown, and something depends on it → Q. If nothing depends on it, it does not belong in the ledger.

A choice of target, scope, or priority is a D. A claim about what is true is an A.

### IDs

Stable and unique; never reused, even after an item is resolved. Use the system's scheme if it has one. Otherwise number sequentially per type (A1, A2…). Changing an item's substance creates a new record that supersedes the old one.

## The gate

Runs on everything entering the ledger and on every view before it is returned. Do not skip steps because the text looks clean.

1. **Intent.** If unclear, infer it only if exactly one reading fits; otherwise ask.
2. **Reduce.** Apply find-essence. Everything that fails the removal test goes.
3. **Mark.** Classify every statement and turn it into a record.
4. **Link.** Name every dependency's ID in the basis.
5. **Check.** Every referenced ID exists. No ID is defined twice. Every record has an author. For a view: every statement comes from a record.

Write records that pass. Hold records that wait on the author.

## Rewrite or return

- **Intent clear, non-facts surfaced** → turn into records and say what changed.
- **Intent clear, but a statement rests on an unstated non-fact** → record it as an assumption and ask the author to confirm or verify.
- **Intent unclear, or the essence could be two different things** → do not guess. Ask the one question that resolves it.

Do not rewrite confidently where you had to invent the meaning. Choosing between readings is the signal to ask.

## Resolution and traceback

Records are never deleted; their state changes. Use the system's state names. If it has none: A open → verified | falsified | retired; D active → reversed | superseded; C active → lifted | superseded; Q open → answered | dropped. Use a draft or proposed state if the system has one (EDPD-D10).

On any state change:

1. Search the ledger for the ID.
2. The affected set is every record that names it. Nothing else.
3. Re-gate each affected record with the new state in place.
4. Trace the change: date, by whom, how, affected records.

- **Verified assumption** — the record stays, and so do references to it (EDPD-D5).
- **Answered question** — the answer becomes a new A, D, or C record that names the Q.
- **Empty affected set** — the item was not load-bearing. Say so.

## Output

- **Gating material:** the records written, then what changed and what needs the author, each only if not empty. Author questions are about the material; Q records are about the product and stay in the ledger.
- **A view:** in the format and under the name requested, with a light provenance note if saved.
- **Invoked by another skill:** output is a drop-in replacement for the input. Add nothing the caller did not ask for.

## Strictness

Uncompromising on the core, relaxed on form (EDPD-D3, EDPD-D11, EDPD-Q1):

- No statement that fails the removal test.
- No unmarked non-fact.
- No decision without a reason.
- No reference to an ID that does not exist.
- No record or state change without an author.
- No product document outside the ledger unless requested, and none that adds to it.
- No "we'll clean it up later."

When the gate rejects something, say so plainly. Never reject something only for its form.

## Example

**Input:**

> We believe that for our target users, who are mostly busy professionals, a really smooth and fast onboarding experience is absolutely critical, so we've decided to go mobile-first and keep onboarding to a single screen if at all possible, since research seems to suggest people drop off after about a minute.

**Records written** (in the ledger's own form; here, the minimal list):

```
A1  Users abandon onboarding after ~60s.   open    source: research, unverified   by: <author of input>
A2  Target users are busy professionals.   open    source: none stated            by: <author of input>
D1  Mobile first.                          active  reason: A2                     by: <author of input>
D2  Onboarding is one screen.              active  reason: A1                     by: <author of input>
```

**Changed:** removed "we believe", "really smooth and fast", "absolutely critical", "if at all possible", "seems to suggest".

**Needs author:** A2 — a claim about who the users are (A), or the choice of target group (D)? D2 — is "one screen" the decision, or "under 60 seconds"?

**Later:** "How are we approaching onboarding?" → answered in the reply, no page:

> Onboarding is one screen (D2), because users are assumed to abandon after ~60s (A1, unverified). The product is mobile first (D1), assuming target users are busy professionals (A2, no source).

**Later:** "Make a pitch deck for Project X" → a deck titled *Pitch deck — Project X*, built only from ledger records, IDs in the speaker notes, `View on product ledger, 2026-09-28` in the footer.

## Design record

This skill passes its own gate. Its IDs carry the `EDPD-` prefix so they never collide with a product's IDs; they do not enter any product ledger. They are recorded in the skill's ledger: https://github.com/bergbacher/essence-driven-product-development/blob/main/LEDGER.md (EDPD-D13).
