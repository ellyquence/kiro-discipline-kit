#!/bin/bash
# Validate all .kiro.hook files are valid JSON with correct structure

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
HOOKS_DIR="$REPO_ROOT/.kiro/hooks"

echo "Validating Kiro hooks in $HOOKS_DIR"
echo "================================"

ERRORS=0
TOTAL=0

for file in "$HOOKS_DIR"/*.kiro.hook; do
  [ -f "$file" ] || continue
  TOTAL=$((TOTAL + 1))
  FILENAME=$(basename "$file")

  echo -n "$FILENAME: "

  # Check JSON syntax
  if ! jq empty "$file" 2>/dev/null; then
    echo "❌ Invalid JSON"
    jq . "$file" 2>&1 || true
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Check required fields
  NAME=$(jq -r '.name // empty' "$file")
  WHEN_TYPE=$(jq -r '.when.type // empty' "$file")
  THEN_TYPE=$(jq -r '.then.type // empty' "$file")
  ENABLED=$(jq -r '.enabled // empty' "$file")
  VERSION=$(jq -r '.version // empty' "$file")

  MISSING=""
  [ -z "$NAME" ] && MISSING="name "
  [ -z "$WHEN_TYPE" ] && MISSING="${MISSING}when.type "
  [ -z "$THEN_TYPE" ] && MISSING="${MISSING}then.type "
  [ -z "$ENABLED" ] && MISSING="${MISSING}enabled "
  [ -z "$VERSION" ] && MISSING="${MISSING}version"

  if [ -n "$MISSING" ]; then
    echo "❌ Missing: $MISSING"
    ERRORS=$((ERRORS + 1))
  else
    echo "✅"
  fi
done

echo "================================"

if [ $ERRORS -gt 0 ]; then
  echo "❌ $ERRORS of $TOTAL hooks failed validation"
  exit 1
else
  echo "✅ All $TOTAL hooks valid"
  exit 0
fi
