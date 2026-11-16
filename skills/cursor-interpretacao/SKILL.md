---
name: cursor-interpretacao
description: Explain or adjust how Cursor loads User Rules, ~/.cursor/rules, project rules, and skills. Use when the user asks how Cursor interprets skills/rules, how to port config between machines, or how to organize always-on vs on-demand agent instructions.
---

# Interpretação Cursor: Rules e Skills

## Carregar o quê

1. **User Rules (Settings)** — preferências sempre-on da conta. Fonte portátil neste pack: `user-rules.md` (colar na UI).
2. **`~/.cursor/rules/*.mdc`** — rules de usuário em arquivo; `alwaysApply: true` = quase sempre no contexto.
3. **`<projeto>/.cursor/rules/*.mdc`** — só aquele repo; não leva para outro PC sozinho.
4. **Skills** (`~/.cursor/skills` ou `~/.agents/skills`) — o agente vê `name` + `description`; lê o `SKILL.md` só se a tarefa casar com a description.

## Escolher Rule vs Skill

| Precisa… | Use |
|----------|-----|
| Preferência curta e estável | Rule `alwaysApply` |
| Playbook / checklist longo | Skill |
| Só neste repositório | Project rule ou `AGENTS.md` |

## Description de skill (gatilho)

- Comece com o verbo/caso: “Use when…”
- Liste branches distintas (review, PR, install), sem sinônimos inúteis.
- Não coloque o procedimento na description — só o gatilho.

## Portabilidade

Neste pack: `./install.sh` liga `rules/` → `~/.cursor/rules` e `skills/` → `~/.cursor/skills`. Depois cole `user-rules.md` na Settings.
