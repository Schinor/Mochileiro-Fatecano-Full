# Mapeamento do relatório — Prova Full Stack (Laravel + Angular + MySQL)

> **Para o Claude Code.** Leia este arquivo inteiro antes de abrir o `relatorio.typ`.
> Sua tarefa é **varrer o repositório do sistema e preencher o relatório**, seção por seção,
> trocando os marcadores pelo conteúdo real. Você **não altera código da aplicação**: só mexe
> em `docs/relatorio/`.

## 0. Arquivos

```
docs/relatorio/
├── relatorio.typ      ← o documento (é aqui que se preenche)
├── modelo.typ         ← estilos ABNT e marcadores (não mexer)
├── referencias.yml    ← referências (Hayagriva, estilo ABNT)
├── figuras/           ← prints e diagramas (PNG)
└── MAPEAMENTO.md      ← este arquivo
```

Compilar:

```bash
typst compile relatorio.typ                       # rascunho: marcadores aparecem coloridos
typst compile relatorio.typ --input final=true    # entrega: FALHA se sobrar algum marcador
```

## 1. Marcadores

| Marcador | Cor | Quem resolve | O que fazer |
|---|---|---|---|
| `#preencher[...]` | amarelo | **Claude Code** | Trocar pelo dado real tirado do repositório. O texto dentro diz o que vai ali e, quase sempre, de onde tirar. |
| `#verificar[...]` | laranja | **Claude Code** | O texto já está escrito, mas é uma suposição. Confirmar no código: se for verdade, tirar o marcador e manter o texto; se não, reescrever com o que existe de fato. |
| `#equipe[...]` / `#bloco("EQUIPE")[...]` | azul | **Marcio / Luis** | Texto autoral do grupo. **Não escreva.** No máximo, ao final, liste os fatos do código que ajudam a escrever (num arquivo à parte, `docs/relatorio/APOIO_EQUIPE.md`). |
| `#print-tela("figuras/x.png", ...)` | cinza | Claude Code ou equipe | Gerar o PNG com o nome exato e trocar a chamada por `image("figuras/x.png", width: 100%)`. |

Para remover um marcador, troque `#preencher[texto-guia]` pelo conteúdo final, **sem** a função.

## 2. Regras invioláveis

1. **Nada inventado.** Todo dado (rota, tabela, coluna, versão, regra, data, nome de arquivo) tem que existir no repositório ou na saída de um comando. Se não achar, deixe o marcador e anote na lista de pendências (§6).
2. **Não escrever os blocos EQUIPE**: resumo, abstract, contextualização, problema, justificativa, objetivo geral (parte marcada), correlatos, organização da equipe, processo, uso de IA, dificuldades, considerações finais.
3. **Nunca colocar segredo no documento**: senha, `APP_KEY`, token, `.env` real. Variáveis de ambiente entram só pelo **nome** (do `.env.example`). Tokens em exemplos de requisição vão mascarados (`1|abc…xyz`).
4. **Não mudar a estrutura** (capítulos, ordem, estilos). Pode **apagar** linhas-modelo de tabela que não se aplicam e **acrescentar** linhas, subseções de dicionário de dados e figuras.
5. **Não alterar código da aplicação, não commitar e não dar push** sem autorização explícita.
6. Linhas de tabela que eram só exemplo (`RF..`, `CT..`, `RN..`, linhas vazias) **saem** na versão final.
7. Trechos de código no relatório: **copiados do repositório**, curtos (≤ 20 linhas), com o caminho do arquivo na legenda.

## 3. Reconhecimento (rode primeiro)

```bash
# estrutura
git ls-files | grep -v -E "vendor/|node_modules/" | head -200
# onde estão back e front (pode ser monorepo ou dois repos)
find . -name artisan -not -path "*/vendor/*"
find . -name angular.json -not -path "*/node_modules/*"

# backend (na pasta do Laravel)
php artisan --version
php artisan about                         # versões, drivers, ambiente
php artisan route:list --path=api --json  # endpoints
php artisan route:list --path=api -v      # com middlewares
php artisan db:show                       # tabelas (precisa do banco rodando)
php artisan db:table <tabela>             # colunas, índices, FKs
php artisan model:show <Model>            # atributos e relacionamentos do model
php artisan test                          # testes

# frontend (na pasta do Angular)
cat package.json
grep -rn "path:" src/app/*.routes.ts src/app/**/*routing*.ts 2>/dev/null
grep -rln "HttpClient" src/app
grep -rn "canActivate\|CanActivateFn" src/app

# equipe e datas
git shortlog -sne --all
git log --date=format:"%d/%m/%Y %H:%M" --format="%h | %ad | %an | %s"
```

