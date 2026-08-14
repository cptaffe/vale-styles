# vale-styles

Hand-written [Vale](https://vale.sh) styles, packed as local zips, plus the
global Vale config and the pre-commit hook that runs it.

## Styles

- `AIWriting`—signs of AI writing from
  [Wikipedia:Signs_of_AI_writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)
  that the published
  [signs-of-ai-writing](https://github.com/ammil-industries/vale-signs-of-ai-writing)
  package does not catch.
- `STE`—the part of ASD-STE100 Simplified Technical English a linter can
  check.
- `Grammar`—fixed word swaps ported from a grammar checker.

The layout follows
[vale-boilerplate](https://github.com/errata-ai/vale-boilerplate): each
style lives under `styles/` with its own `README.md` and `meta.json`, and
vocabularies live under `styles/config/vocabularies/`.

```text
.
├── .vale.ini
├── Makefile
├── githooks
│   └── pre-commit
└── styles
    ├── AIWriting
    │   ├── AssistantTells.yml
    │   ├── ...
    │   ├── README.md
    │   └── meta.json
    ├── Grammar
    └── STE
```

## Config, hook, and word lists

- `.vale.ini.in`—template for the global Vale config. `make config`
  fills in the home and repo paths and installs the result at
  `~/Library/Application Support/vale/.vale.ini`.
- `githooks/pre-commit`—runs Vale over staged prose and blocks on errors;
  chains to a repo's own hook first, and runs Harper as an advisor.
## Word lists

One source of truth feeds both spellcheckers. `words/base.txt` holds
technical terms and `words/local.txt` holds employer-specific ones. Both
stay gitignored and never leave the machine—a word list names the tech
stack it describes. `bin/words` concatenates the two and renders each
consumer's format:

- the Vale vocabulary
  (`~/Library/Application Support/vale/styles/config/vocabularies/Technical/accept.txt`,
  named by `Vocab = Technical`), and
- Harper's dictionary
  (`~/Library/Application Support/harper-ls/dictionary.txt`—words only,
  sorted).

The pre-commit hook re-renders whenever a source file is newer than the
deployed vocabulary, so an edit to either list deploys on the next commit.
Run `bin/words` to deploy by hand. Harper's rule ignore list lives in the
hook.

## Install

Build the zips, symlink each piece into place, then sync:

```sh
make
make config
mkdir -p "$HOME/.githooks"
ln -s "$PWD/githooks/pre-commit" "$HOME/.githooks/pre-commit"
git config --global core.hooksPath "$HOME/.githooks"
bin/words
vale sync
```

`words/` starts empty on a fresh clone. Create `words/base.txt` (and
`words/local.txt` if needed), one word per line, then run `bin/words`.

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
`.md`, and only one gets it—here Vale is the server, and Harper advises
from the pre-commit hook.
