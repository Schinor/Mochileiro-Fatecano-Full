// =====================================================================
// relatorio.typ — Relatório técnico do sistema (Prova Full Stack)
// Sistema: Guia do Mochileiro Fatecano
// Backend: PHP/Laravel · Interface: Blade (renderizada no servidor) · Banco: MariaDB
//
// Rascunho:  typst compile relatorio.typ
// Entrega:   typst compile relatorio.typ --input final=true
//            (falha se sobrar qualquer marcador PREENCHER/VERIFICAR/EQUIPE/PRINT)
//
// Roteiro de varredura do repositório: MAPEAMENTO.md
// =====================================================================
#import "modelo.typ": *

#show: relatorio.with(
  instituicao: [Faculdade de Tecnologia Shunji Nishimura — Fatec Pompeia],
  curso: [Tecnologia em Sistemas Inteligentes],
  disciplina: [Desenvolvimento Full Stack (IIS004)],
  professor: [Leonardo Alves Carrilho],
  autores: (
    [Marcio Gabriel Schinor Mazega],
    [Luis Gustavo Bonfim Ciaramicoli],
  ),
  titulo: [Guia do Mochileiro Fatecano],
  subtitulo: [Sistema web para organizar termos, matérias, horários e salas de aula],
  natureza: [Relatório técnico apresentado como avaliação da disciplina, descrevendo o desenvolvimento de um sistema web completo em PHP (Laravel), com interface renderizada no servidor em Blade e banco de dados MariaDB.],
  cidade: [Pompeia — SP],
  ano: [2026],
)

// Listagens de código longas (apêndices) podem continuar na página seguinte.
#show figure.where(kind: "codigo"): set block(breakable: true)

// Código dentro de tabelas: fonte menor e quebra permitida antes de "@" e depois de "/",
// para que nomes longos (Controller@metodo, rotas) não estourem a célula.
#show table: it => {
  show raw.where(block: false): r => {
    set text(size: 8pt)
    show "@": [#sym.zws\@]
    show "/": [/#sym.zws]
    r
  }
  it
}

// =====================================================================
// PRÉ-TEXTUAIS
// =====================================================================

// ------------------------------ RESUMO ------------------------------
#page(numbering: none)[
  #titulo-pre[RESUMO]
  #set par(first-line-indent: 0pt)

  Este relatório descreve o desenvolvimento do Guia do Mochileiro Fatecano, sistema web criado como projeto da disciplina de Desenvolvimento Full Stack para apoiar a organização dos estudos dos alunos da Fatec, em especial os ingressantes. A ideia partiu do professor Finoti, do curso Synapse, ex-aluno da instituição, que idealizou o frontend de um projeto de apoio aos estudos; a partir dela, a equipe completou o site. O objetivo foi desenvolver uma plataforma utilizável, com um propósito real, e não apenas uma entrega acadêmica, em que o estudante organiza seus termos e matérias, com dia da semana, horário e sala de cada aula. O sistema foi construído em PHP com o _framework_ Laravel, com interface renderizada no servidor por _templates_ Blade, banco de dados MariaDB com esquema versionado por _migrations_ e autenticação por sessão. A versão entregue permite cadastro e _login_, cria seis termos para cada nova conta, permite adicionar e remover turmas, cadastrar, editar e remover matérias, consultar as aulas do dia e acompanhar notificações das ações da conta, com telas adaptadas a computador e celular. Os 17 requisitos funcionais especificados foram atendidos e verificados em 19 casos de teste por requisição HTTP. Conclui-se que o sistema cumpre o objetivo proposto e serve de base para evoluções, como os grupos de estudo previstos na ideia original.

  #v(0.8em)
  *Palavras-chave:* Laravel. Blade. MariaDB. Desenvolvimento web full stack. Organização acadêmica.
]

// ----------------------------- ABSTRACT -----------------------------
// Opcional. Se o professor não exigir, apague esta página inteira.
#page(numbering: none)[
  #titulo-pre[ABSTRACT]
  #set par(first-line-indent: 0pt)
  This report describes the development of Guia do Mochileiro Fatecano, a web system created as a project for the Full Stack Development course to help Fatec students, especially first-year students, organize their studies. The idea came from Professor Finoti, from the Synapse course, a former Fatec student who conceived the frontend of a study support project; starting from that idea, the team completed the website. The goal was to develop a usable platform with a real purpose, and not just an academic deliverable, in which students organize their terms and subjects, with the weekday, time and room of each class. The system was built in PHP with the Laravel framework, with a server-rendered interface based on Blade templates, a MariaDB database with its schema versioned by migrations, and session-based authentication. The delivered version supports registration and login, creates six terms for each new account, and lets students add and remove classes, create, edit and remove subjects, check the classes of the day and follow notifications about account actions, with screens adapted to desktop and mobile. The 17 specified functional requirements were met and verified in 19 HTTP request test cases. The system fulfills the proposed goal and is a basis for future work, such as the study groups foreseen in the original idea.
  #v(0.8em)
  *Keywords:* Laravel. Blade. MariaDB. Full stack web development. Academic organization.
]

// ---------------------------- LISTAS -------------------------------
#page(numbering: none)[
  #titulo-pre[LISTA DE FIGURAS]
  #outline(title: none, target: figure.where(kind: image))
]
#page(numbering: none)[
  #titulo-pre[LISTA DE TABELAS]
  #outline(title: none, target: figure.where(kind: table))
  #v(2em)
  #titulo-pre[LISTA DE CÓDIGOS]
  #outline(title: none, target: figure.where(kind: "codigo"))
]

#page(numbering: none)[
  #titulo-pre[LISTA DE ABREVIATURAS E SIGLAS]
  #set par(first-line-indent: 0pt)
  #grid(
    columns: (3cm, 1fr), row-gutter: 0.7em,
    [API], [_Application Programming Interface_],
    [CORS], [_Cross-Origin Resource Sharing_],
    [CSRF], [_Cross-Site Request Forgery_],
    [CSS], [_Cascading Style Sheets_],
    [CT], [Caso de Teste],
    [FK], [_Foreign Key_ (chave estrangeira)],
    [HTML], [_Hypertext Markup Language_],
    [HTTP], [_Hypertext Transfer Protocol_],
    [JSON], [_JavaScript Object Notation_],
    [MVC], [_Model-View-Controller_],
    [ORM], [_Object-Relational Mapping_],
    [PK], [_Primary Key_ (chave primária)],
    [REST], [_Representational State Transfer_],
    [RF], [Requisito Funcional],
    [RNF], [Requisito Não Funcional],
    [RN], [Regra de Negócio],
    [SGBD], [Sistema Gerenciador de Banco de Dados],
    [PDO], [_PHP Data Objects_],
    [SPA], [_Single Page Application_],
    [SQL], [_Structured Query Language_],
    [URL], [_Uniform Resource Locator_],
  )
]

// ----------------------------- SUMÁRIO -----------------------------
#page(numbering: none)[
  #show outline.entry.where(level: 1): it => { v(0.4em); strong(it) }
  #titulo-pre[SUMÁRIO]
  #outline(title: none, indent: auto, depth: 3)
]

// =====================================================================
// TEXTUAIS — numeração no canto superior direito
// =====================================================================
#set page(
  numbering: "1",
  header: context align(right, text(size: 10pt, counter(page).display())),
  footer: none,
)

// =====================================================================
= Introdução
// =====================================================================

== Contextualização
O Guia do Mochileiro Fatecano é o projeto entregue pela equipe na disciplina de Desenvolvimento Full Stack (IIS004), ministrada pelo professor Leonardo Alves Carrilho no curso de Tecnologia em Sistemas Inteligentes da Fatec Pompeia.

A ideia do projeto é do professor Finoti, do curso Synapse. Ex-aluno da Fatec, ele idealizou o frontend de um projeto de apoio aos estudos dos alunos ingressantes, pensando inclusive em grupos de estudo. A partir dessa ideia, a equipe completou o site, e assim nasceu o Guia do Mochileiro Fatecano.

A versão entregue concentra-se na organização da rotina de aulas: o estudante reúne em um só lugar seus termos e matérias, com o dia da semana, o horário e a sala de cada aula, e consulta essas informações pelo computador ou pelo celular. Os grupos de estudo previstos na ideia original não fazem parte desta versão e ficam como trabalho futuro.

== Problema
Quem ingressa na Fatec passa a lidar, a cada semestre, com um conjunto de matérias, cada uma com professor, dia da semana, horário e sala próprios. A ideia original do projeto é apoiar esse aluno nos estudos, e o primeiro passo para isso é ter essas informações reunidas em um só lugar. O problema tratado neste trabalho pode ser resumido na pergunta: como permitir que o estudante da Fatec organize e consulte seus termos, matérias, horários e salas de forma centralizada e acessível pela web?

== Objetivos

=== Objetivo geral
Desenvolver um sistema web full stack, com backend em PHP utilizando o _framework_ Laravel, interface renderizada no servidor com _templates_ Blade e banco de dados MariaDB, que permita ao estudante da Fatec organizar e consultar seus termos, matérias, horários e salas de aula. Mais do que cumprir uma entrega da disciplina, a intenção é desenvolver uma plataforma utilizável, com um propósito real para os alunos.

=== Objetivos específicos
- Levantar e especificar os requisitos funcionais e não funcionais do sistema;
- Modelar o banco de dados relacional e implementá-lo por meio de _migrations_ do Laravel;
- Implementar as rotas, os _controllers_ e as regras de validação em Laravel, com autenticação por sessão e controle de acesso pelo dono de cada registro;
- Desenvolver a interface com _templates_ Blade e CSS próprio, adaptada a telas de computador e de celular;
- Permitir que o estudante organize seus termos e matérias, registrando dia da semana, horário e sala de cada aula, e consulte as aulas do dia;
- Validar o funcionamento do sistema por meio de testes de requisição HTTP que cobrem os fluxos principais.

== Justificativa
O projeto se justifica pela origem e pelo destino da ideia. Ela veio de um ex-aluno da Fatec, o professor Finoti, e se dirige aos alunos que estão ingressando no curso, como apoio aos estudos. Isso dá ao trabalho um uso real: a proposta é desenvolver uma plataforma utilizável, com um propósito, e não apenas cumprir uma entrega da disciplina.

Para o estudante, o ganho é ter termos, matérias, horários e salas organizados em um único lugar, consultável pelo navegador, sem instalação e sem custo. Essa organização é também a base sobre a qual outros recursos de apoio, como os grupos de estudo pensados na ideia original, podem ser acrescentados.

Do ponto de vista acadêmico, o projeto integra em um único sistema as camadas estudadas na disciplina (rotas e regras de negócio no backend, interface e banco de dados) e parte de uma ideia já iniciada, que a equipe precisou completar.

== Estrutura do documento
Este relatório está organizado da seguinte forma: a @fundamentacao apresenta os conceitos e as tecnologias utilizadas; a @metodologia descreve como o trabalho foi conduzido; a @especificacao reúne os requisitos e as regras de negócio; a @arquitetura detalha a arquitetura do backend e da interface; a @dados apresenta o modelo de dados; a @api documenta as rotas HTTP da aplicação; a @implementacao mostra as telas e os principais trechos de código; a @testes trata dos testes; a @implantacao explica como executar o sistema; a @resultados discute os resultados obtidos; e a @conclusao traz as considerações finais.

// =====================================================================
= Fundamentação teórica <fundamentacao>
// =====================================================================

== Arquitetura cliente-servidor e renderização no servidor
Em uma aplicação web, o cliente (navegador) se comunica com o servidor por requisições HTTP. Há duas formas comuns de montar a interface. Na renderização no servidor, cada requisição é atendida com uma página HTML já pronta, produzida a partir de um _template_ e dos dados consultados no banco; a navegação e o envio de formulários recarregam a página. Em uma _Single Page Application_ (SPA), o navegador carrega a aplicação uma única vez e passa a trocar apenas dados, normalmente em JSON, com uma API. O sistema descrito neste relatório adota a primeira forma: uma única aplicação Laravel recebe as requisições, aplica as regras de negócio e devolve o HTML das telas.

