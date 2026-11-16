#!/usr/bin/env bash
# Instala rules/skills deste repo em ~/.cursor e ~/.agents (usuário atual).
# Uso: ./install.sh [--force]
#   --force  recria symlinks mesmo se o destino já existir
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
CURSOR_HOME="${CURSOR_HOME:-$HOME/.cursor}"
AGENTS_HOME="${AGENTS_HOME:-$HOME/.agents}"
RULES_DST="$CURSOR_HOME/rules"
SKILLS_DST="$CURSOR_HOME/skills"
AGENTS_SKILLS_DST="$AGENTS_HOME/skills"

FORCE=0
for arg in "$@"; do
  case "$arg" in
    --force|-f) FORCE=1 ;;
    -h|--help)
      echo "Uso: $0 [--force]"
      exit 0
      ;;
    *)
      echo "Opção desconhecida: $arg" >&2
      exit 1
      ;;
  esac
done

mkdir -p "$RULES_DST" "$SKILLS_DST" "$AGENTS_SKILLS_DST"

link_or_copy() {
  local src="$1" dst="$2"
  if [[ -L "$dst" || -e "$dst" ]]; then
    if [[ -L "$dst" ]] && [[ "$(readlink "$dst")" == "$src" ]]; then
      echo "ok  $dst"
      return
    fi
    if [[ "$FORCE" -eq 1 ]]; then
      rm -rf "$dst"
    else
      echo "skip (já existe): $dst  (use --force para religar)"
      return
    fi
  fi
  ln -s "$src" "$dst"
  echo "link $dst -> $src"
}

echo "== rules (~/.cursor/rules) =="
shopt -s nullglob
for f in "$ROOT"/rules/*.mdc; do
  link_or_copy "$f" "$RULES_DST/$(basename "$f")"
done

echo "== skills pessoais (~/.cursor/skills) =="
for d in "$ROOT"/skills/*/; do
  name="$(basename "$d")"
  link_or_copy "${d%/}" "$SKILLS_DST/$name"
done

echo "== skills Matt Pocock (~/.agents/skills) =="
for d in "$ROOT"/agents-skills/*/; do
  name="$(basename "$d")"
  link_or_copy "${d%/}" "$AGENTS_SKILLS_DST/$name"
done

if [[ -f "$ROOT/agents-skills/.skill-lock.json" ]]; then
  mkdir -p "$AGENTS_HOME"
  if [[ "$FORCE" -eq 1 || ! -e "$AGENTS_HOME/.skill-lock.json" ]]; then
    cp "$ROOT/agents-skills/.skill-lock.json" "$AGENTS_HOME/.skill-lock.json"
    echo "copy $AGENTS_HOME/.skill-lock.json"
  else
    echo "ok  $AGENTS_HOME/.skill-lock.json"
  fi
fi

echo
echo "Pronto."
echo "1) Rules em $RULES_DST"
echo "2) Skills pessoais em $SKILLS_DST"
echo "3) Skills Matt Pocock (grill-me, tdd, …) em $AGENTS_SKILLS_DST"
echo "4) Cole user-rules.md em: Cursor Settings → Rules → User Rules"
echo "5) Abra um chat novo se algo não aparecer."
