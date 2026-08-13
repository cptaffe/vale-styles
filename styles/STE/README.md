# STE

The enforceable core of
[ASD-STE100](https://www.asd-ste100.org) Simplified Technical English.
The rest of STE is a controlled list of about 900 approved words. No
pattern matcher can enforce that list on engineering prose.

| Rule | Level | Catches |
| --- | --- | --- |
| `AbsentActor` | warning | `nobody has built` — name the condition, not the culprit |
| `BuriedInstruction` | suggestion | `X here lets ...` — state the instruction, then the why |
| `ImperativeOpeners` | suggestion | `Returns the ...` — PEP 257 imperative mood |
| `SentenceLength` | suggestion | Sentences past 25 words |
