FROM ubuntu:22.04

RUN apt-get update && apt-get install -y wget software-properties-common ca-certificates curl dnsutils iputils-ping netcat-openbsd

# Add emacs PPA for newer version
RUN add-apt-repository ppa:kelleyk/emacs && apt-get update
RUN apt-get install -y emacs28-nox

# Install gotty
RUN wget https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz && \
    tar -xzf gotty_linux_amd64.tar.gz && \
    mv gotty /usr/local/bin/ && \
    rm gotty_linux_amd64.tar.gz

# Create directories
RUN mkdir -p /tmp/project /etc/emacs

# Copy emacs configuration to system location
COPY init.el /etc/emacs/init.el

# Copy idris2-lsp wrapper script to PATH
COPY idris2-lsp /usr/local/bin/idris2-lsp

# Create user with same UID/GID as host user
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g $GROUP_ID user && \
    useradd -u $USER_ID -g $GROUP_ID -m -s /bin/bash user

# Install lsp-mode with signature checking disabled (due to keyring issues in container)
RUN emacs --batch --eval "(progn (setq package-check-signature nil) (require 'package) (setq package-archives '((\"gnu\" . \"https://elpa.gnu.org/packages/\") (\"melpa\" . \"https://melpa.org/packages/\"))) (package-initialize) (package-refresh-contents) (package-install 'lsp-mode))"

# Copy health check script
COPY test-lsp-connection.sh /usr/local/bin/test-lsp-connection.sh

# Add health check that tests LSP connectivity to idris2-lsp container
HEALTHCHECK --interval=60s --timeout=30s --start-period=20s --retries=3 \
  CMD /usr/local/bin/test-lsp-connection.sh

# Set TERM environment variable for gotty compatibility
ENV TERM=xterm-256color

EXPOSE 8080

WORKDIR /tmp/project

USER user

CMD ["gotty", "--permit-write", "emacs", "-l", "/etc/emacs/init.el", "."]