== HTTP e o estilo REST
O estilo arquitetural REST, definido por #cite(<fielding2000>, form: "prose"), organiza a comunicação em torno de recursos identificados por URIs e manipulados por métodos HTTP padronizados: `GET` para consulta, `POST` para criação, `PUT`/`PATCH` para atualização e `DELETE` para remoção. As respostas usam códigos de status HTTP para indicar o resultado, como `200` (sucesso), `302` (redirecionamento), `401` (não autenticado), `403` (sem permissão), `404` (não encontrado) e `422` (dados inválidos). O sistema desenvolvido não expõe uma API REST em JSON, mas suas rotas seguem a mesma convenção de recursos e métodos: as matérias, por exemplo, são declaradas com `Route::resource`, e os formulários HTML enviam `PUT`, `PATCH` e `DELETE` por meio do campo oculto `_method`.

== PHP e o framework Laravel
PHP é uma linguagem de _script_ voltada ao desenvolvimento web e executada no servidor @php-manual. O Laravel é um _framework_ PHP de código aberto que segue o padrão MVC e oferece, prontos, os componentes mais usados em aplicações web @laravel-docs. Os recursos do Laravel usados neste trabalho são:

- *Rotas e controladores:* as rotas das telas ficam em `routes/web.php` e direcionam cada requisição a um método de um _controller_;
- *Eloquent ORM:* implementação do padrão _Active Record_, em que cada tabela é representada por um _model_ e os relacionamentos (`hasMany`, `belongsTo`) são declarados como métodos;
- *Migrations:* o esquema do banco é versionado em código (`database/migrations`);
- *Validação:* regras declaradas no próprio _controller_ com `$request->validate()`; quando os dados são inválidos, o formulário é reapresentado com as mensagens de erro (ou a resposta é `422`, se a requisição pedir JSON);
- *Middleware:* camadas executadas antes do _controller_, usadas para sessão, proteção contra CSRF, autenticação (`auth`), acesso só de visitantes (`guest`) e limite de requisições (`throttle`);
- *Autenticação e autorização:* a autenticação usa o _guard_ `web`, baseado em sessão. O pacote Laravel Sanctum está instalado, mas protege apenas a rota padrão `GET /api/user`; nenhuma tela emite ou usa _token_. Não há _Policies_ nem _Gates_: cada _controller_ confere se o registro pertence ao usuário autenticado;
- *Artisan:* interface de linha de comando para rodar _migrations_, listar rotas e executar testes.

== Blade e a camada de apresentação
Blade é o mecanismo de _templates_ do Laravel @laravel-docs. Cada tela é um arquivo `.blade.php` em `resources/views`, que mistura HTML com diretivas como `@extends`, `@section`, `@include`, `@foreach` e `@csrf`. A herança de _layouts_ permite definir uma estrutura comum (cabeçalho, menu, folhas de estilo) e preencher apenas o conteúdo de cada página. Os _templates_ são compilados para PHP e executados no servidor, de modo que o navegador recebe HTML pronto. Neste trabalho a interface não usa _framework_ JavaScript: os estilos estão em arquivos CSS próprios e a interação acontece por _links_ e formulários.

== Banco de dados relacional e MariaDB
Um banco de dados relacional organiza os dados em tabelas ligadas por chaves primárias e estrangeiras, garantindo integridade referencial. O MariaDB é um SGBD relacional de código aberto, derivado do MySQL e compatível com ele, que funciona como um servidor: a aplicação se conecta a ele pela rede ou pela própria máquina e envia comandos SQL @mariadb-docs. Com o mecanismo de armazenamento InnoDB, padrão do MariaDB, ele oferece transações e chaves estrangeiras com ações em cascata. O Laravel traz uma conexão própria para o MariaDB (`mariadb`, em `config/database.php`), e o acesso é feito pela extensão PDO do PHP. A modelagem parte de um diagrama entidade-relacionamento e é normalizada para evitar redundância.

== Funcionalidades do sistema desenvolvido
Este trabalho não faz comparação com outros sistemas. A @tab-func resume as funcionalidades do sistema desenvolvido, detalhadas na @especificacao.

#tabela(legenda: [Funcionalidades do sistema desenvolvido])[
  #table(
    columns: (1.4fr, 2.2fr),
    table.header([*Funcionalidade*], [*Como aparece no sistema*]),
    [Matérias organizadas por termo (semestre)], [Cada conta nasce com seis termos; é possível adicionar e remover turmas],
    [Dia da semana, horário e sala de cada aula], [Campos do cadastro de matéria, com professor opcional],
    [Aulas do dia na tela inicial], [Lista das matérias cujo dia da semana é o dia corrente],
    [Notificações das ações da conta], [Registro de boas-vindas, de turmas adicionadas ou removidas e de matérias adicionadas],
    [Uso pelo navegador, sem instalação], [Telas adaptadas a computador e a celular],
    [Cadastro gratuito], [Conta criada com nome, e-mail e senha],
    [Código-fonte público], [Repositório no GitHub],
  )
] <tab-func>

// =====================================================================
= Metodologia <metodologia>
// =====================================================================

== Organização da equipe
A equipe é formada por dois integrantes. Luis Gustavo Bonfim Ciaramicoli ficou responsável pelo backend em Laravel e pelo frontend: o protótipo da interface havia sido feito em Angular, e ele refez as telas em Blade para manter todo o sistema na mesma _stack_. Marcio Gabriel Schinor Mazega ficou responsável pela documentação, pela modelagem, pela revisão e pelo versionamento do código.

Como o versionamento ficou a cargo de um único integrante e foi feito ao final, com o sistema já pronto na máquina virtual de desenvolvimento, o repositório tem um único _commit_, de 16/11/2026. Por isso a contagem da @tab-contrib, obtida com `git shortlog`, não mede a contribuição de cada integrante.

#tabela(legenda: [Contribuições por integrante no repositório])[
  #table(
    columns: (2fr, 1fr, 2fr),
    table.header([*Integrante*], [*Commits*], [*Principais áreas*]),
    [Marcio Gabriel Schinor Mazega], [1], [Versionamento do projeto inteiro (_commit_ único `5810793`)],
    [Luis Gustavo Bonfim Ciaramicoli], [0], [Backend e frontend, incluídos no _commit_ único],
  )
] <tab-contrib>

== Processo de desenvolvimento
O trabalho foi passado à equipe na quarta-feira, 11/11/2026. O levantamento de requisitos, feito a partir da ideia do professor Finoti, ocupou a quinta-feira, a sexta-feira e o sábado (12 a 14/11). O desenvolvimento começou no sábado, 14/11, e continuou no domingo, 15/11, com a modelagem do banco, a implementação do backend e a construção da interface. Os testes, o versionamento e a documentação foram feitos na segunda-feira, 16/11. O sistema foi desenvolvido sem _branches_ nem _pull requests_, e o versionamento foi feito ao final, em um único _commit_.

O sistema foi desenvolvido inicialmente com o SQLite, banco que o Laravel configura por padrão e que guarda tudo em um único arquivo. Na revisão do trabalho diante do enunciado da disciplina, que sugere MariaDB, MySQL ou PostgreSQL, a equipe migrou o banco para o MariaDB em 18/11/2026. Como o esquema é definido por _migrations_, a migração não exigiu mudança no código: bastou criar o banco e um usuário no MariaDB, trocar a conexão no arquivo `.env`, executar as _migrations_ e copiar os dados existentes. Os testes do @testes foram repetidos depois da migração.

Como o repositório tem um único _commit_, as datas da @tab-cronograma vêm do relato da equipe, da data embutida no nome dos arquivos de _migration_ e da data de modificação dos arquivos na máquina virtual de desenvolvimento. O protótipo de interface em Angular está em um repositório anterior e separado (`Schinor/Mochileiro-Fatecano`), sem ligação com o backend, e a estrutura base do Laravel já existia antes do início do trabalho.

#tabela(legenda: [Cronograma realizado])[
  #table(
    columns: (1.6fr, 1.1fr, 2.6fr),
    table.header([*Etapa*], [*Realizado*], [*Evidência*]),
    [Protótipo de interface (Angular)], [17/10/2025], [_Commits_ `ea76acd` a `348adf4` do repositório `Schinor/Mochileiro-Fatecano`],
    [Estrutura base do Laravel (anterior ao trabalho)], [04/11/2026], [`composer.json` e _migration_ `2026_11_04_232054` (tabela do Sanctum)],
    [Recebimento do trabalho], [11/11/2026], [Relato da equipe],
    [Levantamento de requisitos], [12 a 14/11/2026], [Relato da equipe; não há registro no repositório],
    [Modelagem do banco], [15/11/2026], [_Migrations_ `2026_11_15_000000` a `2026_11_15_000006`],
    [Backend Laravel], [14 e 15/11/2026], [Início em 14/11 conforme relato da equipe; arquivos de `app/Http/Controllers` e `app/Models` modificados em 15/11, entre 19h47 e 20h09],
    [Interface (Blade e CSS)], [14 e 15/11/2026], [Início em 14/11 conforme relato da equipe; arquivos de `resources/views` modificados em 15/11, entre 19h35 e 20h09],
    [Testes], [16/11/2026], [Execução de `php artisan test` e dos casos de teste da @tab-ct],
    [Versionamento], [16/11/2026], [_Commit_ `5810793` no repositório `Schinor/Mochileiro-Fatecano-Full`],
    [Documentação], [16/11/2026], [Preenchimento deste relatório (`docs/relatorio`)],
    [Migração para o MariaDB], [18/11/2026], [Banco `mochileiro` no MariaDB; `.env.example` atualizado; testes repetidos],
  )
] <tab-cronograma>

== Ferramentas e ambiente
#tabela(legenda: [Tecnologias e versões utilizadas])[
  #table(
    columns: (1.4fr, 1fr, 2fr),
    table.header([*Tecnologia*], [*Versão*], [*Uso no projeto*]),
    [PHP], [8.2.35 (o `composer.json` exige `^8.2`)], [Linguagem do backend],
    [Laravel], [12.70.2], [_Framework_ da aplicação (rotas, _controllers_, Eloquent, Blade)],
    [Laravel Sanctum], [4.3.3], [Instalado; protege apenas a rota padrão `GET /api/user`. O _login_ das telas usa sessão],
    [Composer], [2.10.3], [Gerenciador de dependências PHP],
    [Blade], [Parte do Laravel], [_Templates_ das telas, renderizados no servidor],
    [CSS], [—], [Estilos próprios em `public/css`, sem biblioteca de componentes],
    [MariaDB], [10.5.29], [Banco de dados (banco `mochileiro`, mecanismo InnoDB, conjunto de caracteres `utf8mb4`)],
    [PHPUnit], [11.5.57], [Testes automatizados (`php artisan test`)],
    [Rocky Linux], [9.8], [Sistema operacional da máquina virtual de desenvolvimento],
    [Servidor embutido do PHP], [—], [Execução por `php artisan serve` na porta 8001, mantida por uma unidade do systemd],
    [Git e GitHub], [Git 2.52.0], [Versionamento],
    [Plus Jakarta Sans], [—], [Fonte das telas, carregada do Google Fonts],
  )
]

== Uso de inteligência artificial
Ferramentas de inteligência artificial foram usadas no desenvolvimento do sistema e na elaboração deste relatório, e a equipe declara esse uso a seguir.

No desenvolvimento, a IA foi usada como apoio à escrita do código e das telas. A imagem da tela de cadastro (`public/imagens/Gemini_Generated_Image_sehlo3sehlo3sehl.png`) foi gerada com o Gemini, como indicam o nome do arquivo e os metadados da imagem, que a identificam como mídia gerada por algoritmo treinado.

No versionamento e na documentação, foi usado o assistente Claude Code. Sob orientação da equipe, ele percorreu o código para levantar rotas, tabelas e regras de negócio, gerou os diagramas, capturou as telas, planejou e executou os testes de requisição HTTP do @testes e redigiu o texto deste relatório a partir desse levantamento e das informações fornecidas pela equipe. Os dados técnicos foram extraídos do código ou da saída de comandos, e a equipe revisou o documento.

// =====================================================================
= Especificação do sistema <especificacao>
// =====================================================================

== Visão geral e escopo
O Guia do Mochileiro Fatecano é uma aplicação web em que o estudante organiza as aulas do curso. Depois de criar uma conta com nome, e-mail e senha, ele encontra na tela inicial seis termos já cadastrados (do 1° ao 6°), apresentados como cartões coloridos, e pode adicionar ou remover turmas. Em cada termo ele cadastra matérias, informando nome, professor (opcional), dia da semana, horário de início e de fim e sala. A tela inicial mostra também as aulas do dia corrente, e uma página reúne todas as matérias agrupadas por termo. O sistema registra notificações para as ações da conta (boas-vindas, turma adicionada ou removida, matéria adicionada), que o estudante pode marcar como lidas ou excluir. Cada usuário enxerga e altera apenas os próprios dados.

