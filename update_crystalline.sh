#! /usr/bin/env bash
set -euo pipefail

crysatlline_path="${HOME}/.local/bin/crystalline"

# Install crystal LSP server
curl \
    -L https://github.com/elbywan/crystalline/releases/latest/download/crystalline_x86_64-apple-darwin.gz \
    -o "${crysatlline_path}.gz" \
    && yes | gzip -f -d "${crysatlline_path}.gz" \
    && chmod u+x "${crysatlline_path}"
