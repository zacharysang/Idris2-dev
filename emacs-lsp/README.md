# Overview

Full IDE configuration for Idris2 development with LSP support running in Docker containers.

## Features

### Core LSP Features
- **Completion**: Instant symbol completion via company-mode
- **Navigation**: Go to definition, references, implementations, type definitions
- **Documentation**: Hover information and signature help
- **Diagnostics**: Real-time error checking with project-wide error tracking

### UI Enhancements (lsp-ui)
- **Sideline**: Show diagnostics, hover info, and code actions inline
- **Peek**: VSCode-style peek windows for definitions/references
- **Doc**: Documentation popups in child frames
- **Imenu**: Quick symbol navigation within files

### Project Navigation (lsp-treemacs)
- **Error List**: Tree view of all project errors
- **Symbol Browser**: Navigate project symbols
- **Call Hierarchy**: Explore function call chains
- **Type Hierarchy**: Browse type relationships
- **References Tree**: View all references in tree format

### Visual Feedback
- **Modeline**: Project-wide diagnostics and available code actions
- **Headerline**: Breadcrumb showing file path and current symbol
- **Code Lens**: Inline actionable information
- **Symbol Highlighting**: Highlight symbol occurrences

### Code Actions
- Quick fixes for errors
- Organize imports
- Format buffer/region
- Rename refactoring

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

## Keybindings

All LSP commands use the `C-c l` prefix. Press `C-c l` and wait to see available commands via which-key.

### Navigation (`C-c l g`)
- `C-c l g d` - Go to definition
- `C-c l g r` - Find references
- `C-c l g i` - Find implementation
- `C-c l g t` - Find type definition
- `C-c l g D` - Find declaration

### Peek (`C-c l p`)
- `C-c l p d` - Peek definitions
- `C-c l p r` - Peek references
- `C-c l p i` - Peek implementations
- `C-c l p s` - Peek workspace symbols

### Documentation (`C-c l h`)
- `C-c l h h` - Show documentation at point
- `C-c l h s` - Show signature help

### Refactoring (`C-c l r`)
- `C-c l r r` - Rename symbol
- `C-c l r o` - Organize imports
- `C-c l r f` - Format buffer
- `C-c l r R` - Format region

### Code Actions (`C-c l a`)
- `C-c l a a` - Execute code action
- `C-c l a l` - Jump to lens with avy
- `C-c l a h` - Highlight symbol

### Workspace (`C-c l w`)
- `C-c l w s` - Start LSP
- `C-c l w r` - Restart workspace
- `C-c l w q` - Shutdown workspace
- `C-c l w d` - Describe session

### Toggles (`C-c l t`)
- `C-c l t l` - Toggle code lens
- `C-c l t h` - Toggle symbol highlighting
- `C-c l t f` - Toggle format on type
- `C-c l t s` - Toggle signature auto-activate
- `C-c l t L` - Toggle IO logging

### Treemacs Views (`C-c l T`)
- `C-c l T e` - Show error list
- `C-c l T s` - Show symbols
- `C-c l T r` - Show references
- `C-c l T i` - Show implementations
- `C-c l T c` - Show call hierarchy
- `C-c l T t` - Show type hierarchy

### UI Toggles (`C-c l u`)
- `C-c l u s` - Toggle sideline
- `C-c l u d` - Toggle doc popups
- `C-c l u i` - Show imenu

## Creating a New Project

If you don't have an `.ipkg` file, create one with:
```bash
idris2 --init
```

The LSP server requires an `.ipkg` file at the project root to function correctly.

## Configuration Files

- `init.el` - Main IDE configuration with all features enabled
- `idris2-lsp.el` - Idris2 LSP server configuration for Docker
- `lsp-bindings.el` - Idiomatic keybindings for all LSP features
- `.lsp-docker.yml` - Docker container configuration (auto-generated per project)