Ficaram fora do escopo da versão entregue: uma API REST em JSON e uma interface SPA (as telas são renderizadas no servidor); perfis diferenciados, como o de administrador; recuperação de senha e verificação de e-mail (a tabela `password_reset_tokens` existe, mas não há rota que a use); edição de turma (só é possível adicionar e remover) e do perfil do usuário; e testes automatizados das funcionalidades de domínio.

== Atores e perfis de acesso
O sistema tem um único perfil autenticado. Não existe coluna de papel na tabela `users`, nem _Policies_, _Gates_ ou _middlewares_ próprios; a autorização é feita pelo dono do registro (coluna `user_id`).

#tabela(legenda: [Perfis de usuário e permissões])[
  #table(
    columns: (1fr, 2.5fr),
    table.header([*Perfil*], [*O que pode fazer*]),
    [Visitante], [Ver a página de apresentação (`/`), cadastrar-se (`/register`) e entrar (`/login`). Qualquer outra rota o redireciona para `/login`.],
    [Estudante (usuário autenticado)], [Ver seus termos e as aulas do dia; adicionar e remover turmas; cadastrar, editar e remover matérias; ver, marcar como lidas e excluir notificações; sair. Só acessa registros próprios: os de outro usuário respondem `403`.],
  )
]

== Requisitos funcionais
A @tab-rf lista uma linha por funcionalidade existente no código. A prioridade foi atribuída no preenchimento deste relatório com o seguinte critério: _Alta_ para o que compõe o fluxo principal (conta, termos e matérias) e _Média_ para os recursos de apoio (página de apresentação e notificações).

#tabela(legenda: [Requisitos funcionais])[
  #table(
    columns: (0.6fr, 2.7fr, 0.9fr, 2.2fr),
    table.header([*ID*], [*Descrição*], [*Prioridade*], [*Onde está*]),
    [RF01], [O sistema deve permitir o cadastro de usuários.], [Alta], [`POST /register` · `AuthController@register`],
    [RF02], [O sistema deve permitir a autenticação (_login_ e _logout_).], [Alta], [`POST /login`, `POST /logout` · `AuthController`],
    [RF03], [O sistema deve apresentar uma página pública que descreve o produto e leva ao cadastro e ao _login_.], [Média], [`GET /` · view `landing`],
    [RF04], [Ao cadastrar um usuário, o sistema deve criar seus seis termos iniciais (1° a 6° Termo).], [Alta], [`AuthController@register`],
    [RF05], [O sistema deve listar os termos do usuário em cartões, com a quantidade de matérias de cada um.], [Alta], [`GET /inicio` · `TermoController@index`],
    [RF06], [O sistema deve mostrar, na tela inicial, as aulas do dia corrente com horário, matéria e sala.], [Alta], [`GET /inicio` · `TermoController@index`],
    [RF07], [O sistema deve permitir adicionar uma turma, com nome e cor do cartão.], [Alta], [`POST /termos` · `TermoController@store`],
    [RF08], [O sistema deve permitir remover uma turma, junto com as matérias dela.], [Alta], [`DELETE /termos/{termo}` · `TermoController@destroy`],
    [RF09], [O sistema deve exibir as matérias de um termo, ordenadas por dia da semana e horário.], [Alta], [`GET /termos/{termo}` · `TermoController@show`],
    [RF10], [O sistema deve listar todas as matérias do usuário, agrupadas por termo.], [Alta], [`GET /materias` · `MateriaController@index`],
    [RF11], [O sistema deve permitir cadastrar uma matéria com nome, professor, termo, dia da semana, horários e sala.], [Alta], [`GET /materias/create`, `POST /materias` · `MateriaController`],
    [RF12], [O sistema deve permitir editar uma matéria.], [Alta], [`GET /materias/{materia}/edit`, `PUT /materias/{materia}` · `MateriaController`],
    [RF13], [O sistema deve permitir remover uma matéria.], [Alta], [`DELETE /materias/{materia}` · `MateriaController@destroy`],
    [RF14], [O sistema deve registrar notificações automaticamente: boas-vindas no cadastro, turma adicionada ou removida e matéria adicionada.], [Média], [`AuthController`, `TermoController`, `MateriaController@store`],
    [RF15], [O sistema deve listar as notificações do usuário e indicar no menu quantas não foram lidas.], [Média], [`GET /notificacoes` · `NotificacaoController@index`; _layout_ `painel`],
    [RF16], [O sistema deve permitir marcar notificações como lidas, uma a uma ou todas de uma vez.], [Média], [`PATCH /notificacoes/{notificacao}`, `POST /notificacoes/ler-todas`],
    [RF17], [O sistema deve permitir excluir uma notificação.], [Média], [`DELETE /notificacoes/{notificacao}` · `NotificacaoController@destroy`],
  )
] <tab-rf>

== Requisitos não funcionais
#tabela(legenda: [Requisitos não funcionais])[
  #table(
    columns: (0.6fr, 1fr, 3fr),
    table.header([*ID*], [*Categoria*], [*Descrição*]),
    [RNF01], [Arquitetura], [A aplicação é implementada em PHP com Laravel, em um único projeto que atende as requisições e devolve páginas HTML. Não há API REST em JSON além da rota padrão `GET /api/user`.],
    [RNF02], [Interface], [A interface é renderizada no servidor com _templates_ Blade e estilizada com CSS próprio, sem _framework_ JavaScript.],
    [RNF03], [Persistência], [Os dados são armazenados no MariaDB, com esquema versionado por _migrations_ e chaves estrangeiras com exclusão em cascata.],
    [RNF04], [Segurança], [Senhas armazenadas com _hash_ bcrypt (_cast_ `hashed` do _model_ `User`; custo 12, definido por `BCRYPT_ROUNDS`); rotas protegidas exigem sessão autenticada.],
    [RNF05], [Segurança], [Todo formulário leva o _token_ de CSRF (`@csrf`); requisições sem ele são recusadas com `419`. Toda entrada é validada no backend. Não há configuração própria de CORS (`config/cors.php` não existe): páginas e formulários são servidos pela mesma origem.],
    [RNF06], [Segurança], [As rotas `POST /login` e `POST /register` aceitam no máximo 10 requisições por minuto (`throttle:10,1`); acima disso respondem `429`.],
    [RNF07], [Sessão], [A sessão é guardada no banco (tabela `sessions`), dura 120 minutos e usa _cookie_ `HttpOnly` com `SameSite=Lax`; o identificador é regenerado no _login_ e invalidado no _logout_.],
    [RNF08], [Usabilidade], [As telas são responsivas, com _media queries_ em 1100, 860 e 480 px (`public/css/app.css`) e em 900 e 520 px (`public/css/landing.css`); em telas estreitas o menu vira um botão. Não há biblioteca de interface.],
    [RNF09], [Localização], [A aplicação usa o idioma `pt_BR` e o fuso `America/Sao_Paulo`; as mensagens de validação estão traduzidas em `lang/pt_BR/validation.php`, com exceção das regras `confirmed` e `regex`.],
  )
]

== Regras de negócio
As regras abaixo foram extraídas do código e estão no formato "se X, então Y", com o arquivo onde cada uma é aplicada.

#tabela(legenda: [Regras de negócio])[
  #table(
    columns: (0.6fr, 3fr, 1.8fr),
    table.header([*ID*], [*Regra*], [*Arquivo*]),
    [RN01], [Se o e-mail já estiver cadastrado, então o cadastro é recusado e o formulário volta com a mensagem de erro (`422`, se a requisição pedir JSON).], [`AuthController@register`, regra `unique:users,email`],
    [RN02], [Se a requisição não tiver sessão autenticada, então a rota protegida redireciona para `/login`.], [_Middleware_ `auth` em `routes/web.php`; `redirectGuestsTo` em `bootstrap/app.php`],
    [RN03], [Se um usuário já autenticado abrir `/`, `/login` ou `/register`, então é redirecionado para `/inicio`.], [_Middleware_ `guest` em `routes/web.php`; `redirectUsersTo` em `bootstrap/app.php`],
    [RN04], [Se a senha tiver menos de 6 caracteres ou a confirmação for diferente, então o cadastro é recusado.], [`AuthController@register`, regra `min:6|confirmed`],
    [RN05], [Se o cadastro for concluído, então são criados seis termos ("1°Termo" a "6°Termo"), cada um com uma cor fixa, e uma notificação de boas-vindas.], [`AuthController@register`],
    [RN06], [Se o e-mail ou a senha do _login_ estiverem errados, então o acesso é negado com uma mensagem única, que não diz qual dos dois falhou.], [`AuthController@login`],
    [RN07], [Se o termo, a matéria ou a notificação pertencer a outro usuário, então a ação responde `403`.], [`abort_unless` em `TermoController`, `MateriaController` e `NotificacaoController`],
    [RN08], [Se o termo informado na matéria não existir ou for de outro usuário, então a matéria é recusada.], [`MateriaController@validar`, `Rule::exists` com `user_id`],
    [RN09], [Se o horário de fim não for posterior ao de início, então a matéria é recusada.], [`MateriaController@validar`, regra `after:horario_inicio`],
    [RN10], [Se o dia da semana não estiver entre 1 (segunda-feira) e 7 (domingo), então a matéria é recusada.], [`MateriaController@validar`; constante `Materia::DIAS`],
    [RN11], [Se faltar nome, termo, dia da semana, horário de início, horário de fim ou sala, então a matéria é recusada; apenas o professor é opcional.], [`MateriaController@validar`],
    [RN12], [Se o nome da turma estiver vazio ou passar de 50 caracteres, ou a cor não estiver no formato `#RRGGBB`, então a turma é recusada.], [`TermoController@store`],
    [RN13], [Se uma turma for removida, então todas as matérias dela são removidas junto.], [Chave estrangeira com `cascadeOnDelete` em `create_materias_table`],
    [RN14], [Se uma turma for adicionada ou removida, ou uma matéria for adicionada, então uma notificação é gravada para o usuário.], [`TermoController`, `MateriaController@store`],
    [RN15], [Se houver mais de 10 envios de _login_ e de cadastro, somados, vindos do mesmo endereço IP em um minuto, então os seguintes respondem `429`.], [`throttle:10,1` em `routes/web.php`],
    [RN16], [Se uma matéria tiver o dia da semana igual ao dia corrente, então ela aparece em "Aulas de hoje"; as listas são ordenadas por dia, horário de início e nome.], [`TermoController@index`; `Materia::scopeOrdenadas`],
  )
]

== Casos de uso
#figura(legenda: [Diagrama de casos de uso])[
  #image("figuras/casos-de-uso.png", height: 18.5cm)
]

// =====================================================================
= Arquitetura e projeto <arquitetura>
// =====================================================================

== Visão geral
O sistema segue a arquitetura cliente-servidor em uma única aplicação Laravel, organizada no padrão MVC. O navegador envia requisições HTTP (navegação por _links_ e envio de formulários); a aplicação aplica autenticação, validação e regras de negócio, persiste os dados no MariaDB por meio do Eloquent e devolve uma página HTML renderizada pelo Blade ou um redirecionamento. Não há frontend separado nem troca de JSON entre as camadas. A @fig-arquitetura mostra os componentes e o fluxo de uma requisição.

#figura(legenda: [Arquitetura geral do sistema])[
  #image("figuras/arquitetura.png", width: 100%)
] <fig-arquitetura>

== Backend (Laravel)
O fluxo de uma requisição no backend passa pelas seguintes camadas:

+ *Rota* (`routes/web.php`): associa método HTTP e URI a uma ação de _controller_;
+ *Middleware*: o grupo `web` (sessão, _cookies_ e verificação de CSRF) em todas as rotas das telas; `auth` nas rotas autenticadas; `guest` nas rotas de visitante; e `throttle:10,1` nos envios de _login_ e de cadastro;
+ *Validação*: feita no próprio _controller_ com `$request->validate()`; o projeto não tem _Form Requests_ (`app/Http/Requests` não existe);
+ *Controller* (`app/Http/Controllers`): orquestra a ação e confere, com `abort_unless`, se o registro pertence ao usuário;
+ *Model* (`app/Models`): acesso ao banco via Eloquent;
+ *Resposta*: uma _view_ Blade (HTML) nas consultas e um redirecionamento com mensagem de sucesso ou de erro nas gravações; o projeto não usa _API Resources_.

