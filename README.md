# pleasantry — development transcripts

This branch holds the Positron Assistant conversation exports from building the
[pleasantry](https://github.com/amelia-m/pleasantry) package, so the workflow
that produced it is readable alongside the result.

The package was written at posit::conf(2026), in Hadley Wickham and Jenny
Bryan's [Modern R workflow (ft. Positron and
AI)](https://github.com/posit-conf-2026/modern-r-workflow) workshop on Monday,
September 14, and built out afterwards until the workshop's allocated AI
credits ran out. Every line of it was written with Positron Assistant.

## What is here

| File | Size | What it is |
|---|---|---|
| `convos/conversation-export.md` | 607 KB | the conversation as Markdown, the readable one |
| `convos/conversation-export.html` | 13 MB | the same conversation with Positron's own formatting |
| `convos/conversation-export.json` | 1.8 MB | the structured export, including tool calls |

The design decisions are summarised, far more briefly, in
[`dev-history.md`](https://github.com/amelia-m/pleasantry/blob/main/dev-history.md)
on the main branch. The transcripts are the raw record behind it: the dead ends
included, among them the `weirdness` argument going through four designs and a
late refactor merging two redundant arguments into one.

## Why a separate branch

These files are 15 MB against a 12 KB package. `R CMD build` excluded them, but
installing from GitHub fetches a snapshot of the default branch, so every
`pak::pak("amelia-m/pleasantry")` was paying 15 MB for them. Keeping them on an
orphan branch leaves them public and linkable while taking them out of the
package tree.

They are a record of what was said while building the package, not
documentation, so they are not kept current.
