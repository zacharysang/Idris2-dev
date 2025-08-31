#!/bin/bash

# LSP health check - test actual LSP communication
(
    # Initialize request with correct content length
    INIT_JSON='{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"processId":null,"rootUri":"file:///workspace","capabilities":{"textDocument":{"hover":{"contentFormat":["plaintext"]}}},"initializationOptions":{},"workspaceFolders":null}}'
    INIT_LENGTH=$(echo -n "$INIT_JSON" | wc -c)
    
    echo -e "Content-Length: $INIT_LENGTH\r\n\r\n$INIT_JSON"
    
    # Wait briefly then send initialized notification
    sleep 1
    
    INIT_NOTIF='{"jsonrpc":"2.0","method":"initialized","params":{}}'
    NOTIF_LENGTH=$(echo -n "$INIT_NOTIF" | wc -c)
    
    echo -e "Content-Length: $NOTIF_LENGTH\r\n\r\n$INIT_NOTIF"
    
    # Keep connection open briefly
    sleep 2
) | timeout 8 nc localhost 3030 > /tmp/health_response.txt 2>/dev/null

# Check if we got a response
if [ ! -s /tmp/health_response.txt ]; then
    echo "Health check failed: No response from LSP server"
    exit 1
fi

# Check if response contains LSP capabilities
if grep -q '"result".*"capabilities"' /tmp/health_response.txt; then
    echo "Health check passed: LSP server responding with capabilities"
    exit 0
else
    echo "Health check failed: Invalid LSP response"
    exit 1
fi
