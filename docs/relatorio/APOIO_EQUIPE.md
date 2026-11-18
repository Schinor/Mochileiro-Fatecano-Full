# Apoio à equipe — fatos usados no relatório e pendências

Preenchimento feito em 16/11/2026 a partir do código em `~/mochileiro` na VM (commit `5810793`).
Os fatos abaixo serviram de base para os textos. Em uma segunda rodada, a pedido do Marcio, os blocos azuis (EQUIPE) foram retirados e os textos foram escritos no próprio relatório: ver a seção 2.

## Revisão de 18/11/2026 (prevalece sobre o restante deste arquivo)

Feita a partir do enunciado do professor (`ENTREGADETRABALHOFINALDOCURSODEDESENVOLVIMENTOFULLSTACK.pdf`) e de uma lista de pontuações trazida pelo Marcio.

**Banco migrado para MariaDB.** Onde este arquivo fala em SQLite, leia MariaDB.
- Banco `mochileiro` no MariaDB 10.5.29 da VM, com usuário próprio `mochileiro` (permissão só nesse banco). A senha está apenas no `.env` da VM.
- Dados copiados do SQLite com os mesmos IDs (2 usuários, 12 termos, 1 matéria, 2 notificações), conferidos campo a campo.
- Backup do banco SQLite, do `.env` e do `.env.example` antigos em `/root/backup-mochileiro-sqlite-20261118` na VM.
- `.env.example` alterado na VM (`DB_CONNECTION=mariadb` e variáveis `DB_*`, sem senha). **Ainda não commitado.**
- Os 19 testes de requisição HTTP foram repetidos contra o MariaDB, com os mesmos resultados. A instalação a partir de um clone limpo também foi conferida.
- Descoberta nos testes: o limite de 10 envios por minuto é somado entre `/login` e `/register` e contado por IP. RN15, CT18 e a tabela de erros foram ajustados.

**Mudanças no relatório:**
- Capa com o nome da disciplina (alteração no `modelo.typ`).
- Apêndice A: `routes/web.php` completo; Apêndice B: tabela de rotas; Apêndice C: os quatro controllers completos e a classe base; Apêndice D: histórico de commits.
- Código 6 sem corte (método `validar` inteiro).
- Nova seção 8.2.1 com os trechos Blade de `@csrf` e `@method` e a tabela dos 10 formulários.
- "Testes manuais" passaram a se chamar "testes de requisição HTTP".
- Seção 3.4 reescrita: só a imagem da tela de cadastro é declarada como gerada pelo Gemini (confirmado pelos metadados do arquivo).
- Capítulo 6 com a seção "Integração da aplicação com o banco", prints das tabelas no MariaDB, dicionário de dados com os tipos reais e DER atualizado.

**Para a arguição:** o professor avalia conhecimento e honestidade intelectual. Os dois devem conseguir explicar com as próprias palavras o caminho rota → middleware → controller → model → view, o que o `@csrf` faz (erro `419`), por que a remoção usa `@method('DELETE')`, o `abort_unless` e como a migração do SQLite para o MariaDB foi feita.

## 0. Leia antes: a stack real é diferente da que o molde supunha

O molde e o `MAPEAMENTO.md` partiam de **Laravel + Angular + MySQL, API REST e token Sanctum**.
O sistema entregue é **Laravel + Blade + SQLite, com login por sessão**:

| O molde supunha | O que existe no código |
|---|---|
| Frontend Angular (SPA) | Telas Blade renderizadas no servidor (`resources/views`), CSS próprio, sem framework JS |
| API REST em JSON (`routes/api.php`) | 20 rotas em `routes/web.php` que devolvem HTML ou redirecionamento; em `routes/api.php` só a rota padrão `GET /api/user` |
| MySQL | SQLite 3.34.1 (`DB_CONNECTION=sqlite`, arquivo `database/database.sqlite`) |
| Token Sanctum guardado no navegador | Sessão no banco (guard `web`); Sanctum instalado mas sem uso pelas telas |
| Perfis (usuário/admin), Policies | Um único perfil autenticado; autorização por dono do registro (`abort_unless`, `user_id`) |

