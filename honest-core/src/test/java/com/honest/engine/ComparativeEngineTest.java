package com.honest.engine;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class ComparativeEngineTest {

    @Test
    public void testHereticDelta_DetectsDistortedFact() {
        ComparativeEngine engine = new ComparativeEngine();
        
        // Emulate querying the node for an event
        String result = engine.calculateHereticDelta("Test Conflict Event");
        
        assertTrue(result.contains("omnidirectional_motivation_matrix"), "Should generate the Omnidirectional JSON structure");
        assertTrue(result.contains("cognitive_dehumanization_index"), "Should include the psychological empathic shield trace");
        assertTrue(result.contains("vector_us_nato_hegemony"), "Must map the specific globalist vectors");
    }
}