Se o banco não estiver rodando, tire tabelas e colunas das **migrations** (`database/migrations/*.php`), na ordem dos arquivos.

## 4. Mapa seção → fonte

| Seção do relatório | O que preencher | Fonte no repositório |
|---|---|---|
| Capa / folha de rosto | Nome e subtítulo do sistema | `README.md`, `<title>` do `frontend/src/index.html`, `APP_NAME` no `.env.example`. **Disciplina e professor: perguntar ao Marcio.** Autores: Marcio Gabriel Schinor Mazega e Luis Gustavo Bonfim Ciaramicoli (já preenchidos). |
| Palavras-chave | 1 do domínio | tema do sistema |
| Lista de siglas | só as usadas | buscar no `.typ` final; acrescentar as novas (ex.: JWT, UI) e apagar as que não aparecem |
| 1.3.2 Objetivos específicos | objetivo do domínio; confirmar Sanctum e tipo de teste | `composer.json` (`laravel/sanctum`?), pasta `tests/` |
| 2.3 Laravel | confirmar Sanctum para SPA | `config/sanctum.php`, `routes/api.php` (`auth:sanctum`), `bootstrap/app.php` |
| 2.6 Correlatos (tabela) | só as linhas de funcionalidade, depois que a EQUIPE escolher os sistemas | — |
| 3.1 Contribuições | commits e áreas por autor | `git shortlog -sne`; `git log --author="X" --name-only --format="" \| cut -d/ -f1-2 \| sort \| uniq -c \| sort -rn \| head` |
| 3.2 Cronograma | datas realizadas e evidências | `git log` (primeiro commit de cada etapa: migrations, controllers, componentes, testes). Coluna "Planejado": perguntar à equipe ou apagar a coluna. |
| 3.3 Tecnologias | versões | `composer.json`/`composer.lock` (php, laravel/framework, sanctum), `package.json` (@angular/core, typescript, libs de UI), `docker-compose.yml` (imagem mysql), `php artisan about` |
| 4.1 Visão geral | o que o sistema faz e o que ficou fora | rotas + telas + README |
| 4.2 Perfis | papéis e permissões | coluna `role`/tabela de papéis nas migrations, `app/Policies`, Gates em `AppServiceProvider`, middlewares próprios em `app/Http/Middleware`, guards do Angular |
| 4.3 RF | uma linha por funcionalidade real | agrupar as rotas do `route:list` por recurso; "Onde está" = rota principal |
| 4.4 RNF | confirmar hash, CORS, throttle, UI | `config/hashing.php`, `config/cors.php`, `throttle:` no `route:list -v`, `package.json` (Material/Bootstrap/Tailwind), media queries |
| 4.5 Regras de negócio | "se X, então Y" + arquivo | regras de validação (`app/Http/Requests`, `$request->validate`), `abort(403)`, Policies, `if` com regra de domínio nos controllers/services, `unique`/`exists` |
| 4.6 Casos de uso | figura | gerar com Mermaid (§5) a partir de 4.2 + 4.3 |
| 5.2 Backend | camadas e diretórios | listar `app/Http/Controllers`, `app/Models`, `app/Http/Requests`, `app/Http/Resources`, `app/Services`, `app/Policies`, `database/*`, `tests/*` |
| 5.3 Frontend | rotas, componentes, guards, services | `app.routes.ts`, `src/app/**/*.service.ts`, guards, interceptors, onde guarda o token (`localStorage`?) |
| 5.4 Autenticação | fluxo real | controller de auth, `createToken`, interceptor do Angular, `auth:sanctum`. Se for JWT (tymon/php-open-source-saver), ajustar o texto de 2.3 e RNF também. |
| 6.1 DER | figura | Mermaid `erDiagram` a partir das migrations (§5) |
| 6.2 Dicionário | uma tabela por tabela de domínio | `php artisan db:table X` ou migrations. Tabelas internas do Laravel (`cache`, `jobs`, `sessions`, `password_reset_tokens`, `personal_access_tokens`, `migrations`, `failed_jobs`) só citadas numa frase. |
| 6.3 Relacionamentos | cardinalidade + método Eloquent | `php artisan model:show X`, métodos `hasMany`/`belongsTo`/`belongsToMany` nos models |
| 6.4 Migrations | ordem e o que os seeders criam | `database/migrations`, `database/seeders/DatabaseSeeder.php`, factories |
| 7.1 Endpoints | tabela completa | `route:list --path=api --json` → método, uri, action (`Controller@metodo`), middleware (público / autenticado / admin) |
| 7.2 Exemplos | requisição e resposta reais | `curl` contra o sistema rodando (token mascarado); se não der para rodar, pedir print do Postman à equipe |
| 7.3 Erros | confirmar 204, 403, 429 | o que os controllers retornam em `destroy`, se há Policy/abort(403), se há `throttle` |
| 8.1 Telas | prints | Playwright no sistema rodando (§5); com usuário de teste do seeder |
| 8.2 Trechos | 2 a 4 trechos reais | `routes/api.php`, model principal, Form Request principal, interceptor |
| 9 Testes | estratégia, print, casos manuais | `php artisan test` (salvar saída → print), `ng test` se houver; casos manuais: executar de verdade via `curl` e marcar ok/falhou |
| 10 Implantação | pré-requisitos, comandos, variáveis | `README.md`, `docker-compose.yml`, `.env.example` (só nomes), `composer.json` scripts |
| 10.4 Repositório | link | `git remote get-url origin` |
| 11.1 Resultados | situação de cada RF | cruzar 4.3 com as telas e os testes |
| 12.1 Trabalhos futuros | lista curta | o que ficou fora em 4.1, TODOs no código (`grep -rn "TODO\|FIXME"`) |
| Referências | datas de acesso | atualizar `url.date` em `referencias.yml` para o dia do preenchimento; se citar algo novo, acrescentar entrada |
| Apêndice A | rotas completas | `php artisan route:list --path=api` |
| Apêndice B | commits | só se o professor pedir; senão, apagar o apêndice |