Por decisão do Marcio, o relatório **descreve o que existe**. Vale confirmar com o professor se a prova aceita Blade + SQLite no lugar de Angular + MySQL.

O Angular só aparece no repositório antigo `Schinor/Mochileiro-Fatecano`: protótipo em Angular 20 (5 commits em 17/10/2025) com as telas de login, cadastro e início, sem services de acesso ao backend.

### Textos fixos do molde que foram reescritos (não eram marcadores)

- Cabeçalho do arquivo e campo `natureza` da folha de rosto.
- Palavras-chave e keywords (saíram "Angular" e "API REST"; entraram "Blade" e "SQLite").
- Objetivo geral (só a parte fixa da frase) e objetivos específicos.
- 1.5 Estrutura do documento (menção a "endpoints da API" e a "frontend").
- 2.1 a 2.5: títulos e textos (SPA → renderização no servidor; "APIs REST" → "HTTP e o estilo REST"; "Angular" → "Blade e a camada de apresentação"; "MySQL" → "SQLite").
- RNF01 a RNF03, RN01 e RN02.
- 5.1 Visão geral, lista de camadas de 5.2 e título de 5.3 ("Frontend (Angular)" → "Frontend (Blade)").
- 5.3: a tabela "Services do frontend" virou "Formulários das telas e rotas acionadas".
- Capítulo 7: título "API REST" → "Rotas HTTP da aplicação"; 7.1 "Endpoints" → "Rotas".
- 7.3: saíram os códigos 201 e 204; entraram 302 e 419.
- 8.2: o trecho "Interceptor do Angular" foi trocado pelo cadastro com criação dos termos.
- 10.2: saiu o bloco "Execução do frontend" (`ng serve`); a tabela de variáveis perdeu `SANCTUM_STATEFUL_DOMAINS`, que não está no `.env.example`.
- Lista de siglas: saíram CRUD, DER e SQL (não aparecem no texto); entraram CSS, CT, FK, HTML, PK e URL.
- 3.2: a coluna "Planejado" do cronograma foi apagada (o roteiro permite) e a etapa "Frontend Angular" virou duas linhas (protótipo Angular e interface Blade).
- `relatorio.typ` ganhou uma regra de exibição para quebrar nomes de código longos dentro de tabelas. O `modelo.typ` não foi alterado.

- Segunda rodada: a seção 2.6 "Sistemas correlatos" virou "Funcionalidades do sistema desenvolvido", sem comparação com outros sistemas.

## 1. Fatos usados nos textos, por seção

### Resumo / Abstract
- Sistema: Guia do Mochileiro Fatecano (`APP_NAME`; `<title>` das telas).
- Como foi feito: Laravel 12.70.2, PHP 8.2.35, Blade, SQLite, autenticação por sessão.
- Entregue: cadastro e login; 6 termos criados no cadastro; turmas (adicionar/remover); matérias com professor, dia, horário e sala (CRUD); "Aulas de hoje"; notificações.
- Os 17 requisitos funcionais foram exercitados em 19 casos de teste manuais, todos com o resultado esperado.
- Abstract é opcional: se o professor não pedir, apagar a página inteira.

### 1.1 Contextualização / 1.2 Problema / 1.4 Justificativa
- A página de apresentação se dirige a alunos da Fatec: "Organize suas aulas da Fatec em um só lugar".
- Texto da própria tela: "Cadastre seus termos e matérias com dia, horário e sala, e consulte a sua semana pelo celular ou pelo computador."
- "Cadastro gratuito. Não precisa instalar nada."
- A conta já nasce com seis termos (1° a 6°), o que corresponde a um curso de seis semestres.
- O repositório não traz nenhum dado ou estatística sobre o problema: qualquer número citado precisa de fonte externa nas Referências.

### 1.3.1 Objetivo geral (trecho marcado)
- O que o sistema permite: organizar termos e matérias, registrar dia da semana, horário e sala, consultar as aulas do dia.
- Para quem: estudantes (a tela fala em alunos da Fatec).

