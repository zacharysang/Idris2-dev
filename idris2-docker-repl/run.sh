#!/bin/bash
cd "$(dirname "$0")"
docker run --rm -it -v "$(pwd):/workspace" idris2-repl