#tabela(legenda: [Organização dos diretórios do backend])[
  #table(
    columns: (1.8fr, 3fr),
    table.header([*Diretório*], [*Conteúdo*]),
    [`app/Http/Controllers`], [`AuthController`, `TermoController`, `MateriaController`, `NotificacaoController` e a classe base `Controller`],
    [`app/Models`], [`User`, `Termo`, `Materia`, `Notificacao`],
    [`app/Http/Requests`], [Não existe (validação nos _controllers_)],
    [`app/Policies`], [Não existe (autorização por `abort_unless` nos _controllers_)],
    [`database/migrations`], [11 _migrations_ (4 do Laravel e do Sanctum, 7 do domínio)],
    [`database/factories`], [`UserFactory`, padrão do Laravel],
    [`database/seeders`], [Vazio],
    [`routes/web.php`], [Rotas das telas],
    [`routes/api.php`], [Apenas a rota padrão `GET /api/user`],
    [`resources/views`], [12 _views_ do sistema (_layouts_, autenticação, termos, matérias, notificações, mensagens e página de apresentação) e a `welcome` padrão do Laravel, que não é usada],
    [`public/css`], [`app.css` (telas do sistema) e `landing.css` (página de apresentação)],
    [`tests/`], [Dois testes de exemplo do Laravel (`Feature/ExampleTest` e `Unit/ExampleTest`)],
  )
]

== Frontend (Blade)
A interface é formada por _templates_ Blade com herança de _layouts_: `layouts/app` define o HTML base e carrega a fonte e o `app.css`; `layouts/painel` o estende com o cabeçalho, o menu e o contador de notificações não lidas; as demais telas preenchem a seção de conteúdo. Não há biblioteca de interface nem _framework_ JavaScript: o único JavaScript é o embutido em atributos HTML para abrir a janela "Adicionar turma" (elemento `<dialog>`) e pedir confirmação antes de remover. Nenhum _token_ é guardado no navegador; a autenticação depende apenas do _cookie_ de sessão. O protótipo da interface foi feito em Angular 20 e está no repositório anterior `Schinor/Mochileiro-Fatecano`, com as telas de _login_, cadastro e início e sem _services_ de acesso ao backend. Na versão entregue, as telas foram refeitas em Blade para manter todo o sistema na mesma _stack_; os arquivos de ícones e imagens têm os mesmos nomes nos dois projetos.

#tabela(legenda: [Telas do sistema e rotas correspondentes])[
  #table(
    columns: (1.5fr, 1.5fr, 0.8fr, 1.7fr),
    table.header([*Rota*], [*View*], [*Middleware*], [*Descrição*]),
    [`/`], [`landing`], [`guest`], [Página de apresentação],
    [`/login`], [`auth/login`], [`guest`], [Autenticação],
    [`/register`], [`auth/register`], [`guest`], [Cadastro de usuário],
    [`/inicio`], [`termos/index`], [`auth`], [Termos em cartões e aulas de hoje],
    [`/termos/{termo}`], [`termos/show`], [`auth`], [Matérias de um termo],
    [`/materias`], [`materias/index`], [`auth`], [Todas as matérias, por termo],
    [`/materias/create` e `/materias/{materia}/edit`], [`materias/form`], [`auth`], [Formulário de criação e edição],
    [`/notificacoes`], [`notificacoes/index`], [`auth`], [Lista de notificações],
  )
]

Como não existe camada de _services_ no navegador, a @tab-forms mostra, no lugar dela, os formulários de cada tela e as rotas que eles acionam.

#tabela(legenda: [Formulários das telas e rotas acionadas])[
  #table(
    columns: (1.4fr, 3fr),
    table.header([*View*], [*Rotas acionadas*]),
    [`auth/login`], [`POST /login`],
    [`auth/register`], [`POST /register`],
    [`layouts/painel`], [`POST /logout`],
    [`termos/index`], [`POST /termos`, `DELETE /termos/{termo}`],
    [`materias/form`], [`POST /materias`, `PUT /materias/{materia}`],
    [`materias/_linha`], [`DELETE /materias/{materia}`],
    [`notificacoes/index`], [`POST /notificacoes/ler-todas`, `PATCH /notificacoes/{notificacao}`, `DELETE /notificacoes/{notificacao}`],
  )
] <tab-forms>

== Autenticação e autorização
A autenticação é por sessão. O formulário de _login_ envia e-mail, senha e o _token_ de CSRF para `POST /login`; o `AuthController` valida os campos e chama `Auth::attempt`, que busca o usuário pelo e-mail e compara a senha com o _hash_ gravado. Se as credenciais estiverem corretas, o identificador da sessão é regenerado e o navegador é redirecionado para `/inicio` (ou para a página que tentou abrir antes); se não, o formulário volta com a mensagem "E-mail ou senha incorretos.". A sessão fica na tabela `sessions` e o navegador guarda apenas o _cookie_ de sessão, enviado automaticamente a cada requisição. O _middleware_ `auth` lê esse _cookie_, carrega o usuário e libera a rota; sem sessão válida, redireciona para `/login`. O _logout_ (`POST /logout`) encerra a autenticação, invalida a sessão e gera um novo _token_ de CSRF. A @fig-auth resume o fluxo.

A autorização não usa perfis. Todos os registros de domínio têm a coluna `user_id`; as consultas filtram por ela, e as ações sobre um registro específico chamam `abort_unless`, que responde `403` quando o dono é outro usuário.

#figura(legenda: [Fluxo de autenticação])[
  #image("figuras/fluxo-autenticacao.png", width: 100%)
] <fig-auth>

// =====================================================================
= Modelo de dados <dados>
// =====================================================================

== Integração da aplicação com o banco
A aplicação usa o banco `mochileiro` em um servidor MariaDB 10.5.29 na mesma máquina virtual. A conexão é definida no arquivo `.env`, pelas variáveis `DB_CONNECTION=mariadb`, `DB_HOST`, `DB_PORT`, `DB_DATABASE`, `DB_USERNAME` e `DB_PASSWORD`, que o Laravel lê na conexão `mariadb` de `config/database.php`. O acesso é feito com um usuário próprio, `mochileiro`, que tem permissão apenas sobre esse banco. Os _models_ do Eloquent geram os comandos SQL de consulta e gravação, e as _migrations_ criam as tabelas. A @fig-tabelas mostra as tabelas criadas e as chaves estrangeiras, consultadas diretamente no MariaDB.

#figura(legenda: [Tabelas e chaves estrangeiras do banco `mochileiro` no MariaDB], fonte-txt: [Saída do cliente `mysql` na máquina virtual, obtida pelos autores (2026). A consulta às chaves estrangeiras em `information_schema` foi abreviada no _prompt_.])[
  #image("figuras/tabelas-mariadb.png", width: 72%)
] <fig-tabelas>

== Diagrama entidade-relacionamento
#figura(legenda: [Diagrama entidade-relacionamento do banco de dados])[
  #image("figuras/der.png", height: 18.5cm)
] <fig-der>

== Dicionário de dados
O banco tem quatro tabelas de domínio, descritas a seguir com os tipos informados pelo comando `DESCRIBE` no MariaDB (@fig-estrutura). Todas usam o mecanismo InnoDB e o _collation_ `utf8mb4_unicode_ci`. As demais nove tabelas são internas do Laravel e do Sanctum e não guardam dados de domínio: `cache`, `cache_locks`, `jobs`, `job_batches`, `failed_jobs`, `sessions`, `password_reset_tokens`, `personal_access_tokens` e `migrations`.

#tabela(legenda: [Dicionário de dados — tabela `users`])[
  #table(
    columns: (1.3fr, 1.1fr, 1.3fr, 2.3fr),
    table.header([*Coluna*], [*Tipo*], [*Restrições*], [*Descrição*]),
    [`id`], [bigint(20) unsigned], [PK, autoincremento], [Identificador],
    [`name`], [varchar(255)], [NOT NULL], [Nome do usuário],
    [`email`], [varchar(255)], [NOT NULL, único], [E-mail usado no _login_],
    [`email_verified_at`], [timestamp], [NULL], [Data de verificação do e-mail (não utilizada pelo sistema)],
    [`password`], [varchar(255)], [NOT NULL], [_Hash_ bcrypt da senha],
    [`remember_token`], [varchar(100)], [NULL], [_Token_ de "lembrar-me" do Laravel (não utilizado pelo sistema)],
    [`created_at` / `updated_at`], [timestamp], [NULL], [Controle do Laravel],
  )
]

#tabela(legenda: [Dicionário de dados — tabela `termos`])[
  #table(
    columns: (1.3fr, 1.1fr, 1.3fr, 2.3fr),
    table.header([*Coluna*], [*Tipo*], [*Restrições*], [*Descrição*]),
    [`id`], [bigint(20) unsigned], [PK, autoincremento], [Identificador],
    [`user_id`], [bigint(20) unsigned], [NOT NULL, FK para `users.id`, exclusão em cascata], [Dono do termo],
    [`nome`], [varchar(255)], [NOT NULL], [Nome do termo ou turma (até 50 caracteres na validação)],
    [`cor`], [varchar(7)], [NOT NULL, padrão `#E2F4C5`], [Cor do cartão em hexadecimal],
    [`created_at` / `updated_at`], [timestamp], [NULL], [Controle do Laravel],
  )
]

#tabela(legenda: [Dicionário de dados — tabela `materias`])[
  #table(
    columns: (1.3fr, 1.1fr, 1.3fr, 2.3fr),
    table.header([*Coluna*], [*Tipo*], [*Restrições*], [*Descrição*]),
    [`id`], [bigint(20) unsigned], [PK, autoincremento], [Identificador],
    [`user_id`], [bigint(20) unsigned], [NOT NULL, FK para `users.id`, exclusão em cascata], [Dono da matéria],
    [`termo_id`], [bigint(20) unsigned], [NOT NULL, FK para `termos.id`, exclusão em cascata], [Termo a que a matéria pertence],
    [`nome`], [varchar(255)], [NOT NULL], [Nome da matéria],
    [`professor`], [varchar(255)], [NULL], [Nome do professor (opcional)],
    [`dia_semana`], [tinyint(3) unsigned], [NULL], [Dia da aula, de 1 (segunda-feira) a 7 (domingo); obrigatório na validação],
    [`horario_inicio`], [varchar(5)], [NULL], [Início da aula no formato `HH:MM`; obrigatório na validação],
    [`horario_fim`], [varchar(5)], [NULL], [Fim da aula no formato `HH:MM`; obrigatório na validação],
    [`sala`], [varchar(50)], [NULL], [Sala ou laboratório; obrigatória na validação],
    [`created_at` / `updated_at`], [timestamp], [NULL], [Controle do Laravel],
  )
]

#tabela(legenda: [Dicionário de dados — tabela `notificacoes`])[
  #table(
    columns: (1.3fr, 1.1fr, 1.3fr, 2.3fr),
    table.header([*Coluna*], [*Tipo*], [*Restrições*], [*Descrição*]),
    [`id`], [bigint(20) unsigned], [PK, autoincremento], [Identificador],
    [`user_id`], [bigint(20) unsigned], [NOT NULL, FK para `users.id`, exclusão em cascata], [Usuário que recebe a notificação],
    [`texto`], [varchar(255)], [NOT NULL], [Mensagem exibida],
    [`lida`], [tinyint(1)], [NOT NULL, padrão `0`], [Indica se a notificação foi lida],
    [`created_at` / `updated_at`], [timestamp], [NULL], [Controle do Laravel],
  )
]

#figura(legenda: [Estrutura das tabelas de domínio no MariaDB (comando `DESCRIBE`)], fonte-txt: [Saída do cliente `mysql` na máquina virtual, obtida pelos autores (2026).])[
  #image("figuras/estrutura-mariadb.png", height: 19cm)
] <fig-estrutura>

== Relacionamentos
Todas as ligações são chaves estrangeiras com exclusão em cascata. Apenas a ligação entre termo e matéria está declarada também como método nos _models_; as ligações com o usuário existem só no banco, e os _controllers_ consultam por `where('user_id', ...)`.