### 2.6 Sistemas correlatos
- A tabela comparativa já tem as funcionalidades deste trabalho; faltam os nomes dos sistemas A e B e os "sim/não" deles.
- Diferenciais verificáveis: organização por termo; dia, horário e sala por matéria; aulas do dia na tela inicial; notificações da conta; uso pelo navegador; cadastro gratuito; repositório público.
- O repositório é público, mas não tem arquivo `LICENSE`. Por isso a linha da tabela diz "código-fonte público", e não "código aberto".

### 3.1 Organização da equipe
- `git shortlog`: 1 commit, do Marcio, em 16/11/2026 (`5810793`), que versionou o projeto inteiro de uma vez. O histórico não mostra quem escreveu o quê.
- Repositório antigo do protótipo Angular: 5 commits do usuário `Schinor`, todos em 17/10/2025.
- A divisão real de tarefas não está em nenhum repositório: precisa vir da equipe.

### 3.2 Processo de desenvolvimento
- Não há branches, pull requests, issues nem quadro de tarefas: só a branch `main` com um commit.
- Datas observadas: base do projeto em 04/11/2026; migrations de domínio, controllers, models e views em 15/11/2026 (entre 19h35 e 20h10); testes, versionamento e documentação em 16/11/2026.
- A tabela `valores` foi criada (`2026_11_15_000002`) e removida (`2026_11_15_000005`) no mesmo dia: uma funcionalidade começou e foi tirada do escopo.
- As colunas de horário e de sala entraram em migrations separadas, depois da criação de `materias`: o modelo evoluiu em etapas.

### 3.4 Uso de inteligência artificial
- O versionamento do código (16/11/2026) e o preenchimento deste relatório foram feitos com o Claude Code: varredura do código, diagramas Mermaid, prints, execução dos testes manuais e redação das seções técnicas.
- O arquivo `public/imagens/Gemini_Generated_Image_sehlo3sehlo3sehl.png`, usado na tela de cadastro, tem nome de imagem gerada pelo Gemini.
- Na VM existem as pastas de configuração `~/.gemini` e `~/.copilot`.
- O que mais foi gerado com IA (código, telas, imagens da página de apresentação) e como o grupo validou só a equipe sabe.

### 11.2 Dificuldades e limitações
- Duas mensagens de validação saem em inglês (regras `confirmed` e `regex` sem tradução em `lang/pt_BR/validation.php`).
- O `.env.example` traz `APP_NAME=Laravel` e `APP_LOCALE=en`: um clone novo abre com nome e mensagens em inglês até o `.env` ser ajustado.
- O `README.md` é o padrão do Laravel, sem instruções do projeto.
- Só existem os 2 testes de exemplo do Laravel; nenhum cobre autenticação, termos, matérias ou notificações.
- No banco, `dia_semana`, `horario_inicio`, `horario_fim` e `sala` aceitam nulo; a obrigatoriedade só existe na validação do controller.
- Não dá para editar uma turma (só adicionar e remover), nem editar o perfil ou recuperar a senha.
- Editar ou remover matéria não gera notificação; criar matéria e criar/remover turma geram.
- A aplicação roda com `php artisan serve` (servidor de desenvolvimento) e `APP_DEBUG=true`.
- O repositório tem sobras de outro projeto que nenhum código do Mochileiro referencia: `config/barbearia.php`, `public/css/barbearia.css`, `public/css/site.css` e as fotos em `public/img/`; além da view `welcome.blade.php` padrão do Laravel, que não é usada.
- O `package.json` lista Vite e Tailwind, mas as telas não os usam (não há `@vite` nas views nem `node_modules`).

### 12 Considerações finais
- Situação dos requisitos: 17 de 17 atendidos (Tabela "Atendimento dos requisitos funcionais").
- O que ficou fora do escopo está em 4.1 e em 12.1 (API REST + SPA, MySQL, edição de turma, recuperação de senha, testes automatizados, tradução completa, seeders).
- A dica do bloco fala em "integrando Laravel, Angular e MySQL": o que foi integrado de fato é Laravel, Blade e SQLite.

## 2. Situação dos textos e pendências

