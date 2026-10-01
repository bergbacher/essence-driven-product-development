# Essence-Driven Product Development

Source of truth for two skills:

- **essence-driven-product-development** (EDPD) keeps a product's knowledge as one ledger of essence-form, marked, linked records (assumptions, decisions, constraints, open questions) in whatever system the team already uses, and answers every request for a document with a view generated from that ledger. The method is in [SKILL.md](essence-driven-product-development/SKILL.md).
- **find-essence** reduces text to the shortest version with the same meaning. EDPD uses it to reduce every statement, and it also works on its own. The method is in [SKILL.md](find-essence/SKILL.md).

Install both. EDPD does not work without find-essence.

## How EDPD works

*View on EDPD skill ledger, 2026-10-01 (EDPD-D7, EDPD-D9, EDPD-D11, EDPD-D12)*

```mermaid
flowchart TD
    input["Incoming material<br/>notes · drafts · meetings · existing docs"]

    subgraph GATE["The gate — core, always enforced"]
        direction TB
        intent{"Intent clear?"}
        reduce["Reduce to essence<br/>(find-essence)"]
        mark["Mark every non-fact<br/>A assumption · D decision<br/>C constraint · Q open question"]
        link["Link: name the IDs<br/>each record depends on"]
        check{"Check: IDs exist · none defined twice<br/>every record has an author"}
        intent -- yes --> reduce --> mark --> link --> check
    end

    ask["Ask the author<br/>one question"]

    subgraph LEDGER["Ledger — single source of truth"]
        direction TB
        records[("Records<br/>ID · type · statement · state · basis · author")]
        form["Form adapts to what exists<br/>Notion database · decision log · ADRs · spreadsheet<br/>Nothing exists → ask first, create nothing"]
    end

    request["Someone asks<br/>a question, a deck, a spec, an update"]
    view["View — generated on request<br/>any name and format · adds nothing · cites IDs<br/>in the reply unless asked to save"]

    change["A record changes state<br/>verified · falsified · reversed · answered"]
    trace["Traceback<br/>affected set = every record naming the ID"]

    input --> intent
    intent -- no --> ask
    check -- "needs author" --> ask
    ask -. answer .-> intent
    check -- "write records" --> records
    request --> view
    records -- "read current state" --> view
    view -. "gap found → propose record" .-> intent
    records --> change --> trace
    trace -- "re-gate affected records" --> intent
```

## Layout

```
LEDGER.md                                     EDPD skill ledger: the records behind EDPD's rules
essence-driven-product-development/SKILL.md   EDPD
find-essence/SKILL.md                         find-essence
find-essence/references/fluff-patterns.md     fluff-pattern catalog used by find-essence
install.sh                                    symlink into ~/.claude/skills and/or ~/.codex/skills
package.sh                                    build dist/<skill>.zip for claude.ai upload
```

## Install locally

```bash
./install.sh claude
```

If the skills are also synced from claude.ai (`~/.claude/skills/synced/…`), both copies load; the script warns when it finds one.

## Publish to claude.ai

```bash
./package.sh
```

Upload `dist/essence-driven-product-development.zip` and `dist/find-essence.zip` in claude.ai's skill settings, replacing the current versions.

## Changing a skill

EDPD passes its own gate. A change to its rules starts as an entry in [LEDGER.md](LEDGER.md) (`EDPD-A`, `-D`, `-C`, `-Q`, with basis and author), and the rule text in SKILL.md follows from that entry. Entries are never deleted; they change state, with a dated log line.
