#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo -e "${BLUE}Setting up Git hooks...${NC}"

# Configure git to use our hooks directory
git -C "$REPO_ROOT" config core.hooksPath .githooks

# Ensure hooks are executable
chmod +x "$REPO_ROOT/.githooks/"*

echo -e "${GREEN}✓ Git hooks installed successfully${NC}"
echo ""
echo "  Conventional Commits will now be enforced locally."
echo "  Every commit message must follow: <type>(<scope>): <description>"
echo ""
echo "  To bypass (not recommended): git commit --no-verify"
