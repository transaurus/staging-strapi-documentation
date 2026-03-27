#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for strapi/documentation
# Runs on existing source tree (no clone). Installs deps, runs pre-build steps, builds.

# --- Node version ---
# Docusaurus 3.5.2, Node >=18.0 engines requirement; using Node 20
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    # shellcheck source=/dev/null
    . "$NVM_DIR/nvm.sh"
    nvm use 20 || nvm install 20
fi

# --- Package manager + dependencies ---
# Uses Yarn Classic (yarn.lock exists)
yarn install --frozen-lockfile

# --- Build ---
# Use direct docusaurus build to avoid the llms validator which uses --project-root ..
# (expects parent dir to contain source docs - not available in staging repo context)
./node_modules/.bin/docusaurus build

echo "[DONE] Build complete."
