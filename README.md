# vale-styles

Hand-written [Vale](https://vale.sh) styles, packed as local zips.

## Styles

- `AIWriting` — signs of AI writing from
  [Wikipedia:Signs_of_AI_writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)
  that the published
  [signs-of-ai-writing](https://github.com/ammil-industries/vale-signs-of-ai-writing)
  package does not catch.
- `STE` — the part of ASD-STE100 Simplified Technical English a linter can
  check.
- `Grammar` — fixed word swaps ported from a grammar checker.

## Use

Build the zips with `make`. Then point the global `.vale.ini` at them:

```ini
Packages = /path/to/vale-styles/dist/AIWriting.zip, \
           /path/to/vale-styles/dist/STE.zip, \
           /path/to/vale-styles/dist/Grammar.zip
```

To change a rule: edit it here, run `make`, then run `vale sync`.
