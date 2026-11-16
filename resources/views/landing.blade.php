<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guia do Mochileiro Fatecano</title>
    <meta name="description" content="Organize seus termos, matérias, horários e salas da Fatec em um só lugar.">
    <link rel="icon" href="/icons/favicon.ico">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap">
    <link rel="stylesheet" href="/css/landing.css">
</head>
<body>
    <header class="topo">
        <div class="contorno topo-interno">
            <a class="marca" href="/">
                <img src="/icons/iconeMochilaLogin.png" alt="" width="28" height="38">
                <span>Guia do Mochileiro Fatecano</span>
            </a>
            <nav class="topo-menu" aria-label="Seções da página">
                <a href="#recursos">Recursos</a>
                <a href="#como-funciona">Como funciona</a>
            </nav>
            <div class="topo-acoes">
                <a class="link" href="/login">Entrar</a>
                <a class="botao" href="/register">Criar conta</a>
            </div>
        </div>
    </header>

    <main>
        <section class="hero">
            <div class="contorno hero-interno">
                <div class="hero-texto">
                    <h1>Organize suas aulas da Fatec em um só lugar</h1>
                    <p>Cadastre seus termos e matérias com dia, horário e sala, e consulte a sua semana pelo celular ou pelo computador.</p>
                    <div class="hero-botoes">
                        <a class="botao grande" href="/register">Criar conta grátis</a>
                        <a class="botao grande secundario" href="/login">Já tenho conta</a>
                    </div>
                    <p class="nota">Cadastro gratuito. Não precisa instalar nada.</p>
                </div>
                <img class="hero-imagem" src="/imagens/landing/ilustracao-hero.webp" width="709" height="730" alt="Estudante lendo um livro cercado por símbolos de ciência">
            </div>
        </section>

        <section class="recursos" id="recursos">
            <div class="contorno">
                <div class="secao-titulo">
                    <h2>Tudo o que você precisa para o semestre</h2>
                    <p>Três áreas simples para manter a rotina de aulas organizada.</p>
                </div>

                <article class="recurso">
                    <div class="recurso-texto">
                        <h3>Seus termos em cartões</h3>
                        <p>Cada semestre vira um cartão. Ao criar a conta, você já recebe seis termos prontos.</p>
                        <ul class="lista-ok">
                            <li>Adicione turmas com o nome e a cor que quiser</li>
                            <li>Abra um termo para ver as matérias dele</li>
                            <li>Remova o que não usa mais</li>
                        </ul>
                    </div>
                    <div class="navegador">
                        <div class="navegador-barra" aria-hidden="true"><i></i><i></i><i></i></div>
                        <img src="/imagens/landing/termos.webp" width="1264" height="800" alt="Tela inicial do app com os cartões dos termos">
                    </div>
                </article>

                <article class="recurso invertido">
                    <div class="recurso-texto">
                        <h3>Matérias com dia, horário e sala</h3>
                        <p>Registre cada aula uma vez e consulte sempre que precisar, sem procurar em mensagens ou prints.</p>
                        <ul class="lista-ok">
                            <li>Professor, termo, dia da semana, horário e sala</li>
                            <li>Lista sempre na ordem da semana</li>
                            <li>Edite na hora quando algo mudar</li>
                        </ul>
                    </div>
                    <div class="visual-duplo">
                        <div class="navegador">
                            <div class="navegador-barra" aria-hidden="true"><i></i><i></i><i></i></div>
                            <img src="/imagens/landing/materias.webp" width="1264" height="800" alt="Página de um termo com a lista de matérias, horários e salas">
                        </div>
                        <div class="celular">
                            <img src="/imagens/landing/celular.webp" width="390" height="844" alt="Mesma página aberta no celular">
                        </div>
                    </div>
                </article>

                <article class="recurso">
                    <div class="recurso-texto">
                        <h3>Avisos da sua conta</h3>
                        <p>Cada ação importante gera uma notificação, para você acompanhar o que foi feito.</p>
                        <ul class="lista-ok">
                            <li>Contador de avisos não lidos no menu</li>
                            <li>Marque uma ou todas como lidas</li>
                            <li>Exclua os avisos que não precisa mais</li>
                        </ul>
                    </div>
                    <div class="navegador">
                        <div class="navegador-barra" aria-hidden="true"><i></i><i></i><i></i></div>
                        <img src="/imagens/landing/avisos.webp" width="1264" height="520" alt="Página de notificações com avisos lidos e não lidos">
                    </div>
                </article>
            </div>
        </section>

        <section class="como" id="como-funciona">
            <div class="contorno">
                <div class="secao-titulo">
                    <h2>Como funciona</h2>
                    <p>Em poucos minutos a sua semana está montada.</p>
                </div>
                <ol class="passos">
                    <li>
                        <span class="numero">1</span>
                        <h3>Crie sua conta</h3>
                        <p>Informe nome, e-mail e senha. Seus seis termos já aparecem na tela inicial.</p>
                    </li>
                    <li>
                        <span class="numero">2</span>
                        <h3>Cadastre as matérias</h3>
                        <p>Escolha o termo e preencha professor, dia da semana, horário e sala.</p>
                    </li>
                    <li>
                        <span class="numero">3</span>
                        <h3>Consulte quando precisar</h3>
                        <p>Abra o termo e veja as aulas em ordem, no celular ou no computador.</p>
                    </li>
                </ol>
            </div>
        </section>

        <section class="final">
            <div class="contorno final-interno">
                <div class="final-texto">
                    <h2>Comece a organizar o seu semestre hoje</h2>
                    <p>Crie sua conta gratuita e cadastre a primeira matéria.</p>
                    <a class="botao grande claro" href="/register">Criar conta grátis</a>
                </div>
                <img class="final-imagem" src="/imagens/landing/ilustracao-cta.webp" width="746" height="665" alt="Estudante sentada sobre uma pilha de livros, lendo">
            </div>
        </section>
    </main>

    <footer class="rodape">
        <div class="contorno rodape-interno">
            <div class="rodape-marca">
                <a class="marca" href="/">
                    <img src="/icons/iconeMochilaLogin.png" alt="" width="24" height="33">
                    <span>Guia do Mochileiro Fatecano</span>
                </a>
                <p>Projeto acadêmico, sem vínculo oficial com a Fatec. Design da interface: Prof. Finotti (CIAg).</p>
            </div>
            <nav class="rodape-links" aria-label="Acesso">
                <a href="/login">Entrar</a>
                <a href="/register">Criar conta</a>
            </nav>
        </div>
    </footer>
</body>
</html>