#tabela(legenda: [Relacionamentos entre entidades])[
  #table(
    columns: (1.2fr, 1fr, 1.2fr, 2.6fr),
    table.header([*Entidade*], [*Cardinalidade*], [*Entidade*], [*No Eloquent*]),
    [`Termo`], [1:N], [`Materia`], [`Termo::materias()` (`hasMany`) e `Materia::termo()` (`belongsTo`)],
    [`User`], [1:N], [`Termo`], [Sem método; chave estrangeira `termos.user_id`],
    [`User`], [1:N], [`Materia`], [Sem método; chave estrangeira `materias.user_id`],
    [`User`], [1:N], [`Notificacao`], [Sem método; chave estrangeira `notificacoes.user_id`],
  )
]

== Migrations e dados iniciais
O esquema é criado por 11 _migrations_, executadas nesta ordem:

+ `0001_01_01_000000_create_users_table` — tabelas `users`, `password_reset_tokens` e `sessions`;
+ `0001_01_01_000001_create_cache_table` — tabelas `cache` e `cache_locks`;
+ `0001_01_01_000002_create_jobs_table` — tabelas `jobs`, `job_batches` e `failed_jobs`;
+ `2026_11_04_232054_create_personal_access_tokens_table` — tabela do Sanctum;
+ `2026_11_15_000000_create_termos_table` — tabela `termos`;
+ `2026_11_15_000001_create_materias_table` — tabela `materias` (nome e professor);
+ `2026_11_15_000002_create_valores_table` — tabela `valores`;
+ `2026_11_15_000003_create_notificacoes_table` — tabela `notificacoes`;
+ `2026_11_15_000004_add_horario_to_materias_table` — colunas `dia_semana`, `horario_inicio` e `horario_fim`;
+ `2026_11_15_000005_drop_valores_table` — remove a tabela `valores`, que não faz parte da versão entregue;
+ `2026_11_15_000006_add_sala_to_materias_table` — coluna `sala`.

Não há _seeders_: o diretório `database/seeders` está vazio, e nenhum usuário padrão é criado. A única _factory_ é a `UserFactory` do Laravel. Os dados iniciais de cada conta nascem no cadastro, quando o `AuthController` cria os seis termos e a notificação de boas-vindas.

// =====================================================================
= Rotas HTTP da aplicação <api>
// =====================================================================

== Rotas
A aplicação não expõe uma API REST em JSON. As 20 rotas de `routes/web.php` atendem as telas: respondem com HTML ou com redirecionamento e recebem dados de formulário (`application/x-www-form-urlencoded`). A única rota de API é `GET /api/user`, padrão do Laravel, protegida por `auth:sanctum`. Na máquina virtual de desenvolvimento a aplicação atende na porta 8001. A @tab-rotas foi montada a partir de `php artisan route:list -v`; as quatro rotas internas do _framework_ aparecem no Apêndice B, e o arquivo `routes/web.php` completo, no Apêndice A.

#tabela(legenda: [Rotas da aplicação])[
  #table(
    columns: (0.8fr, 2fr, 2.5fr, 1.3fr, 1.9fr),
    table.header([*Método*], [*Rota*], [*Ação*], [*Acesso*], [*Descrição*]),
    [`GET`], [`/`], [_view_ `landing`], [Visitante], [Página de apresentação],
    [`GET`], [`/register`], [`AuthController@showRegister`], [Visitante], [Formulário de cadastro],
    [`POST`], [`/register`], [`AuthController@register`], [Visitante, 10/min], [Cadastro],
    [`GET`], [`/login`], [`AuthController@showLogin`], [Visitante], [Formulário de _login_],
    [`POST`], [`/login`], [`AuthController@login`], [Visitante, 10/min], [Autenticação],
    [`POST`], [`/logout`], [`AuthController@logout`], [Autenticado], [Encerra a sessão],
    [`GET`], [`/inicio`], [`TermoController@index`], [Autenticado], [Termos e aulas de hoje],
    [`POST`], [`/termos`], [`TermoController@store`], [Autenticado], [Adiciona turma],
    [`GET`], [`/termos/{termo}`], [`TermoController@show`], [Autenticado, dono], [Matérias do termo],
    [`DELETE`], [`/termos/{termo}`], [`TermoController@destroy`], [Autenticado, dono], [Remove turma e matérias],
    [`GET`], [`/materias`], [`MateriaController@index`], [Autenticado], [Matérias por termo],
    [`GET`], [`/materias/create`], [`MateriaController@create`], [Autenticado], [Formulário de criação],
    [`POST`], [`/materias`], [`MateriaController@store`], [Autenticado], [Cadastra matéria],
    [`GET`], [`/materias/{materia}/edit`], [`MateriaController@edit`], [Autenticado, dono], [Formulário de edição],
    [`PUT` `PATCH`], [`/materias/{materia}`], [`MateriaController@update`], [Autenticado, dono], [Atualiza matéria],
    [`DELETE`], [`/materias/{materia}`], [`MateriaController@destroy`], [Autenticado, dono], [Remove matéria],
    [`GET`], [`/notificacoes`], [`NotificacaoController@index`], [Autenticado], [Lista notificações],
    [`POST`], [`/notificacoes/ler-todas`], [`NotificacaoController@lerTodas`], [Autenticado], [Marca todas como lidas],
    [`PATCH`], [`/notificacoes/{notificacao}`], [`NotificacaoController@update`], [Autenticado, dono], [Marca como lida],
    [`DELETE`], [`/notificacoes/{notificacao}`], [`NotificacaoController@destroy`], [Autenticado, dono], [Exclui notificação],
    [`GET`], [`/api/user`], [função em `routes/api.php`], [Autenticado (Sanctum)], [Devolve o usuário autenticado em JSON],
  )
] <tab-rotas>

== Exemplos de requisição e resposta
Os exemplos abaixo foram obtidos com `curl` em 16/11/2026, contra uma instância de teste com banco separado e usuário criado só para isso. O _token_ de CSRF, a senha e os _cookies_ estão mascarados.

#codigo(legenda: [Exemplo de requisição de autenticação])[
  #show raw: set text(size: 7.5pt)
  ```http
  POST /login HTTP/1.1
  Content-Type: application/x-www-form-urlencoded
  Cookie: guia-do-mochileiro-fatecano-session=eyJpdiI6…(mascarado)

  _token=AbCd…(mascarado)&email=estudante.teste%40example.com&password=********

  HTTP/1.1 302 Found
  Location: http://127.0.0.1:18002/inicio
  Content-Type: text/html; charset=utf-8
  X-RateLimit-Limit: 10
  X-RateLimit-Remaining: 9
  Set-Cookie: XSRF-TOKEN=eyJpdiI6…(mascarado); Max-Age=7200; path=/; samesite=lax
  Set-Cookie: guia-do-mochileiro-fatecano-session=eyJpdiI6…(mascarado); Max-Age=7200; path=/; httponly; samesite=lax
  ```
]

#codigo(legenda: [Exemplo de requisição ao recurso principal (cadastro de matéria)])[
  #show raw: set text(size: 7.5pt)
  ```http
  POST /materias HTTP/1.1
  Content-Type: application/x-www-form-urlencoded
  Cookie: guia-do-mochileiro-fatecano-session=eyJpdiI6…(mascarado)

  _token=AbCd…(mascarado)&nome=Banco+de+Dados&professor=Maria+Souza&termo_id=1
    &dia_semana=1&sala=Laborat%C3%B3rio+3&horario_inicio=19%3A00&horario_fim=20%3A40

  HTTP/1.1 302 Found
  Location: http://127.0.0.1:18002/termos/1
  Content-Type: text/html; charset=utf-8
  ```
]

Quando a mesma rota recebe dados inválidos e o cabeçalho `Accept: application/json`, o Laravel responde com os erros por campo:

#codigo(legenda: [Resposta de validação em JSON (matéria sem nome e com horário de fim anterior ao de início)])[
  #show raw: set text(size: 7.5pt)
  ```http
  HTTP/1.1 422 Unprocessable Content
  Content-Type: application/json

  {"message":"O campo nome é obrigatório. (and 1 more error)",
   "errors":{"nome":["O campo nome é obrigatório."],
             "horario_fim":["O horário de fim deve ser depois do horário de início."]}}
  ```
]

== Tratamento de erros
#tabela(legenda: [Códigos de status retornados pela aplicação])[
  #table(
    columns: (0.8fr, 3fr),
    table.header([*Código*], [*Quando ocorre*]),
    [`200`], [Página exibida com sucesso],
    [`302`], [Resposta de toda gravação bem-sucedida (cadastro, _login_, criação, edição e remoção), que redireciona para a tela seguinte com uma mensagem; também devolve o formulário quando a validação falha e leva ao `/login` quem não está autenticado],
    [`401`], [Requisição sem autenticação que pede JSON (por exemplo, `GET /api/user` com `Accept: application/json`)],
    [`403`], [Usuário autenticado tentando acessar termo, matéria ou notificação de outro usuário],
    [`404`], [Rota inexistente ou registro não encontrado (por exemplo, matéria já removida)],
    [`419`], [Formulário enviado sem o _token_ de CSRF ou com _token_ expirado],
    [`422`], [Falha de validação quando a requisição pede JSON — o corpo traz os erros por campo],
    [`429`], [Mais de 10 envios de _login_ e de cadastro, somados, do mesmo endereço IP em um minuto],
  )
]

Os códigos `201` e `204` não são usados: como as respostas são páginas e não JSON, criações e remoções terminam em redirecionamento (`302`).

// =====================================================================
= Implementação <implementacao>
// =====================================================================

== Telas do sistema
Os _prints_ a seguir foram capturados em 16/11/2026 com o sistema em execução, em janela de 1366 × 768 px, usando um usuário e matérias de teste criados apenas para a captura.

A página de apresentação (@fig-landing) é a única aberta a visitantes além do _login_ e do cadastro; ela descreve o produto e leva às duas telas.

#figura(legenda: [Página de apresentação])[
  #image("figuras/tela-landing.png", width: 88%)
] <fig-landing>

O cadastro (@fig-cadastro) pede nome, e-mail, senha e confirmação da senha. O _login_ (@fig-login) pede e-mail e senha.

#figura(legenda: [Tela de cadastro])[
  #image("figuras/tela-cadastro.png", width: 78%)
] <fig-cadastro>

#figura(legenda: [Tela de login])[
  #image("figuras/tela-login.png", width: 78%)
] <fig-login>

Depois do _login_, a tela inicial (@fig-principal) mostra as aulas do dia e os termos do usuário em cartões, com a quantidade de matérias de cada um, o botão "Adicionar turma" e o botão de remover em cada cartão.

#figura(legenda: [Tela principal / painel])[
  #image("figuras/tela-principal.png", width: 85%)
] <fig-principal>

Ao abrir um termo (@fig-termo), o estudante vê as matérias dele em ordem de dia e horário, com os botões de editar e remover.

#figura(legenda: [Matérias de um termo])[
  #image("figuras/tela-termo.png", width: 85%)
] <fig-termo>

A página "Matérias" (@fig-listagem) lista todas as matérias agrupadas por termo.

#figura(legenda: [Listagem do recurso principal (matérias por termo)])[
  #image("figuras/tela-listagem.png", width: 78%)
] <fig-listagem>

O formulário de matéria (@fig-formulario) serve para criação e edição. No _print_, o envio sem nome e com horário de fim anterior ao de início devolveu o formulário com os campos destacados e as mensagens de validação.

#figura(legenda: [Formulário de cadastro/edição, com erros de validação])[
  #image("figuras/tela-formulario.png", width: 80%)
] <fig-formulario>

A página de notificações (@fig-notificacoes) mostra o que aconteceu na conta e permite marcar como lida ou excluir.

#figura(legenda: [Tela de notificações])[
  #image("figuras/tela-notificacoes.png", width: 80%)
] <fig-notificacoes>

Em telas estreitas (@fig-mobile), o menu vira um botão e os blocos passam a ocupar a largura inteira.

#figura(legenda: [Tela principal em largura de celular (390 px)])[
  #image("figuras/tela-mobile.png", height: 12cm)
] <fig-mobile>

== Trechos relevantes do código
O primeiro trecho mostra o grupo de rotas protegidas. Tudo o que está dentro de `Route::middleware('auth')` exige sessão autenticada; as matérias usam `Route::resource`, que gera de uma vez as rotas de listar, criar, editar, atualizar e remover. O arquivo `routes/web.php` completo, com as rotas de visitante (página de apresentação, _login_ e cadastro) e de _logout_, está no Apêndice A.