## 5. Figuras

Salvar tudo em `docs/relatorio/figuras/` com os nomes já usados no `.typ`:

| Arquivo | Como gerar |
|---|---|
| `casos-de-uso.png` | Mermaid `flowchart LR` com atores à esquerda e casos de uso (RFs) em nós arredondados |
| `arquitetura.png` | Mermaid `flowchart LR`: Navegador/Angular → API Laravel (rotas → middleware → controller → model) → MySQL |
| `fluxo-autenticacao.png` | Mermaid `sequenceDiagram`: Angular, Laravel, MySQL — login, token, requisição autenticada |
| `der.png` | Mermaid `erDiagram` com todas as tabelas de domínio, PK/FK e cardinalidades das migrations |
| `tela-*.png` | Playwright (`npx playwright screenshot` ou script) com o sistema rodando, janela 1366×768; acrescentar figuras para outras telas relevantes |
| `testes.png` | print da saída de `php artisan test` (pode renderizar a saída num HTML simples e capturar) |

Mermaid → PNG: `npx -y @mermaid-js/mermaid-cli -i diagrama.mmd -o figuras/der.png -w 1600 -b white`. Guarde os `.mmd` em `figuras/fontes/`, para dar para editar depois.

Depois de gerar, troque `#print-tela("figuras/x.png", [...])` por `#image("figuras/x.png", width: 100%)` (diagramas altos: `width: 80%`).

## 6. Ordem de execução e entrega

1. Reconhecimento (§3). Mostrar ao Marcio um resumo: tema, recursos, nº de rotas, nº de tabelas, se há testes.
2. Capítulos 4 a 7 (especificação, arquitetura, dados, API): são os que mais dependem do código.
3. Figuras (§5).
4. Capítulos 8 a 10 e tabelas de 3.1, 3.2, 3.3, 11.1.
5. Rodar `typst compile relatorio.typ` e conferir o PDF página a página (tabelas cortadas, figuras sem legenda, siglas sobrando).
6. Gerar `docs/relatorio/APOIO_EQUIPE.md`: para cada bloco EQUIPE, 3 a 5 fatos do código que ajudam a escrever aquele trecho (sem redigir o texto).
7. Entregar a lista de **pendências**: marcadores que sobraram e por quê (ex.: "nome da disciplina — perguntar", "sem testes automatizados — confirmar com o Luis").
8. Só quando a equipe terminar os blocos EQUIPE: `typst compile relatorio.typ --input final=true`. Se compilar, não sobrou marcador.
9. Não commitar sem o Marcio autorizar.
