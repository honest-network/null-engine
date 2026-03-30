DOCUMENT ID: HP-PROPAGANDA-VECTORS-01 (DISARM INTEGRATION Phase 4)
STATUS: ACTIVE

This document defines the strict vocabulary the LLM Auditor must use to label Information Operations (IO) and manipulation tactics. The Honest Protocol operates natively on the DISARM (Disinformation Analysis and Risk Management) foundation, aligning output directly with global OSINT and cybersecurity standards.

## 1. Tactical Identifiers (TTPs)
An analysis of a primary source is INCOMPLETE if it fails to explicitly check against this matrix and output the corresponding Tactic ID.

### A. Narrative Generation & Amplification
- **[T0014] Amplify via Astroturfing:** The practice of masking the sponsors of a message (e.g., a State-funded Think Tank) to make it appear as though it originates from grassroots or independent academic consensus.
- **[T0087] Distort Facts (Strawman/False Equivalence):** The attempt to draw an equivalence between two subjects based on flawed reasoning, or misrepresenting an opponent's argument. Highly prevalent in syndicated 'neutral' news analyzing an asymmetric conflict.
- **[T0038] Launder Information:** Funneling compromised or engineered narratives through seemingly legitimate news aggregators or secondary outlets to obscure the primary source.

### B. Psychological & Linguistic Anchoring
- **[T0113] Emotional Anchoring (Fear/Anger):** Pre-emptively using hyper-charged adjectives (e.g., "brutal," "historic necessity," "sacred duty") to establish the reader's emotional state before presenting factual data.
- **[T0092] Thought-Terminating Cliché:** Phrases designed to end cognitive dissonance without solving it ("It's just common sense," "The international community agrees").
- **[T0091] Omission in Context:** Excluding critical historical precedents (e.g., a prior territorial dispute or NGO funding stream) that radically changes the causal timeline.

## Rule Execution
When `NarrativeTracer.java` calculates an Echo Chamber vector between Source A and Outlet B, the LLM must execute a DISARM mapping:
*Did Outlet B inject [T0113]? Did Source A execute [T0038] by masking its intent?* Output must be hardcoded in JSON with the exact T-Code.
