#!/usr/bin/env bash
# Instala rules/skills deste repo em ~/.cursor (usuário atual).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
CURSOR_HOME="${CURSOR_HOME:-$HOME/.cursor}"
RULES_DST="$CURSOR_HOME/rules"
SKILLS_DST="$CURSOR_HOME/skills"

mkdir -p "$RULES_DST" "$SKILLS_DST"

link_or_copy() {
  local src="$1" dst="$2"
  if [[ -L "$dst" || -e "$dst" ]]; then
    if [[ -L "$dst" ]] && [[ "$(readlink "$dst")" == "$src" ]]; then
      echo "ok  $dst"
      return
    fi
    echo "skip (já existe): $dst"
    return
  fi
  ln -s "$src" "$dst"
  echo "link $dst -> $src"
}

echo "== rules =="
shopt -s nullglob
for f in "$ROOT"/rules/*.mdc; do
  link_or_copy "$f" "$RULES_DST/$(basename "$f")"
done

echo "== skills =="
for d in "$ROOT"/skills/*/; do
  name="$(basename "$d")"
  link_or_copy "${d%/}" "$SKILLS_DST/$name"
done

echo
echo "Pronto."
echo "1) Rules/skills linkados em $CURSOR_HOME"
echo "2) Cole o conteúdo de user-rules.md em: Cursor Settings → Rules → User Rules"
echo "3) Reinicie o Agent / abra um chat novo se a rule não aparecer."
