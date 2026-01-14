#!/bin/bash
# Usage: ./run.sh /path/to/project
cd "$(dirname "$0")"
PROJECT_PATH="$1" docker compose up -d
