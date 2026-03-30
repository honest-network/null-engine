package com.honest.crypto;

import org.bouncycastle.jcajce.provider.digest.Keccak;
import org.bouncycastle.util.encoders.Hex;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;

@Component
public class TraceSigner {

    /**
     * Generates a Keccak-256 hash (standard Ethereum hash function) of the 
     * complete AI reasoning trace for immutability and verification on the blockchain.
     * This acts as the cryptographic fingerprint of the ontological delta.
     * 
     * @param rawLLMOutput The JSON string containing context, prompt, and generation.
     * @return The hex encoded hash ready for the smart contract.
     */
    public String generateVerificationHash(String rawLLMOutput) {
        Keccak.Digest256 digest256 = new Keccak.Digest256();
        byte[] hashbytes = digest256.digest(rawLLMOutput.getBytes(StandardCharsets.UTF_8));
        return "0x" + new String(Hex.encode(hashbytes));
    }
}
