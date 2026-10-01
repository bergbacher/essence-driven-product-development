---
name: find-essence
description: Boil fluffy, padded, or bloated text down to its essence — the minimal set of words that carries the full meaning. Use this skill whenever the user asks to find the essence, distill, condense, tighten, de-fluff, de-bloat, cut the padding, or make something precise; whenever they want a precise definition or a precise description of something; and whenever another skill or workflow needs text (definitions, descriptions, requirements, summaries, prompts) reduced to only what is load-bearing. Also use it when the user pastes a paragraph and asks "what is this actually saying?" This is an anti-fluff, anti-bloat tool, not a summarizer — it removes what carries no meaning and keeps everything that does.
---

# Find Essence

Take a piece of text and reduce it to its essence: the smallest version that still means exactly the same thing. Nothing that carries meaning is removed; nothing that carries no meaning survives.

This is not summarization. A summary drops information to save space. Essence-finding drops only words that were never carrying information in the first place. If the reader would believe, predict, or do anything differently after a cut, the cut went too far.

## The core test: removal

For every unit of the text (word, phrase, clause, sentence, paragraph), ask:

> If I remove this, does the text still say the same thing?

- **Yes** → it is not part of the essence. Remove it.
- **No** → it is load-bearing. Keep it (though it may still be sayable in fewer words).

"Says the same thing" is strict. Meaning has changed if any of the following changed:

- **The claim** — what is asserted to be true.
- **The scope** — what it applies to (all / some / this case; always / usually / under condition X).
- **The confidence** — how sure the author is ("is" vs "is probably" vs "may be").
- **The action** — what the reader is supposed to do, or in what order.
- **The distinction** — what separates this thing from its nearest neighbors.

Hedges like "usually" or conditions like "unless the file is locked" often *look* like fluff but change scope or confidence. Test them like everything else; do not cut by category.

## Secondary tests

Apply after the removal test to what remains.

**Substitution test.** Can this be said with a shorter or plainer word or phrase, with no change in meaning? ("in order to" → "to", "at this point in time" → "now", "has the ability to" → "can", "utilize" → "use"). If yes, substitute.

**Redundancy test.** Does any other part of the text already say this? If yes, one copy is enough. Watch for restatements ("in other words…"), doubled pairs ("each and every", "basic and fundamental"), and a summary sentence that repeats the body.

**Function test.** Does this unit tell the reader something, or does it talk *about* the telling? Meta-commentary ("it is important to note that", "as mentioned above", "in this section we will") is almost never essence. Confirm with the removal test, then cut.

**Falsifiability test.** Could this unit be wrong? A statement that cannot be wrong ("this is a powerful and flexible approach", "quality matters") usually carries nothing. Statements that could be wrong ("this approach fails when N > 10⁶") are essence.

## Completeness check (the guardrail against over-cutting)

After cutting, compare the result against the original and list every meaning the original had. Confirm each one is still present. If one is missing, restore the smallest unit that carries it.

Essence is the *shortest text with the same meaning*, not the shortest text. When in doubt between two versions with the same meaning, prefer the shorter one; when in doubt whether the meaning is the same, prefer the one that keeps it.

## Characteristics of essence

Use these to recognize essence and to check the result.

1. **Load-bearing** — every unit fails the removal test.
2. **Non-redundant** — no unit repeats another.
3. **Complete** — every meaning in the original is still present.
4. **Concrete** — meaning sits in nouns and verbs. Adjectives and adverbs are suspects; keep only those that change the claim.
5. **Falsifiable** — it says something that could be wrong.
6. **Differentiating** — for definitions and descriptions, it says what makes this thing *this thing* and not its nearest neighbor.
7. **Unhedged unless the hedge is the point** — confidence is stated once, precisely, not padded.
8. **Ordered by weight** — the most load-bearing unit comes first.

## Procedure

1. **Identify the job of the text.** What is it for — a definition, a description, an instruction, an argument, a requirement? The job decides what counts as meaning. (A definition's job is to differentiate; an instruction's job is to make the reader act correctly.)
2. **Segment.** Split into sentences, then clauses, then phrases.
3. **Run the removal test on every unit**, largest first (paragraphs → sentences → clauses → words). Cut what fails.
4. **Run the secondary tests** on what survives.
5. **Run the completeness check** against the original. Restore anything lost.
6. **Order by weight.** Put the most load-bearing statement first.
7. **Read it once more** as a stranger. If anything is now ambiguous that wasn't before, fix it — ambiguity is a meaning change.

## Definitions and descriptions

The skill is often used to produce precise definitions and descriptions. For these:

- A definition names the category the thing belongs to, then what separates it from everything else in that category. Nothing else. ("A mutex is a lock that at most one thread can hold at a time.")
- A description states the properties that would let a reader identify the thing, predict its behavior, or use it — and no others. Test each property: if a reader who didn't know it would act or predict identically, it isn't essence.
- Do not include why the thing is good, its history, or how the author feels about it, unless the job of the text is to say so.

## Output

Default: return the essence only, as plain text, with no preamble.

If the user asks (or another skill needs it), add a **Removed** section listing what was cut and which test it failed, grouped by test. Keep the list terse — one line per cut.

If the text has more than one job (e.g., a definition followed by usage rules), keep the structure that separates them; the removal test applies inside each part.

When operating as a step for another skill, treat the input as the text to reduce and the output as a drop-in replacement for it. Do not add commentary the downstream skill did not ask for.

## Example

**Input:**

> It's really important to understand that, at the end of the day, caching is basically a very powerful and useful technique that allows you to store the results of expensive operations so that, in the future, when the same operation is requested again, you can simply return the stored result instead of having to recompute it from scratch all over again, which can be quite slow.

**Essence:**

> Caching stores the result of an expensive operation so a repeated request returns the stored result instead of recomputing it.

**Removed:**

- Function test: "It's really important to understand that", "at the end of the day", "basically"
- Falsifiability test: "very powerful and useful technique"
- Redundancy test: "in the future", "again", "from scratch all over again", "which can be quite slow" (already implied by "expensive")
- Substitution test: "allows you to store" → "stores"; "having to recompute" → "recomputing"

Completeness check: claim (stores results), mechanism (return stored on repeat), condition (expensive operation) all present.

## Common fluff patterns

See `references/fluff-patterns.md` for a catalog of patterns that usually fail the tests. Use it to spot candidates faster, not to cut by rule — every candidate still has to fail the removal test.