#codigo(legenda: [Definição das rotas protegidas (`routes/web.php`)])[
  #show raw: set text(size: 7.5pt)
  ```php
  Route::middleware('auth')->group(function () {
      Route::get('/inicio', [TermoController::class, 'index']);
      Route::get('/termos/{termo}', [TermoController::class, 'show']);
      Route::post('/termos', [TermoController::class, 'store']);
      Route::delete('/termos/{termo}', [TermoController::class, 'destroy']);

      // Matérias
      Route::resource('materias', MateriaController::class)->except('show');

      // Notificações
      Route::get('/notificacoes', [NotificacaoController::class, 'index']);
      Route::post('/notificacoes/ler-todas', [NotificacaoController::class, 'lerTodas']);
      Route::patch('/notificacoes/{notificacao}', [NotificacaoController::class, 'update']);
      Route::delete('/notificacoes/{notificacao}', [NotificacaoController::class, 'destroy']);
  });
  ```
]

O _model_ `Materia` declara os campos que podem ser preenchidos em massa, o relacionamento com o termo e o escopo `ordenadas`, reutilizado em todas as listagens para manter a ordem por dia da semana e horário.

#codigo(legenda: [Model com relacionamento Eloquent e escopo de ordenação (`app/Models/Materia.php`)])[
  #show raw: set text(size: 7.5pt)
  ```php
  protected $fillable = ['user_id', 'termo_id', 'nome', 'professor', 'dia_semana', 'horario_inicio', 'horario_fim', 'sala'];

  public function termo()
  {
      return $this->belongsTo(Termo::class);
  }

  /**
   * Ordena por dia da semana e horário de início.
   */
  public function scopeOrdenadas($query)
  {
      return $query->orderBy('dia_semana')->orderBy('horario_inicio')->orderBy('nome');
  }
  ```
]

As regras de validação da matéria ficam em um método privado do _controller_, usado tanto na criação quanto na edição. A regra de `termo_id` combina existência e posse: o termo precisa existir e pertencer ao usuário autenticado.

#codigo(legenda: [Regras de validação da matéria (`app/Http/Controllers/MateriaController.php`)])[
#[
#show raw: set text(size: 7.5pt)
````php
private function validar(Request $request): array
{
    return $request->validate([
        'nome' => 'required|string|max:255',
        'professor' => 'nullable|string|max:255',
        'dia_semana' => ['required', Rule::in(array_keys(Materia::DIAS))],
        'horario_inicio' => 'required|date_format:H:i',
        'horario_fim' => 'required|date_format:H:i|after:horario_inicio',
        'sala' => 'required|string|max:50',
        'termo_id' => ['required', Rule::exists('termos', 'id')->where('user_id', $request->user()->id)],
    ], [
        'horario_inicio.date_format' => 'Informe um horário válido.',
        'horario_fim.date_format' => 'Informe um horário válido.',
        'horario_fim.after' => 'O horário de fim deve ser depois do horário de início.',
    ], [
        'dia_semana' => 'dia da semana',
        'horario_inicio' => 'horário de início',
        'horario_fim' => 'horário de fim',
        'termo_id' => 'termo',
    ]);
}
````
]
]

No cadastro, além de gravar o usuário, o _controller_ cria os seis termos iniciais e a notificação de boas-vindas, de modo que a conta já começa com a tela inicial preenchida.

#codigo(legenda: [Cadastro com criação dos termos iniciais (`app/Http/Controllers/AuthController.php`)])[
  #show raw: set text(size: 7.5pt)
  ```php
  public function register(Request $request)
  {
      $dados = $request->validate([
          'name' => 'required|string|max:255',
          'email' => 'required|email|max:255|unique:users,email',
          'password' => 'required|string|min:6|confirmed',
      ]);

      $usuario = User::create($dados);

      foreach (self::CORES as $i => $cor) {
          Termo::create(['user_id' => $usuario->id, 'nome' => ($i + 1) . '°Termo', 'cor' => $cor]);
      }

      Notificacao::create(['user_id' => $usuario->id, 'texto' => 'Bem-vindo ao Guia do Mochileiro Fatecano!']);

      return redirect('/login')->with('sucesso', 'Cadastro realizado! Faça login para continuar.');
  }
  ```
]

O código-fonte completo dos quatro _controllers_ está no Apêndice C.

=== Formulários Blade e proteção CSRF
Todas as gravações do sistema partem de formulários HTML com `method="POST"`. Cada formulário inclui a diretiva `@csrf`, que o Blade transforma em um campo oculto `_token`; o _middleware_ do grupo `web` compara esse valor com o guardado na sessão e recusa a requisição com `419` quando ele falta ou não confere (caso CT17 da @tab-ct). Como o HTML só envia `GET` e `POST`, as ações de edição e remoção acrescentam a diretiva `@method`, que gera o campo oculto `_method` com o verbo `PUT`, `PATCH` ou `DELETE` esperado pela rota.

O formulário de matéria serve para criação e edição: envia `POST /materias` ao cadastrar e, quando a matéria já existe, acrescenta `@method('PUT')` para chegar a `PUT /materias/{materia}`.

#codigo(legenda: [Abertura do formulário de matéria com `@csrf` e `@method` (`resources/views/materias/form.blade.php`, linhas 10 a 29)])[
#[
#show raw: set text(size: 7.5pt)
````html
<form class="formulario largo cartao" method="POST" action="{{ $materia->exists ? '/materias/' . $materia->id : '/materias' }}" novalidate>
    @csrf
    @if ($materia->exists) @method('PUT') @endif

    <div class="form-cabecalho">
        <a class="voltar" href="/materias">&larr; Matérias</a>
        <h1>{{ $materia->exists ? 'Editar matéria' : 'Nova matéria' }}</h1>
        <p>Informe os dados da aula. Só o professor é opcional.</p>
    </div>

    @if ($errors->any())
        <p class="aviso erro">Revise os campos destacados abaixo.</p>
    @endif

    <div class="grade-campos">
        <div class="campo inteiro">
            <label for="nome">Nome da matéria</label>
            <input id="nome" type="text" name="nome" value="{{ old('nome', $materia->nome) }}" placeholder="Ex.: Banco de Dados" maxlength="255" required @class(['invalido' => $erro('nome')])>
            @if ($erro('nome')) <span class="erro-campo">{{ $erro('nome') }}</span> @endif
        </div>
````
]
]

Cada matéria listada traz o botão de remoção, que é um formulário próprio com `@csrf` e `@method('DELETE')`, enviado para `DELETE /materias/{materia}`.

#codigo(legenda: [Linha da listagem de matérias com o formulário de remoção (`resources/views/materias/_linha.blade.php`)])[
#[
#show raw: set text(size: 7.5pt)
````html
<div class="linha">
    <div class="linha-info">
        <strong>{{ $materia->nome }}</strong>
        <span>{{ $materia->professor ? 'Prof. ' . $materia->professor : 'Professor não informado' }}</span>
        <span class="horario">
            @if ($materia->dia_semana)
                {{ \App\Models\Materia::DIAS[$materia->dia_semana] }} · {{ $materia->horario_inicio }} às {{ $materia->horario_fim }} · {{ $materia->sala ?: 'Sala não informada' }}
            @else
                Horário não informado
            @endif
        </span>
    </div>
    <div class="linha-acoes">
        <a class="botao-mini" href="/materias/{{ $materia->id }}/edit">Editar</a>
        <form method="POST" action="/materias/{{ $materia->id }}" onsubmit="return confirm('Remover esta matéria?')">
            @csrf
            @method('DELETE')
            <button type="submit" class="botao-mini perigo">Remover</button>
        </form>
    </div>
</div>
````
]
]

A @tab-csrf lista todos os formulários do sistema. Os dez usam `@csrf`.

#tabela(legenda: [Formulários do sistema e proteção CSRF])[
  #table(
    columns: (2fr, 1.7fr, 1.2fr, 0.6fr),
    table.header([*Arquivo (linha)*], [*Rota*], [*`@method`*], [*`@csrf`*]),
    [`auth/login.blade.php` (13)], [`POST /login`], [—], [Sim],
    [`auth/register.blade.php` (11)], [`POST /register`], [—], [Sim],
    [`layouts/painel.blade.php` (23)], [`POST /logout`], [—], [Sim],
    [`termos/index.blade.php` (61)], [`POST /termos`], [—], [Sim],
    [`termos/index.blade.php` (47)], [`DELETE /termos/{termo}`], [`DELETE`], [Sim],
    [`materias/form.blade.php` (10)], [`POST /materias` ou `PUT /materias/{materia}`], [`PUT` na edição], [Sim],
    [`materias/_linha.blade.php` (15)], [`DELETE /materias/{materia}`], [`DELETE`], [Sim],
    [`notificacoes/index.blade.php` (12)], [`POST /notificacoes/ler-todas`], [—], [Sim],
    [`notificacoes/index.blade.php` (30)], [`PATCH /notificacoes/{notificacao}`], [`PATCH`], [Sim],
    [`notificacoes/index.blade.php` (36)], [`DELETE /notificacoes/{notificacao}`], [`DELETE`], [Sim],
  )
] <tab-csrf>

// =====================================================================
= Testes e validação <testes>
// =====================================================================

== Estratégia de testes
O projeto não tem testes automatizados das funcionalidades de domínio. A pasta `tests/` contém apenas os dois testes de exemplo que acompanham o Laravel: um unitário, que não exercita o sistema, e um de funcionalidade, que confere se a rota `/` responde `200`. A validação do sistema foi feita, portanto, por testes de requisição HTTP: cada caso da @tab-ct é uma sequência de requisições enviadas com a ferramenta de linha de comando `curl`, como as que o navegador faz ao usar o sistema (abrir a página, obter o _token_ de CSRF do formulário, enviar o formulário com o _cookie_ de sessão), conferindo o código de status, o redirecionamento e as mensagens da resposta. Os testes foram executados em 16/11/2026 e repetidos em 18/11/2026, depois da migração para o MariaDB, com os mesmos resultados. Nas duas vezes, rodaram contra uma instância da aplicação com banco de dados separado (no MariaDB, o banco `mochileiro_testes`), criada só para isso e apagada ao final, com dois usuários de teste para conferir o isolamento entre contas. As telas do @implementacao mostram os mesmos fluxos no navegador.

== Testes automatizados
#figura(legenda: [Resultado da execução dos testes automatizados])[
  #image("figuras/testes.png", width: 100%)
]

== Testes de requisição HTTP
#tabela(legenda: [Casos de teste por requisição HTTP])[
  #table(
    columns: (0.6fr, 2.2fr, 2.4fr, 0.6fr),
    table.header([*ID*], [*Cenário*], [*Resultado esperado e obtido*], [*Status*]),
    [CT01], [_Login_ com credenciais válidas], [Redireciona para `/inicio`, que abre com `200`], [ok],
    [CT02], [_Login_ com senha errada], [Volta ao formulário com "E-mail ou senha incorretos.", sem acesso], [ok],
    [CT03], [Acessar `/inicio`, `/materias` e `/notificacoes` sem _login_], [Redireciona para `/login`], [ok],
    [CT04], [Usuário abre e tenta remover termo de outro usuário; tenta editar matéria e excluir notificação alheias], [Bloqueado com `403` nos quatro casos], [ok],
    [CT05], [Cadastro com nome vazio, e-mail inválido, senha curta e confirmação diferente], [Formulário volta com os erros de cada campo; com `Accept: application/json`, resposta `422`], [ok],
    [CT06], [Cadastro válido], [Redireciona para `/login` com mensagem de sucesso; a conta nasce com 6 termos e 1 notificação de boas-vindas], [ok],
    [CT07], [Cadastro com e-mail já existente], [Recusado com "Este valor de e-mail já está cadastrado."], [ok],
    [CT08], [Cadastrar matéria válida], [Redireciona para o termo com "Matéria cadastrada com sucesso!"; a matéria aparece na lista], [ok],
    [CT09], [Matéria sem nome e sem sala, com dia inválido e fim anterior ao início], [Formulário volta com as quatro mensagens de erro], [ok],
    [CT10], [Matéria apontando para termo de outro usuário], [Recusada com "O valor selecionado em termo é inválido."], [ok],
    [CT11], [Editar matéria], [Dados atualizados e mensagem "Matéria atualizada com sucesso!"], [ok],
    [CT12], [Matéria de segunda-feira consultada em uma segunda-feira], [Aparece em "Aulas de hoje" com horário e sala], [ok],
    [CT13], [Remover matéria], [Some da lista; abrir a edição dela responde `404`], [ok],
    [CT14], [Adicionar turma; turma com cor fora do formato], [Turma criada (7 cartões); a de cor inválida é recusada], [ok],
    [CT15], [Remover turma que tem matéria], [Turma removida e matéria removida junto (`404` ao abrir)], [ok],
    [CT16], [Notificações: marcar uma como lida, marcar todas, excluir], [Contador de não lidas cai de 5 para 4 e depois para 0; a excluída some], [ok],
    [CT17], [Enviar formulário sem o _token_ de CSRF], [Recusado com `419`], [ok],
    [CT18], [12 tentativas de _login_ em menos de um minuto], [As 10 primeiras são processadas; a 11ª e a 12ª respondem `429`. O limite é contado por endereço IP e somado entre `/login` e `/register`], [ok],
    [CT19], [_Logout_ e novo acesso a `/inicio`], [Redireciona para `/` e, depois, para `/login`], [ok],
  )
] <tab-ct>

