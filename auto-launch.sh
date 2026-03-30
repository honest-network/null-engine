#!/bin/bash
# ==============================================================================
# SCRIPT: auto-launch.sh
# PURPOSE: Zero-Friction Social Deployment Matrix
# Automatically deep-links into Hacker News, Reddit, and X utilizing URL Intents.
# Automatically copies the necessary Markdown body text to the clipboard.
# ==============================================================================

if [ -z "$1" ]; then
    echo "========================================================="
    echo "  THE NULL ENGINE: AUTOMATED LAUNCH ROUTER               "
    echo "========================================================="
    echo "To deploy, run this script with one of the following targets:"
    echo "  ./auto-launch.sh hn      (Launches Hacker News via Deep Link)"
    echo "  ./auto-launch.sh reddit  (Launches r/LocalLLaMA via Deep Link)"
    echo "  ./auto-launch.sh x       (Launches Twitter/X via Deep Link)"
    echo ""
    echo "Make sure you are logged into your anonymous accounts in your browser first."
    exit 1
fi

COMMAND=$1

case $COMMAND in
    hn)
        echo "[1/3] Preloading Hacker News URL Intent..."
        HN_URL="https://news.ycombinator.com/submitlink?u=https://github.com/honest-network/null-engine&t=Show%20HN%3A%20The%20Null%20Engine%20-%20A%20Sovereign%20Java%2FLLM%20Framework%20to%20Audit%20Propaganda"
        
        echo "[2/3] Copying the exact 'Show HN' Comment payload to your clipboard..."
        # Extract everything after the 'The Initial Comment...' line
        awk '/Hey HN/{flag=1} flag' docs/LAUNCH_MATERIALS/HACKER_NEWS.md | pbcopy
        
        echo "[3/3] Opening Hacker News in Opera."
        echo "--> ACTION REQUIRED: When the page opens, simply click 'Submit'."
        echo "--> THEN: Go to your newly submitted post, click 'Add Comment', hit CMD+V to paste your clipboard, and submit the comment!"
        open -a Opera "$HN_URL"
        ;;
    
    reddit)
        echo "[1/3] Preloading r/LocalLLaMA Subreddit URL Intent..."
        TITLE="I%20built%20a%201-click%20script%20that%20uses%20local%20Dolphin-Llama3%20to%20mathematically%20expose%20state%20propaganda.%20It%20ignores%20all%20corporate%20safety%20filters."
        REDDIT_URL="https://www.reddit.com/r/LocalLLaMA/submit?title=${TITLE}"
        
        echo "[2/3] Copying the Reddit Body contents to your clipboard..."
        awk '/Hey everyone/{flag=1} flag' docs/LAUNCH_MATERIALS/REDDIT_LOCALLAMA.md | pbcopy
        
        echo "[3/3] Opening r/LocalLLaMA in Opera."
        echo "--> ACTION REQUIRED: When the page opens, click into the main Text Box, hit CMD+V to paste the drafted post, and click 'Post'."
        open -a Opera "$REDDIT_URL"
        ;;
    
    x)
        echo "[1/3] Preloading Twitter Intent API..."
        TWEET_TEXT="Most%20%22fact-checkers%22%20are%20state-aligned%20PR%20mouthpieces.%20Their%20only%20job%20is%20to%20protect%20the%20manufactured%20%22Us%20vs.%20Them%22%20binary.%0A%0AToday%20we%20are%20open-sourcing%20the%20ultimate%20weapon%20against%20algorithmic%20hate%3A%20The%20Null%20Engine%20v6.0.0.%0A%0AA%20completely%20offline%20Omnidirectional%20Audit%20tool%20that%20assumes%20all%20states%20are%20lying%20until%20proven%20otherwise.%20%F0%9F%A7%B5%201/5"
        X_URL="https://twitter.com/intent/tweet?text=${TWEET_TEXT}"
        
        echo "[2/3] Opening Twitter to Tweet 1 in Opera."
        echo "--> ACTION REQUIRED: Copy the rest of the thread from docs/LAUNCH_MATERIALS/X_THREAD_01.md to paste as replies!"
        open -a Opera "$X_URL"
        ;;
        
    *)
        echo "[!] Unknown target. Use 'hn', 'reddit', or 'x'."
        exit 1
        ;;
esac

echo ""
echo "Done."
