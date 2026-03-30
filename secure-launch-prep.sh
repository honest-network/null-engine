#!/bin/bash
# ==============================================================================
# SCRIPT: secure-launch-prep.sh
# PURPOSE: OPSEC Protocol for Zero-Day Launch. Wipes personal git history,
# establishes anonymous commit metadata, and prepares the sovereign push.
# ==============================================================================

echo "========================================================="
echo "  HONEST PROTOCOL - OPERATION ZERO-DAY PREP              "
echo "========================================================="
echo ""
echo "[CAUTION] This script will establish your Sovereign Identity."
echo "[CAUTION] It will erase your local Git history to ensure your personal"
echo "[CAUTION] name and email are NOT leaked in the public commit ledger."
echo ""

read -p "Are you actively running a VPN right now? (y/n): " vpn_status
if [[ "$vpn_status" != "y" ]]; then
    echo "[!] ABORTING. Turn on a VPN before proceeding to mask your physical IP."
    exit 1
fi

echo ""
read -p "Enter your new Anonymous GitHub Username/Org (e.g. honest-protocol): " anon_user
read -p "Enter your new ProtonMail Email (e.g. honest-protocol@proton.me): " anon_email

if [[ -z "$anon_user" || -z "$anon_email" ]]; then
    echo "[!] Username and Email are required. Aborting."
    exit 1
fi

echo ""
echo "[1/5] Wiping Personal Git History and Identity Footprint..."
if [ -d ".git" ]; then
    rm -rf .git
    echo "[OK] Personal Git History Erased."
else
    echo "[OK] No active .git directory found."
fi

echo "[2/5] Initializing Anonymous Sovereign Repository..."
git init -b main

echo "[3/5] Configuring Anonymous Identity Matrix (Isolated from Work Config)..."
# By NOT using --global, this ensures your work git config is never touched.
git config user.name "$anon_user"
git config user.email "$anon_email"
echo "  -> Local User set to: $(git config user.name)"
echo "  -> Local Email set to: $(git config user.email)"

echo ""
echo "[4/5] Generating Air-Gapped SSH Burner Key..."
# Creates a dedicated key just for this project so work GitHub credentials don't interlope.
KEY_PATH="$HOME/.ssh/id_honest_burner"
if [ ! -f "$KEY_PATH" ]; then
    ssh-keygen -t ed25519 -C "$anon_email" -f "$KEY_PATH" -N "" -q
    echo "[OK] Generated new burner key at $KEY_PATH"
else
    echo "[OK] Burner key already exists at $KEY_PATH"
fi

# Forces this specific Git repository to ONLY use the new burner key, ignoring global corporate SSH configs.
git config core.sshCommand "ssh -i $KEY_PATH -F /dev/null -o IdentitiesOnly=yes -o StrictHostKeyChecking=no"

echo ""
echo "[5/5] Committing Null Engine v6.0.0 Genesis Block..."
git add .
git commit -m "Genesis: The Null Engine v6.0.0 (Omnidirectional Audit Engine)"

echo ""
echo "========================================================="
echo "  LOCAL PREP COMPLETE. READY FOR AIR-GAPPED PUSH.        "
echo "========================================================="
echo ""
echo "CRITICAL: You are bypassing your corp credentials. Here is your Burner Public Key:"
echo "---------------------------------------------------------"
cat "${KEY_PATH}.pub"
echo "---------------------------------------------------------"
echo "Next Steps to Launch:"
echo "1. Create your blank GitHub repository for '$anon_user/null-engine'."
echo "2. Go to Settings -> SSH and GPG Keys in your new anonymous GitHub account."
echo "3. Click 'New SSH Key' and paste the exact line above starting with 'ssh-ed25519'."
echo "4. Return to this terminal and run:"
echo "   git remote add origin git@github.com:$anon_user/null-engine.git"
echo "   git push -u origin main"
echo ""
echo "Godspeed."
