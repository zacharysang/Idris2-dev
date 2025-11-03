FROM ubuntu:22.04

RUN apt-get update && apt-get install -y wget software-properties-common ca-certificates curl dnsutils iputils-ping netcat-openbsd

# Add emacs PPA for newer version
RUN add-apt-repository ppa:kelleyk/emacs && apt-get update
RUN apt-get install -y emacs28-nox

# Install Node.js and wetty
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs build-essential python3 && \
    npm install -g wetty

# Create user with same UID/GID as host user
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g $GROUP_ID user && \
    useradd -u $USER_ID -g $GROUP_ID -m -s /bin/bash user && \
    mkdir -p /workspace && \
    chown user:user /workspace

# Switch to user for all remaining operations
USER user
WORKDIR /home/user

# Create user directories first
RUN mkdir -p /home/user/.emacs.d /home/user/bin

# Copy configuration files to user's home (permissions preserved from host)
COPY --chown=user:user init.el /home/user/.emacs.d/init.el
COPY --chown=user:user idris2-lsp /home/user/bin/idris2-lsp
COPY --chown=user:user test-lsp-connection.sh /home/user/bin/test-lsp-connection.sh

# Add user's bin to PATH
ENV PATH="/home/user/bin:$PATH"

# Install lsp-mode as user
RUN emacs --batch --eval "(progn (setq package-check-signature nil) (require 'package) (setq package-archives '((\"gnu\" . \"https://elpa.gnu.org/packages/\") (\"melpa\" . \"https://melpa.org/packages/\"))) (package-initialize) (package-refresh-contents) (package-install 'lsp-mode))"

# Add health check
HEALTHCHECK --interval=60s --timeout=30s --start-period=20s --retries=3 \
  CMD /home/user/bin/test-lsp-connection.sh

# Set TERM environment variable for gotty compatibility
ENV TERM=xterm-256color

EXPOSE 8080

WORKDIR /workspace 

CMD ["wetty", "--port", "8080", "--host", "0.0.0.0", "--command", "emacs -l /home/user/.emacs.d/init.el ."]
