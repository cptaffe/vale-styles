# vale-styles

Hand-written [Vale](https://vale.sh) styles, packed as local zips, plus the
global Vale config and the pre-commit hook that runs it.

## Styles

- `AIWriting` — signs of AI writing from
  [Wikipedia:Signs_of_AI_writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)
  that the published
  [signs-of-ai-writing](https://github.com/ammil-industries/vale-signs-of-ai-writing)
  package does not catch.
- `STE` — the part of ASD-STE100 Simplified Technical English a linter can
  check.
- `Grammar` — fixed word swaps ported from a grammar checker.

## Config, hook, and word lists

- `.vale.ini` — the global Vale config. Its `StylesPath` is absolute, so it
  works from the repo and from its deployed path alike.
- `githooks/pre-commit` — runs Vale over staged prose and blocks on errors;
  chains to a repo's own hook first, and runs Harper as an advisor.
- `vocab/Technical` — the Vale vocabulary the config names with
  `Vocab = Technical`.
- `harper/dictionary.txt` — Harper's user dictionary, seeded from the Vale
  vocabulary. Without it Harper flags most technical terms as misspelled.
  Harper's rule ignore list lives in the hook.

## Install

Build the zips, symlink each piece into place, then sync:

```sh
make
mkdir -p "$HOME/Library/Application Support/vale/styles/config/vocabularies" \
         "$HOME/Library/Application Support/harper-ls" "$HOME/.githooks"
ln -s "$PWD/.vale.ini" "$HOME/Library/Application Support/vale/.vale.ini"
ln -s "$PWD/vocab/Technical" \
      "$HOME/Library/Application Support/vale/styles/config/vocabularies/Technical"
ln -s "$PWD/harper/dictionary.txt" \
      "$HOME/Library/Application Support/harper-ls/dictionary.txt"
ln -s "$PWD/githooks/pre-commit" "$HOME/.githooks/pre-commit"
git config --global core.hooksPath "$HOME/.githooks"
vale sync
```

To change a rule: edit it here, run `make`, then run `vale sync`.

## Language server in Claude Code

Claude Code starts language servers from plugins. A two-file plugin at
`~/.claude/skills/prose-lsp` runs `vale-ls`, so prose diagnostics reach
Claude as it edits files. Claude Code discovers it on start; the Installed
tab of `/plugin` lists it as `prose-lsp@skills-dir`.

`.claude-plugin/plugin.json`:

```json
{
  "name": "prose-lsp",
  "displayName": "Prose LSP (Vale)",
  "description": "Vale language server, so prose and comment diagnostics reach Claude as files are edited.",
  "version": "1.0.0",
  "lspServers": "./.lsp.json"
}
```

`.lsp.json`:

```json
{
  "vale": {
    "command": "/Users/cotaff/bin/vale-ls",
    "args": ["--vale-binary", "/opt/homebrew/bin/vale"],
    "extensionToLanguage": {
      ".md": "markdown",
      ".markdown": "markdown",
      ".txt": "plaintext",
      ".rst": "restructuredtext"
    },
    "diagnostics": true,
    "restartOnCrash": true,
    "maxRestarts": 3
  }
}
```

The first server to claim an extension wins, so map `vale-ls` to prose
files only; a claim on `.py` or `.ts` would block a real code server.

To run Harper as the server instead, set `command` to
`/opt/homebrew/bin/harper-ls` and `args` to `["--stdio"]`. Do not drop
the flag: harper-ls listens on TCP by default, Claude Code speaks stdio,
and without it the server starts but never connects. Both servers want
`.md`, and only one gets it — here Vale is the server, and Harper advises
from the pre-commit hook.
