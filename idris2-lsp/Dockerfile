FROM idris2-pack

# Install idris2-lsp as root
RUN pack install-app idris2-lsp

RUN apt-get update && apt-get install -y socat netcat-openbsd

# Copy health check script
COPY health-check.sh /usr/local/bin/health-check.sh

EXPOSE 3030

# Health check: send LSP initialize request and validate response
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD /usr/local/bin/health-check.sh

# Set working directory to mounted project with ipkg file
WORKDIR /workspace

# Run as root since pack environment is designed for root access
CMD ["socat", "TCP-LISTEN:3030,fork,reuseaddr", "EXEC:idris2-lsp"]
