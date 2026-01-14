# Overview

Configuration for running emacs attached with the Idris2 LSP server exposed from the container defined in idris2-lsp

Intention is to provide files & configuration such that emacs can be started up with one command to open a project and LSP server attached

## Usage

1. Set `PROJECT_PATH` environment variable to your Idris2 project path
2. Start the container with `docker compose up` 
3. Launch emacs with `./start-emacs.sh`