Os testes mostraram uma limitação: duas mensagens de validação saíram em inglês ("The senha field confirmation does not match." e "The cor field format is invalid."), porque as regras `confirmed` e `regex` não estão traduzidas em `lang/pt_BR/validation.php`.

// =====================================================================
= Implantação e execução <implantacao>
// =====================================================================

== Pré-requisitos
PHP 8.2 ou superior com a extensão `pdo_mysql`, além das exigidas pelo Laravel; Composer 2; Git; e um servidor MariaDB 10.5 ou superior (um MySQL compatível também atende, trocando `DB_CONNECTION` para `mysql`). Não é preciso Node.js, porque as telas usam os arquivos CSS de `public/css` diretamente, sem etapa de _build_. O repositório não tem `docker-compose.yml`.

== Passo a passo
O `README.md` do repositório é o padrão do Laravel e não traz instruções do projeto. A sequência abaixo foi conferida em 18/11/2026 a partir de um clone limpo do repositório, com o `.env.example` já apontando para o MariaDB.

#codigo(legenda: [Instalação e execução da aplicação])[
  ```bash
  git clone https://github.com/Schinor/Mochileiro-Fatecano-Full.git
  cd Mochileiro-Fatecano-Full
  composer install
  cp .env.example .env
  php artisan key:generate
  # criar o banco e o usuário no MariaDB (como root)
  sudo mysql -e "CREATE DATABASE mochileiro CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    CREATE USER 'mochileiro'@'localhost' IDENTIFIED BY 'troque-esta-senha';
    GRANT ALL PRIVILEGES ON mochileiro.* TO 'mochileiro'@'localhost';"
  # informar a mesma senha em DB_PASSWORD no arquivo .env
  php artisan migrate
  php artisan serve --host=0.0.0.0 --port=8001
  ```
]

O `.env.example` já traz `DB_CONNECTION=mariadb`, o banco `mochileiro` e o usuário `mochileiro`; falta apenas a senha, que não é versionada. Para que o nome da aplicação e as mensagens de validação apareçam em português, é preciso ajustar no `.env` as variáveis `APP_NAME` e `APP_LOCALE` (o `.env.example` traz `Laravel` e `en`). Não há etapa separada para o frontend: as telas são servidas pela própria aplicação Laravel. Na máquina virtual de desenvolvimento, o comando `php artisan serve` é mantido em execução por uma unidade do systemd (`mochileiro.service`).

== Variáveis de ambiente
#tabela(legenda: [Variáveis de ambiente da aplicação])[
  #table(
    columns: (1.5fr, 3fr),
    table.header([*Variável*], [*Finalidade*]),
    [`APP_NAME`], [Nome da aplicação; também define o nome do _cookie_ de sessão],
    [`APP_ENV`, `APP_DEBUG`], [Ambiente de execução e exibição detalhada de erros],
    [`APP_KEY`], [Chave de criptografia de sessões e _cookies_, gerada por `php artisan key:generate`],
    [`APP_URL`], [URL base da aplicação],
    [`APP_LOCALE`, `APP_FALLBACK_LOCALE`, `APP_FAKER_LOCALE`], [Idioma das mensagens],
    [`BCRYPT_ROUNDS`], [Custo do _hash_ das senhas],
    [`DB_CONNECTION`], [Conexão do banco (`mariadb`)],
    [`DB_HOST`, `DB_PORT`, `DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`], [Endereço, porta, nome do banco, usuário e senha do MariaDB],
    [`SESSION_DRIVER`, `SESSION_LIFETIME`, `SESSION_ENCRYPT`, `SESSION_PATH`, `SESSION_DOMAIN`], [Onde a sessão é guardada e por quanto tempo vale],
    [`CACHE_STORE`, `QUEUE_CONNECTION`], [Armazenamento do _cache_ (usado pelo limite de requisições) e das filas],
    [`LOG_CHANNEL`, `LOG_STACK`, `LOG_LEVEL`], [Registro de _logs_],
    [`MAIL_*`, `AWS_*`, `REDIS_*`, `MEMCACHED_HOST`, `BROADCAST_CONNECTION`, `FILESYSTEM_DISK`, `VITE_APP_NAME`], [Padrões do Laravel, não utilizados pelas funcionalidades do sistema],
  )
]

== Repositório
O código-fonte está disponível no GitHub, no endereço abaixo.

#align(center, link("https://github.com/Schinor/Mochileiro-Fatecano-Full")[`https://github.com/Schinor/Mochileiro-Fatecano-Full`])

// =====================================================================
= Resultados e discussão <resultados>
// =====================================================================

== Resultados obtidos
Os 17 requisitos funcionais da @tab-rf estão implementados e foram exercitados nos testes de requisição HTTP da @tab-ct, todos com o resultado esperado; as telas correspondentes aparecem na @implementacao. A @tab-atendimento relaciona cada requisito ao caso de teste ou à figura que o evidencia.

#tabela(legenda: [Atendimento dos requisitos funcionais])[
  #table(
    columns: (0.7fr, 2.5fr, 1fr, 1.3fr),
    table.header([*ID*], [*Requisito*], [*Situação*], [*Evidência*]),
    [RF01], [Cadastro de usuários], [Atendido], [CT05, CT06, CT07],
    [RF02], [Autenticação (_login_ e _logout_)], [Atendido], [CT01, CT02, CT19],
    [RF03], [Página de apresentação], [Atendido], [@fig-landing],
    [RF04], [Termos iniciais no cadastro], [Atendido], [CT06],
    [RF05], [Termos em cartões], [Atendido], [@fig-principal],
    [RF06], [Aulas do dia], [Atendido], [CT12],
    [RF07], [Adicionar turma], [Atendido], [CT14],
    [RF08], [Remover turma], [Atendido], [CT15],
    [RF09], [Matérias de um termo], [Atendido], [@fig-termo],
    [RF10], [Matérias agrupadas por termo], [Atendido], [@fig-listagem],
    [RF11], [Cadastrar matéria], [Atendido], [CT08, CT09, CT10],
    [RF12], [Editar matéria], [Atendido], [CT11],
    [RF13], [Remover matéria], [Atendido], [CT13],
    [RF14], [Notificações automáticas], [Atendido], [CT06, CT16],
    [RF15], [Listar notificações e contador], [Atendido], [@fig-notificacoes],
    [RF16], [Marcar como lida], [Atendido], [CT16],
    [RF17], [Excluir notificação], [Atendido], [CT16],
  )
] <tab-atendimento>

== Dificuldades e limitações
A versão entregue tem as seguintes limitações conhecidas:

- Duas mensagens de validação aparecem em inglês, porque as regras `confirmed` e `regex` não estão traduzidas;
- Não há testes automatizados das funcionalidades de domínio, apenas os dois testes de exemplo do Laravel;
- Não é possível editar uma turma, editar os dados do usuário nem recuperar a senha;
- A edição e a remoção de matérias não geram notificação;
- No banco, o dia da semana, os horários e a sala aceitam valor nulo; a obrigatoriedade existe apenas na validação do _controller_;
- A aplicação é executada com o servidor de desenvolvimento (`php artisan serve`) e com o modo de depuração ligado;
- Os grupos de estudo previstos na ideia original não foram implementados.

// =====================================================================
= Considerações finais <conclusao>
// =====================================================================
O objetivo geral foi atingido: o Guia do Mochileiro Fatecano permite ao estudante organizar e consultar seus termos, matérias, horários e salas de aula, e os 17 requisitos funcionais especificados estão implementados e foram verificados nos testes de requisição HTTP.

A intenção de desenvolver uma plataforma utilizável, e não apenas uma entrega da disciplina, aparece nas decisões do projeto: cada conta já começa com os seis termos criados, as telas se adaptam a computador e a celular, toda entrada é validada no servidor e cada usuário acessa somente os próprios dados. O trabalho também exercitou a integração entre as partes de uma aplicação web: rotas, _controllers_, _models_, _views_ e banco de dados.

Para que a plataforma chegue ao uso pretendido na ideia original, de apoio aos estudos dos alunos ingressantes, restam as evoluções listadas a seguir.

== Trabalhos futuros
A lista abaixo reúne o que ficou fora do escopo da versão entregue:

- Criar os grupos de estudo previstos na ideia original do projeto;
- Expor os mesmos recursos em uma API REST em JSON e ligar a ela uma interface SPA, retomando o protótipo em Angular;
- Permitir editar uma turma (hoje só é possível adicionar e remover) e os dados do usuário;
- Implementar recuperação de senha e verificação de e-mail;
- Escrever testes automatizados para autenticação, termos, matérias e notificações;
- Traduzir as mensagens de validação que ainda aparecem em inglês;
- Criar _seeders_ com dados de demonstração.

// =====================================================================
// PÓS-TEXTUAIS
// =====================================================================
#pagebreak()
#set heading(numbering: none)
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  align(center, block(below: 1.4em, text(weight: "bold", upper(it.body))))
}

#bibliography("referencias.yml", title: [Referências], style: "associacao-brasileira-de-normas-tecnicas")

// =====================================================================
= Apêndice A — Arquivo de rotas (`routes/web.php`)
// =====================================================================
Conteúdo integral do arquivo `routes/web.php` do repositório (_commit_ `5810793`).

#codigo(legenda: [Arquivo de rotas `routes/web.php`])[
#[
#show raw: set text(size: 8pt)
````php
<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\MateriaController;
use App\Http\Controllers\NotificacaoController;
use App\Http\Controllers\TermoController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Autenticação (Login e Cadastro)
|--------------------------------------------------------------------------
*/
Route::middleware('guest')->group(function () {
    Route::view('/', 'landing');

    Route::get('/login', [AuthController::class, 'showLogin'])->name('login');
    Route::post('/login', [AuthController::class, 'login'])->middleware('throttle:10,1');

    Route::get('/register', [AuthController::class, 'showRegister']);
    Route::post('/register', [AuthController::class, 'register'])->middleware('throttle:10,1');
});

Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth');

/*
|--------------------------------------------------------------------------
| Termos (Semestres)
|--------------------------------------------------------------------------
*/
Route::middleware('auth')->group(function () {
    Route::get('/inicio', [TermoController::class, 'index']);
    Route::get('/termos/{termo}', [TermoController::class, 'show']);
    Route::post('/termos', [TermoController::class, 'store']);
    Route::delete('/termos/{termo}', [TermoController::class, 'destroy']);

    // Matérias
    Route::resource('materias', MateriaController::class)->except('show');

    // Notificações
    Route::get('/notificacoes', [NotificacaoController::class, 'index']);
    Route::post('/notificacoes/ler-todas', [NotificacaoController::class, 'lerTodas']);
    Route::patch('/notificacoes/{notificacao}', [NotificacaoController::class, 'update']);
    Route::delete('/notificacoes/{notificacao}', [NotificacaoController::class, 'destroy']);
});
````
]
]

// =====================================================================
= Apêndice B — Tabela completa de rotas
// =====================================================================
Saída de `php artisan route:list -v` em 16/11/2026, com as 25 rotas registradas. As quatro últimas pertencem ao Laravel e ao Sanctum.

