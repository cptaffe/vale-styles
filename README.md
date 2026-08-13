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

## Config and hook

- `.vale.ini` — the global Vale config. Its `StylesPath` is absolute, so it
  works from the repo and from its deployed path alike.
- `githooks/pre-commit` — runs Vale over staged prose and blocks on errors;
  chains to a repo's own hook first.

## Install

Build the zips, symlink the config and the hook, then sync:

```sh
make
ln -s "$PWD/.vale.ini" "$HOME/Library/Application Support/vale/.vale.ini"
ln -s "$PWD/githooks/pre-commit" "$HOME/.githooks/pre-commit"
git config --global core.hooksPath "$HOME/.githooks"
vale sync
```

To change a rule: edit it here, run `make`, then run `vale sync`.
