#!/bin/bash
# LSP wrapper script that ensures container is running and connects via TCP

# Start container if not running
if ! docker ps --filter "name=idris2-dev-idris2-lsp-1" --filter "status=running" | grep -q idris2-dev-idris2-lsp-1; then
    cd /home/zak/idris2-dev
    PROJECT_PATH="${PROJECT_PATH:-/tmp}" docker compose up -d
    # Wait for container to be ready
    sleep 2
fi

# Connect to LSP server via netcat
exec nc localhost 3030