### Textos escritos na segunda rodada (revisar)

| Seção | Base do texto |
|---|---|
| 1.1 Contextualização | Informado pelo Marcio: projeto da disciplina de Full Stack; ideia do professor Finoti, do Synapse, ex-aluno da Fatec, que idealizou o frontend de um projeto de apoio aos estudos dos ingressantes, pensando em grupos de estudo |
| 1.3.1 Objetivo geral | Completado com a intenção informada pelo Marcio: plataforma utilizável, com propósito, e não só uma entrega |
| 1.4 Justificativa | Mesma explicação da contextualização, a pedido do Marcio |
| 3.1 Organização da equipe | Informado pelo Marcio: Luis no backend e no frontend; Marcio na documentação, modelagem, revisão e versionamento (por isso o commit único) |
| 2.6 Funcionalidades | Só o nosso sistema, a pedido do Marcio |
| Resumo, Abstract, 1.2 Problema, 3.2 Processo, 11.2 Limitações, 12 Considerações finais | Escritos a partir dos fatos do código e do contexto acima, sem conteúdo ditado pela equipe: conferir se representam o que o grupo quer dizer |
| 3.4 Uso de IA | Declara só o que é verificável (uso do Claude Code no versionamento e no relatório); o restante ficou como marcador |

Pontos de atenção nesses textos:

- **11.2:** a seção traz só as limitações do sistema. As dificuldades vividas pela equipe não estão no código e não foram escritas.
- **Abstract:** é opcional; apagar a página se o professor não exigir.

### Marcadores

Não sobrou nenhum marcador: `typst compile relatorio.typ --input final=true` compila. Informações dadas pelo Marcio na terceira rodada:

- Disciplina Desenvolvimento Full Stack, código IIS004 no Siga; professor Leonardo Alves Carrilho.
- Finoti é professor do curso Synapse (não da disciplina).
- O protótipo foi feito em Angular; o Luis refez as telas em Blade para manter tudo na mesma stack.
- Cronograma: trabalho recebido na quarta, 11/11; levantamento de 12 a 14/11; desenvolvimento em 14 e 15/11; o restante em 16/11.

Pontos para conferir antes de entregar:

- **Uso de IA no desenvolvimento (3.4):** o texto afirma que houve apoio de IA no código e nas telas com base no que o Marcio acredita. Confirmar com o Luis, inclusive quais ferramentas foram usadas.

Decisões a confirmar:

- **Stack da prova:** resolvido. O enunciado aceita frontend em Blade, e o banco foi migrado para MariaDB.
- **Prioridade dos requisitos funcionais:** foi atribuída no preenchimento por um critério declarado em 4.3 (Alta = fluxo principal; Média = apoio). Ajustar se a equipe tiver outra classificação.
- **Apêndice B (histórico de commits):** tem um único commit; apagar se o professor não pedir evidência de datas.
- **Referências:** as entradas `angular-docs`, `mysql-docs`, `sommerville2018` e `pressman2021` continuam no `referencias.yml`, mas não são citadas e não aparecem no PDF. Foi acrescentada `sqlite-docs`. As datas de acesso de Laravel, PHP e SQLite são de 16/11/2026.

## 3. Como as evidências foram geradas

- **Testes manuais e prints:** feitos em uma segunda instância da aplicação, com banco SQLite temporário separado e dois usuários de teste. O banco real não foi tocado, e a instância temporária foi removida ao final.
- **Passo a passo de instalação (10.2):** conferido com um clone limpo do GitHub.
- **Diagramas:** fontes Mermaid em `figuras/fontes/*.mmd`. Para regerar: `npx -y @mermaid-js/mermaid-cli -i figuras/fontes/der.mmd -o figuras/der.png -b white -s 2 -t neutral`. A opção `-w 1600` citada no `MAPEAMENTO.md` não existe na versão 12.2 do mermaid-cli.
- **Compilação:** `typst compile relatorio.typ` gera o rascunho (49 páginas). `typst compile relatorio.typ --input final=true` gera a versão de entrega; ele falha se algum marcador voltar ao texto.
