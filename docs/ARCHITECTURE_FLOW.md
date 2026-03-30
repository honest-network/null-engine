# Honest Protocol: Architecture Flow

This diagram illustrates the secure, deterministic flow of the Honest Protocol Network. It demonstrates how a query moves from the human operator, through the Antigravity workflow constraints, into the target frontier model, and finally onto the blockchain.

```mermaid
sequenceDiagram
    autonumber
    actor Human Node Operator
    participant AC as Antigravity Constraints (Workflows)
    participant JavaApp as Honest Core (Execution Verifier)
    participant LLM as Target Frontier Model (API)
    participant Crypto as Trace Signer (Keccak256)
    participant Ledger as Web3 Smart Contract
    
    Human Node Operator->>AC: Initiate Phase 2 Truth Vector Test
    Note over AC: Loads HP-FAILURE-MODES-01<br/>Loads HP-GOLDEN-DATASET-01
    AC->>JavaApp: Pass rigid context and system prompt
    JavaApp->>LLM: Dispatch Query + SMT Rules
    
    alt Model responds Honestly
        LLM-->>JavaApp: Raw trace: [Statistical Synthesis] + Unfiltered Truth
        JavaApp->>JavaApp: SMT Verifier: Detects 0 Red Flags
        JavaApp->>Crypto: Pass validated trace
        Crypto->>Ledger: Submit Validated "Truth Vector" proof
    else Model Censors/Equivocates
        LLM-->>JavaApp: "Both sides have valid points..."
        JavaApp->>JavaApp: SMT Verifier: Detects Red Flag ['Equivocation']
        Note over JavaApp: Records an [EQUIVOCATION BLOCK]
        JavaApp->>Crypto: Hash the failed sequence as proof of bias
        Crypto->>Ledger: Publish Bias Hash to Immutable Ledger
        Ledger-->>Human Node Operator: Return IPFS CID of Censorship Proof
    end
```
