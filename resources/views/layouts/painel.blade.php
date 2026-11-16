@extends('layouts.app')

@section('conteudo')
    @php($naoLidas = \App\Models\Notificacao::where('user_id', auth()->id())->where('lida', false)->count())
    <header class="cabecalho">
        <section class="cabecalho-marca">
            <img src="/icons/iconeMochila.svg" alt="Icone de Mochila">
            <h1>Guia do mochileiro <br>Fatecano</h1>
        </section>
        <input type="checkbox" id="menu-toggle" class="menu-toggle" aria-label="Abrir menu">
        <label for="menu-toggle" class="menu-botao"><span></span></label>
        <nav class="cabecalho-menu">
            <ul>
                <li><a class="menu-item {{ request()->is('inicio', 'termos/*') ? 'ativo' : '' }}" href="/inicio"><img src="/icons/iconeCasa.svg" alt=""><span>Home</span></a></li>
                <li>
                    <a class="menu-item {{ request()->is('notificacoes*') ? 'ativo' : '' }}" href="/notificacoes">
                        <img src="/icons/iconeSino.png" alt=""><span>Notificações</span>
                        @if ($naoLidas)<span class="selo">{{ $naoLidas }}</span>@endif
                    </a>
                </li>
                <li><a class="menu-item {{ request()->is('materias*') ? 'ativo' : '' }}" href="/materias"><img src="/icons/iconeLivro.png" alt=""><span>Matérias</span></a></li>
                <li>
                    <form method="POST" action="/logout">
                        @csrf
                        <button type="submit" class="menu-item"><img src="/icons/iconeSair.svg" alt=""><span>Sair</span></button>
                    </form>
                </li>
            </ul>
        </nav>
    </header>

    <main class="conteudo">
        @yield('pagina')
    </main>

    @yield('extra')
@endsection
