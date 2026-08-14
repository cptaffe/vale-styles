# STE

The enforceable core of
[ASD-STE100](https://www.asd-ste100.org) Simplified Technical English
(Issue 9, 2025): 53 writing rules and a dictionary of about 900 approved
words. The writing rules with a regular shape live here; the dictionary
appears only as its canonical published pairs, filtered against the
rules that write-good and RedHat already carry. The rest needs a
part-of-speech tagger, which a pattern matcher does not have.

| Rule | Level | Catches |
| --- | --- | --- |
| `GoneFrom` | error | `gone from`—state the operation: `removed from`, `changed from` |
| `AbsentActor` | warning | `nobody has built`—name the condition, not the culprit |
| `ApprovedWords` | suggestion | `verify`, `carry out`—the STE dictionary's canonical pairs |
| `BuriedInstruction` | suggestion | `X here lets ...`—state the instruction, then the why |
| `ComplexVerbs` | suggestion | `has been configured`—STE allows only simple tenses |
| `ImperativeOpeners` | suggestion | `Returns the ...`—PEP 257 imperative mood |
| `ParagraphLength` | suggestion | Paragraphs past 6 sentences |
| `SentenceLength` | suggestion | Sentences past 25 words |
