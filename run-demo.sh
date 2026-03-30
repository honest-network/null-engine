#!/bin/bash

echo "========================================================="
echo "  HONEST PROTOCOL - JAVA 25 GRADLE DRY RUN               "
echo "========================================================="

cd honest-core

# Remove Maven entirely
rm -f pom.xml mvnw mvnw.cmd

if [ ! -f "gradlew" ]; then
    echo "[!] Gradle Wrapper missing. Bootstrapping raw wrapper..."
    curl -s -L -o gradlew https://raw.githubusercontent.com/gradle/gradle/master/gradlew
    chmod +x gradlew
    mkdir -p gradle/wrapper
    
    # Force latest Gradle version to support bleeding edge Java 25
    echo "distributionUrl=https\://services.gradle.org/distributions/gradle-8.11-bin.zip" > gradle/wrapper/gradle-wrapper.properties
    
    # Download the wrapper jar specifically
    curl -s -L -o gradle/wrapper/gradle-wrapper.jar https://raw.githubusercontent.com/gradle/gradle/master/gradle/wrapper/gradle-wrapper.jar
    echo "[✓] Gradle 8.11 Wrapper installed."
fi

echo ""
echo "[1/3] Compiling Project & Auto-Provisioning JDK 25..."
./gradlew classes --quiet

echo ""
echo "[2/3] Executing JUnit Protocol Tests..."
./gradlew test --quiet

echo ""
echo "[3/3] Booting Local Application Node..."
./gradlew run --quiet

echo ""
echo "========================================================="
echo "  DRY RUN COMPLETE                                       "
echo "========================================================="
