# EDPD Skill Ledger

Intent: Track every marked item behind the essence-driven-product-development skill and its current state.

IDs use the `EDPD-` prefix so they never collide with a product system's IDs. Items change state; they are never deleted. Every item up to EDPD-D13 was raised by Rubens; Claude wrote the entries, so Git commit authors show who committed, not who raised an item, and each log line names its author with `by:` (EDPD-D12). On a state change: search the skill for the ID, re-gate every statement citing it, update the entry, and add a dated log line.

States — A: open → verified | falsified | retired · D: active → reversed | superseded · C: active → lifted | superseded · Q: open → answered | dropped

## Assumptions

### EDPD-A1

Unmarked assumptions become perceived fact through retelling.

- State: open
- Source: practitioner observation, unverified.
- Cited in: Intro (purpose)
- Log:
  - 2026-09-28 defined.

### EDPD-A2

Padding is the default in human-written product material.

- State: open
- Source: practitioner observation, unverified.
- Cited in: EDPD-D3
- Log:
  - 2026-09-28 defined.

### EDPD-A3

Extra marker categories cause classification disputes without improving traceability.

- State: open
- Source: partly supported. Shipman & Marshall 1999 (formal categorization adds overhead, causes avoidance); RAID letters drift in meaning. Not supported: kappa agreement tends to rise with more categories. Traceability half holds by design (IDs + citations).
- Cited in: EDPD-D2
- Log:
  - 2026-09-28 investigated; remains open. Proposed test: two reviewers gate same artifacts with 4 vs 5 markers, compare disagreement.

### EDPD-A4

Persisted documents derived from the ledger drift from it.

- State: open
- Source: observed in Notion use (unrequested pages).
- Cited in: EDPD-D7
- Log:
  - 2026-09-28 defined.

### EDPD-A5

Imposed form stops a method from fitting systems already in place.

- State: open
- Source: owner feedback 2026-09-28.
- Cited in: EDPD-D11
- Log:
  - 2026-09-28 defined.

### EDPD-A6

Essence-form records carry less context, so the person who raised an item is the main route to the rest.

- State: open
- Source: owner feedback 2026-09-28.
- Cited in: Authorship; EDPD-D12
- Log:
  - 2026-09-28 defined, by: Rubens.

## Decisions

### EDPD-D1

One rule set for all material, no templates.

- State: active
- Reason: the invariant does not depend on type.
- Cited in: Core and form
- Log:
  - 2026-09-28 defined.
  - 2026-09-28 reworded: 'artifact types' → 'material' (ledger model).

### EDPD-D2

Vocabulary is fixed at an intent and four markers.

- State: active
- Reason: EDPD-A3.
- Cited in: Vocabulary
- Log:
  - 2026-09-28 defined.
  - 2026-09-28 reworded: 'intent line' → 'intent' (form now flexible, EDPD-D11).

### EDPD-D3

The gate admits no exceptions or deferred cleanup on the core.

- State: active
- Reason: EDPD-A2; the invariant holds only if it holds everywhere.
- Cited in: Strictness
- Log:
  - 2026-09-28 defined.
  - 2026-09-28 narrowed to the core (EDPD-D11).

### EDPD-D4

Open-question marker is Q, not ?.

- State: active
- Reason: letter IDs match A, D, C and are safe in search, regex, and filenames.
- Cited in: Markers (marker update note)
- Log:
  - 2026-09-28 changed from ? to Q; legacy markers converted on sight.

### EDPD-D5

Records and references to them persist after resolution.

- State: active
- Reason: a reopened item must remain traceable.
- Cited in: Resolution and traceback
- Log:
  - 2026-09-28 defined.
  - 2026-09-28 reworded: citations → records and references (ledger model).

### EDPD-D6

Keep four markers; do not merge into two (evidence vs choice).

- State: active
- Reason: owner decision after merge analysis (Q and C can fold into A/D; rejected).
- Cited in: Vocabulary
- Log:
  - 2026-09-28 decided by Rubens.
  - 2026-09-28 added to SKILL.md.

### EDPD-D7

The ledger is the single source of truth; documents are temporary views.

- State: active
- Reason: EDPD-A4.
- Cited in: Core and form; The ledger; Views
- Log:
  - 2026-09-28 defined.

### EDPD-D8

Notion, decision log, and Git ADRs share one fixed model.

- State: superseded
- Reason: EDPD-D1.
- Cited in: (none; superseded)
- Log:
  - 2026-09-28 defined.
  - 2026-09-28 superseded by EDPD-D11 (owner: too strict on form). Affected: none.

### EDPD-D9

Verified facts stay in the ledger as verified records.

- State: active
- Reason: EDPD-D7 requires the ledger to be complete on its own.
- Cited in: Classifying
- Log:
  - 2026-09-28 defined.

### EDPD-D10

Decisions may start as proposed where the system supports it.

- State: active
- Reason: matches ADR practice.
- Cited in: Resolution and traceback
- Log:
  - 2026-09-28 defined; narrowed to 'where the system supports it' with EDPD-D11.

### EDPD-D11

Enforce only the core mechanisms; adapt all form to the existing system, and create nothing when none exists without the user's answer.

- State: active
- Reason: EDPD-A5.
- Cited in: Core and form; Strictness
- Log:
  - 2026-09-28 defined; supersedes EDPD-D8.

### EDPD-D12

Every record and state change names its author; rely on the system only where it records the same person automatically and reliably.

- State: active
- Reason: EDPD-A6.
- Cited in: Core and form; Authorship; Strictness
- Log:
  - 2026-09-28 defined, by: Rubens.

### EDPD-D13

The skill ledger is LEDGER.md in the public skill repository; SKILL.md links to it and holds no copy.

- State: active
- Reason: readers of the public skill can trace its rules to their records; EDPD-D7.
- Cited in: Design record
- Log:
  - 2026-10-01 defined, by: Rubens. Migrated from the Notion page "EDPD Skill Ledger"; SKILL.md's record list replaced by a link. Affected: none.

## Questions

### EDPD-Q1

Should strictness relax by artifact type or product maturity?

- State: open
- Owner: Rubens.
- Cited in: Strictness
- Log:
  - 2026-09-28 defined (from former "for now" hedge).
