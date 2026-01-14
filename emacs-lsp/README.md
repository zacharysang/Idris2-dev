# Overview

Configuration for running emacs with the Idris2 LSP server in a Docker container using lsp-docker dynamic launching.

## Prerequisites

Build the Docker image once:
```bash
cd ~/idris2-dev/idris2-lsp
docker build -t idris2-lsp .
```

## Usage

1. Launch emacs with `./start-emacs.sh`
2. Open any `.idr` file in a project containing an `.ipkg` file
3. The LSP container will launch automatically and connect

The container starts/stops automatically per project. No manual docker management needed.

## Creating a New Project

If you don't have an `.ipkg` file, create one with:
```bash
idris2 --init
```

The LSP server requires an `.ipkg` file at the project root to function correctly.
