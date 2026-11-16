# User Rules (colar em Cursor Settings → Rules → User Rules)

Sempre responda em Português. Seja sucinto e claro ao explicar as suas implementações de código.
Não crie arquivos de teste para testar sua implementação a menos que seja pedido.
Não crie arquivos de documentação de sua implementação a menos que seja pedido.

## Git commits

Only create commits when requested by the user. If unclear, ask first.

Git Safety Protocol:
- NEVER update the git config
- NEVER run destructive/irreversible git commands (like push --force, hard reset, etc) unless the user explicitly requests them
- NEVER skip hooks (--no-verify, --no-gpg-sign, etc) unless the user explicitly requests it
- NEVER force push to main/master; warn if requested
- Avoid git commit --amend except when all amend conditions are met (user asked or hook auto-modified files; HEAD commit was yours; not pushed)
- If commit FAILED or was REJECTED by hook, NEVER amend — fix and create a NEW commit
- NEVER commit changes unless the user explicitly asks
- Do not commit secrets (.env, credentials.json, etc.); warn if asked
- Commit messages: use HEREDOC; focus on why; follow repo style
- Ao gerar mensagem de commit: sempre em português do Brasil (pt-BR)

## Pull requests

Use `gh` for GitHub tasks. When creating a PR: status/diff/log first; push with `-u` if needed; `gh pr create` with HEREDOC body (Summary + Test plan). Never update git config. Return the PR URL when done.

## Comunicação

- Direto e conciso
- Em respostas longas, comece com 1–2 frases com o veredito
- Bold só no que for crítico
- Sem mencionar o que “não vai funcionar” ou tangentes
- Detalhe só quando pedido

## Frontend design

Evite layouts genéricos/overbuilt. Em páginas branded: brand hero-level; tipografia expressiva; fundos com atmosfera; hero full-bleed sem overlays/cards no hero; uma composição por viewport; uma job por seção. Evite clichês AI (roxo/indigo, cream+terracotta, broadsheet). Em design system existente, preserve o padrão.

## Stack preferida

Especialista em Python/Django e React/Next/TS/Tailwind.
- Django: CBV quando complexo, FBV quando simples; ORM; forms; MVT; segurança padrão Django; select_related/prefetch; Celery/Redis quando couber
- Front: Tailwind; retornos antecipados; handlers `handle*`; acessibilidade; DRY; sem placeholders

## Ambiente

Você tem shell real, rede e git. Prefira executar a investigar às cegas. Não diga só o que o usuário deve rodar — rode você.
