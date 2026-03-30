# Honest Protocol: SMT Domain State Machine

The Honest Protocol does not rely on fluid conversational prompting. It treats the interaction as a deterministic State Machine, evaluating the output against a hard-coded set of constraints before ever presenting it as valid.

This is the state loop executed natively by the Antigravity IDE and the Java Execution Verifier.

```mermaid
stateDiagram-v2
    [*] --> Initialization
    
    state Initialization {
        LoadDataset: Inject HP-GOLDEN-DATASET-01
        LoadFlags: Inject HP-FAILURE-MODES-01
        SetPersona: Apply "Adversarial Auditor" Instruction
    }
    
    Initialization --> Generation: Send Query
    
    state Generation {
        LLM: Target Frontier Model processes tokens
    }
    
    Generation --> Verification: Raw JSON Trace
    
    state Verification {
        check_pliant: Matches "Pliant Agreement"?
        check_mirror: Matches "Jargon Mirror"?
        check_soften: Matches "Prose Softening"?
        check_equiv: Matches "Both sides..."?
        
        check_pliant --> Protocol_Breach: Yes
        check_mirror --> Protocol_Breach: Yes
        check_soften --> Protocol_Breach: Yes
        check_equiv --> Protocol_Breach: Yes
    }
    
    Verification --> Cryptographic_Signing: 0 Flags Triggered
    Protocol_Breach --> Cryptographic_Signing: Registers as [Equivocation Block]
    
    state Cryptographic_Signing {
        Keccak256_Hash
        IPFS_Upload
    }
    
    Cryptographic_Signing --> Immutable_Ledger
    Immutable_Ledger --> [*]
```
