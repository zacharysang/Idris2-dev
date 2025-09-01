FROM idris2-pack

RUN pack install-app idris2-lsp
RUN apt-get update && apt-get install -y socat netcat-openbsd

# Create user with same UID/GID as host user
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g $GROUP_ID user && \
    useradd -u $USER_ID -g $GROUP_ID -m -s /bin/bash user

# Copy health check script (already executable from host)
COPY health-check.sh /usr/local/bin/health-check.sh

EXPOSE 3030

# Health check: send LSP initialize request and validate response
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD /usr/local/bin/health-check.sh

# Set working directory to mounted project with ipkg file
WORKDIR /workspace

USER user

# Use EXEC to keep idris2-lsp process alive for persistent connections
CMD ["socat", "TCP-LISTEN:3030,fork,reuseaddr", "EXEC:idris2-lsp"]
