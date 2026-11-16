# cursor-config

Configuração **pessoal do Cursor** (não de um projeto). Serve para levar User Rules, rules de usuário e skills entre máquinas via Git.

## Como o Cursor interpreta (ordem mental)

| Camada | Onde mora | Quando entra no contexto |
|--------|-----------|--------------------------|
| **User Rules** | Cursor Settings → Rules → User Rules (conta/sync) | Quase sempre, em todo chat/agente |
| **User Rules (arquivos)** | `~/.cursor/rules/*.mdc` | Rules com `alwaysApply: true`, ou quando o globs/descrição casam |
| **Project Rules** | `<repo>/.cursor/rules/*.mdc` | Só naquele projeto |
| **Skills** | `~/.cursor/skills/*/SKILL.md` e/ou `~/.agents/skills/*/SKILL.md` | Sob demanda: o agente lê o `description` e **só carrega o corpo** quando a tarefa casa |
| **AGENTS.md / CLAUDE.md** | raiz do projeto | Ponteiros de contexto do repositório |

### Rules vs Skills

- **Rule**: instrução curta e estável (“sempre responda em PT-BR”, “commits em pt-BR”). Custa tokens **sempre** (se `alwaysApply`) ou quando o arquivo é selecionado.
- **Skill**: procedimento longo (“como fazer review”, “como criar PR”). O agente vê só o **nome + description**; o `SKILL.md` completo só é lido se a skill for relevante. Use skill para playbooks, não para preferências triviais.

### Frontmatter típico de rule (`.mdc`)

```yaml
---
description: Quando usar esta rule
alwaysApply: true   # ou false + globs
globs: **/*.py      # opcional
---
```

### Frontmatter típico de skill

```yaml
---
name: nome-curto
description: Use when … (gatilhos claros; isso decide se o agente abre a skill)
---
```

## O que versionar neste repo

```
cursor-config/
  user-rules.md     → colar em Cursor Settings → Rules → User Rules
  rules/*.mdc       → ~/.cursor/rules/
  skills/*/SKILL.md → ~/.cursor/skills/
  install.sh
```

Não versionar: tokens, `.env`, senhas, `state.vscdb`, histórico de chat.

## Instalar em outra máquina

```bash
git clone <url-deste-repo> ~/Projetos/cursor-config
cd ~/Projetos/cursor-config
./install.sh
```

Depois: abra **Cursor Settings → Rules → User Rules** e cole o conteúdo de `user-rules.md` (a UI de User Rules não é um arquivo local confiável; o markdown é a fonte portátil).

## Atualizar

Edite neste repo → `git push` → na outra máquina `git pull && ./install.sh`.
