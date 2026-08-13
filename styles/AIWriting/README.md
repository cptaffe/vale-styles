# AIWriting

Signs of AI writing from
[Wikipedia:Signs_of_AI_writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)
that the published
[signs-of-ai-writing](https://github.com/ammil-industries/vale-signs-of-ai-writing)
package does not catch, plus tells collected from this assistant's own
output.

| Rule | Level | Catches |
| --- | --- | --- |
| `ModelArtifacts` | error | Leaked chatbot markup: `[cite: 3]`, `grok_card`, `turn0search2` |
| `SpacedHyphen` | error | A spaced hyphen doing an em dash's job |
| `ChallengesFormula` | warning | `Despite these challenges`, `future outlook` |
| `CountContrast` | warning | `Two panes, one door` slogan fragments |
| `EmojiDecoration` | warning | Emoji as a bullet or heading ornament |
| `NegativeParallelism` | warning | `It's not just X — it's Y` |
| `ParticipleTail` | warning | `, highlighting the team's commitment...` |
| `PromotionalLanguage` | warning | `nestled`, `world-class`, `seamlessly` |
| `ThematicBreakHeading` | warning | A horizontal rule directly before a heading |
| `VagueAttribution` | warning | `Experts argue`, `Industry reports` |
| `AssistantTells` | suggestion | Filler words LLMs lean on |
| `Didactic` | suggestion | `Let's dive into`, `In this article` |
| `InlineHeaderList` | suggestion | Bold-run-in list items |
| `RuleOfThree` | suggestion | `streamlining X, boosting Y, and fostering Z` |
| `SectionSummary` | suggestion | `In conclusion,`, `In summary,` |