#[
  #set par(first-line-indent: 0pt, justify: false)
  #show table: set text(size: 8pt)
  #table(
    columns: (0.9fr, 1.8fr, 2.6fr, 1.6fr),
    table.header([*Método*], [*URI*], [*Ação*], [*Middleware*]),
    [`GET|HEAD`], [`/`], [_view_ `landing`], [`web`, `guest`],
    [`GET|HEAD`], [`api/user`], [`routes/api.php:6`], [`api`, `auth:sanctum`],
    [`GET|HEAD`], [`inicio`], [`TermoController@index`], [`web`, `auth`],
    [`GET|HEAD`], [`login`], [`AuthController@showLogin`], [`web`, `guest`],
    [`POST`], [`login`], [`AuthController@login`], [`web`, `guest`, `throttle:10,1`],
    [`POST`], [`logout`], [`AuthController@logout`], [`web`, `auth`],
    [`GET|HEAD`], [`materias`], [`MateriaController@index`], [`web`, `auth`],
    [`POST`], [`materias`], [`MateriaController@store`], [`web`, `auth`],
    [`GET|HEAD`], [`materias/create`], [`MateriaController@create`], [`web`, `auth`],
    [`PUT|PATCH`], [`materias/{materia}`], [`MateriaController@update`], [`web`, `auth`],
    [`DELETE`], [`materias/{materia}`], [`MateriaController@destroy`], [`web`, `auth`],
    [`GET|HEAD`], [`materias/{materia}/edit`], [`MateriaController@edit`], [`web`, `auth`],
    [`GET|HEAD`], [`notificacoes`], [`NotificacaoController@index`], [`web`, `auth`],
    [`POST`], [`notificacoes/ler-todas`], [`NotificacaoController@lerTodas`], [`web`, `auth`],
    [`PATCH`], [`notificacoes/{notificacao}`], [`NotificacaoController@update`], [`web`, `auth`],
    [`DELETE`], [`notificacoes/{notificacao}`], [`NotificacaoController@destroy`], [`web`, `auth`],
    [`GET|HEAD`], [`register`], [`AuthController@showRegister`], [`web`, `guest`],
    [`POST`], [`register`], [`AuthController@register`], [`web`, `guest`, `throttle:10,1`],
    [`POST`], [`termos`], [`TermoController@store`], [`web`, `auth`],
    [`GET|HEAD`], [`termos/{termo}`], [`TermoController@show`], [`web`, `auth`],
    [`DELETE`], [`termos/{termo}`], [`TermoController@destroy`], [`web`, `auth`],
    [`GET|HEAD`], [`sanctum/csrf-cookie`], [`CsrfCookieController@show` (Sanctum)], [`web`],
    [`GET|HEAD`], [`storage/{path}`], [`FilesystemServiceProvider` (Laravel)], [—],
    [`PUT`], [`storage/{path}`], [`FilesystemServiceProvider` (Laravel)], [—],
    [`GET|HEAD`], [`up`], [`ApplicationBuilder` (verificação de saúde)], [—],
  )
]

// =====================================================================
= Apêndice C — Código-fonte dos controllers
// =====================================================================
Conteúdo integral dos _controllers_ de `app/Http/Controllers` (_commit_ `5810793`). O `Controller` é a classe base gerada pelo Laravel, da qual os demais herdam.

#codigo(legenda: [Código-fonte de `app/Http/Controllers/MateriaController.php`])[
#[
#show raw: set text(size: 7.5pt)
````php
<?php

namespace App\Http\Controllers;

use App\Models\Materia;
use App\Models\Notificacao;
use App\Models\Termo;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class MateriaController extends Controller
{
    /**
     * Lista as matérias agrupadas por termo (GET /materias)
     */
    public function index(Request $request)
    {
        $termos = Termo::where('user_id', $request->user()->id)->with(['materias' => fn ($q) => $q->ordenadas()])->orderBy('id')->get();

        return view('materias.index', ['termos' => $termos]);
    }

    /**
     * Exibe o formulário de criação (GET /materias/create)
     */
    public function create(Request $request)
    {
        return view('materias.form', [
            'materia' => new Materia(['termo_id' => $request->query('termo_id')]),
            'termos' => $this->termos($request),
        ]);
    }

    /**
     * Grava uma nova matéria (POST /materias)
     */
    public function store(Request $request)
    {
        $dados = $this->validar($request);
        $dados['user_id'] = $request->user()->id;

        $materia = Materia::create($dados);
        Notificacao::create(['user_id' => $dados['user_id'], 'texto' => "Matéria \"{$materia->nome}\" adicionada."]);

        return redirect('/termos/' . $materia->termo_id)->with('sucesso', 'Matéria cadastrada com sucesso!');
    }

    /**
     * Exibe o formulário de edição (GET /materias/{id}/edit)
     */
    public function edit(Request $request, Materia $materia)
    {
        $this->autorizar($request, $materia);

        return view('materias.form', ['materia' => $materia, 'termos' => $this->termos($request)]);
    }

    /**
     * Atualiza a matéria (PUT/PATCH /materias/{id})
     */
    public function update(Request $request, Materia $materia)
    {
        $this->autorizar($request, $materia);

        $materia->update($this->validar($request));

        return redirect('/termos/' . $materia->termo_id)->with('sucesso', 'Matéria atualizada com sucesso!');
    }

    /**
     * Remove a matéria (DELETE /materias/{id})
     */
    public function destroy(Request $request, Materia $materia)
    {
        $this->autorizar($request, $materia);

        $materia->delete();

        return back()->with('sucesso', 'Matéria removida com sucesso!');
    }

    private function termos(Request $request)
    {
        return Termo::where('user_id', $request->user()->id)->orderBy('id')->get();
    }

    private function autorizar(Request $request, Materia $materia): void
    {
        abort_unless($materia->user_id === $request->user()->id, 403);
    }

    private function validar(Request $request): array
    {
        return $request->validate([
            'nome' => 'required|string|max:255',
            'professor' => 'nullable|string|max:255',
            'dia_semana' => ['required', Rule::in(array_keys(Materia::DIAS))],
            'horario_inicio' => 'required|date_format:H:i',
            'horario_fim' => 'required|date_format:H:i|after:horario_inicio',
            'sala' => 'required|string|max:50',
            'termo_id' => ['required', Rule::exists('termos', 'id')->where('user_id', $request->user()->id)],
        ], [
            'horario_inicio.date_format' => 'Informe um horário válido.',
            'horario_fim.date_format' => 'Informe um horário válido.',
            'horario_fim.after' => 'O horário de fim deve ser depois do horário de início.',
        ], [
            'dia_semana' => 'dia da semana',
            'horario_inicio' => 'horário de início',
            'horario_fim' => 'horário de fim',
            'termo_id' => 'termo',
        ]);
    }
}
````
]
]

#codigo(legenda: [Código-fonte de `app/Http/Controllers/TermoController.php`])[
#[
#show raw: set text(size: 7.5pt)
````php
<?php

namespace App\Http\Controllers;

use App\Models\Materia;
use App\Models\Notificacao;
use App\Models\Termo;
use Illuminate\Http\Request;

class TermoController extends Controller
{
    /**
     * Lista os termos do usuário (GET /inicio)
     */
    public function index(Request $request)
    {
        $usuario = $request->user();
        $hoje = now()->dayOfWeekIso;

        return view('termos.index', [
            'termos' => Termo::where('user_id', $usuario->id)->withCount('materias')->orderBy('id')->get(),
            'hoje' => $hoje,
            'aulasHoje' => Materia::where('user_id', $usuario->id)->where('dia_semana', $hoje)->with('termo')->ordenadas()->get(),
        ]);
    }

    /**
     * Exibe as matérias de um termo (GET /termos/{id})
     */
    public function show(Request $request, Termo $termo)
    {
        abort_unless($termo->user_id === $request->user()->id, 403);

        return view('termos.show', ['termo' => $termo, 'materias' => $termo->materias()->ordenadas()->get()]);
    }

    /**
     * Grava uma nova turma (POST /termos)
     */
    public function store(Request $request)
    {
        $dados = $request->validate([
            'nome' => 'required|string|max:50',
            'cor' => ['required', 'regex:/^#[0-9A-Fa-f]{6}$/'],
        ]);
        $dados['user_id'] = $request->user()->id;

        Termo::create($dados);
        Notificacao::create(['user_id' => $dados['user_id'], 'texto' => "Turma \"{$dados['nome']}\" adicionada."]);

        return redirect('/inicio')->with('sucesso', 'Turma adicionada com sucesso!');
    }

    /**
     * Remove a turma e suas matérias (DELETE /termos/{id})
     */
    public function destroy(Request $request, Termo $termo)
    {
        abort_unless($termo->user_id === $request->user()->id, 403);

        $termo->delete();
        Notificacao::create(['user_id' => $request->user()->id, 'texto' => "Turma \"{$termo->nome}\" removida."]);

        return redirect('/inicio')->with('sucesso', 'Turma removida com sucesso!');
    }
}
````
]
]

#codigo(legenda: [Código-fonte de `app/Http/Controllers/AuthController.php`])[
#[
#show raw: set text(size: 7.5pt)
````php
<?php

namespace App\Http\Controllers;

use App\Models\Notificacao;
use App\Models\Termo;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    /**
     * Cores dos termos criados automaticamente no cadastro.
     */
    private const CORES = ['#E2F4C5', '#EEE7DA', '#A5DD9B', '#C5EBAA', '#FFFFDD', '#AFC8AD'];

    public function showLogin()
    {
        return view('auth.login');
    }

    public function login(Request $request)
    {
        $credenciais = $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        if (! Auth::attempt($credenciais)) {
            return back()->withInput($request->only('email'))
                ->withErrors(['email' => 'E-mail ou senha incorretos.']);
        }

        $request->session()->regenerate();

        return redirect()->intended('/inicio');
    }

    public function showRegister()
    {
        return view('auth.register');
    }

    public function register(Request $request)
    {
        $dados = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255|unique:users,email',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $usuario = User::create($dados);

        foreach (self::CORES as $i => $cor) {
            Termo::create(['user_id' => $usuario->id, 'nome' => ($i + 1) . '°Termo', 'cor' => $cor]);
        }

        Notificacao::create(['user_id' => $usuario->id, 'texto' => 'Bem-vindo ao Guia do Mochileiro Fatecano!']);

        return redirect('/login')->with('sucesso', 'Cadastro realizado! Faça login para continuar.');
    }

    public function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect('/');
    }
}
````
]
]

#codigo(legenda: [Código-fonte de `app/Http/Controllers/NotificacaoController.php`])[
#[
#show raw: set text(size: 7.5pt)
````php
<?php

namespace App\Http\Controllers;

use App\Models\Notificacao;
use Illuminate\Http\Request;

class NotificacaoController extends Controller
{
    /**
     * Lista as notificações (GET /notificacoes)
     */
    public function index(Request $request)
    {
        $notificacoes = Notificacao::where('user_id', $request->user()->id)->latest('id')->get();

        return view('notificacoes.index', ['notificacoes' => $notificacoes]);
    }

    /**
     * Marca uma notificação como lida (PATCH /notificacoes/{id})
     */
    public function update(Request $request, Notificacao $notificacao)
    {
        abort_unless($notificacao->user_id === $request->user()->id, 403);

        $notificacao->update(['lida' => true]);

        return redirect('/notificacoes');
    }

    /**
     * Marca todas como lidas (POST /notificacoes/ler-todas)
     */
    public function lerTodas(Request $request)
    {
        Notificacao::where('user_id', $request->user()->id)->update(['lida' => true]);

        return redirect('/notificacoes')->with('sucesso', 'Todas as notificações foram marcadas como lidas.');
    }

    /**
     * Remove a notificação (DELETE /notificacoes/{id})
     */
    public function destroy(Request $request, Notificacao $notificacao)
    {
        abort_unless($notificacao->user_id === $request->user()->id, 403);

        $notificacao->delete();

        return redirect('/notificacoes');
    }
}
````
]
]

#codigo(legenda: [Código-fonte de `app/Http/Controllers/Controller.php`])[
#[
#show raw: set text(size: 7.5pt)
````php
<?php

namespace App\Http\Controllers;

abstract class Controller
{
    //
}
````
]
]

= Apêndice D — Histórico de commits
O repositório `Schinor/Mochileiro-Fatecano-Full` tem um único _commit_ (saída de `git log` em 16/11/2026).

#[
  #set par(first-line-indent: 0pt, justify: false)
  #table(
    columns: (0.8fr, 1.3fr, 2fr, 3fr),
    table.header([*Hash*], [*Data*], [*Autor*], [*Mensagem*]),
    [`5810793`], [16/11/2026 09:49], [Marcio Gabriel Schinor Mazega], [Versiona aplicação Mochileiro Fatecano (Laravel)],
  )
]
