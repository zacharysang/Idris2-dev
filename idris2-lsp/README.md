# Overview

Containerized Idris2 LSP server with all dependencies included.

## Usage with lsp-docker (Emacs)

This container is compatible with [lsp-docker](https://github.com/emacs-lsp/lsp-docker) for seamless integration with Emacs lsp-mode.

### Setup

1. Build the image:
   ```bash
   docker build -t idris2-lsp .
   ```

2. Copy `.lsp-docker/lsp-docker.yml` to your Idris2 project root (or `.lsp-docker/` subdirectory)

3. Configure Emacs (add to your init file):
   ```elisp
   (require 'lsp-docker)
   
   ;; Register idris2-lsp with lsp-docker
   (lsp-docker-register
     (lsp-make-lsp-docker-server-container-config
       :server-id 'idris2-lsp
       :docker-server-id 'idris2-lsp-docker
       :docker-image-id "idris2-lsp"
       :server-command "idris2-lsp"
       :path-mappings '(("<your-project-path>" . "/workspace"))))
   ```

4. Open an Idris2 file in your project and lsp-mode will automatically use the containerized server

### How it works

- The container runs idris2-lsp in stdio mode (LSP over stdin/stdout)
- lsp-docker handles path translation between host and container
- No port exposure needed - communication is via stdio
