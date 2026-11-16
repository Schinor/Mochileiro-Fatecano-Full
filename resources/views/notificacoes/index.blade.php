@extends('layouts.painel')

@section('titulo', 'Notificações')

@section('pagina')
    <section class="parte-superior">
        <div>
            <h1>Notificações</h1>
            <p>Acompanhe o que aconteceu na sua conta</p>
        </div>
        @if ($notificacoes->where('lida', false)->count())
            <form method="POST" action="/notificacoes/ler-todas">
                @csrf
                <button type="submit" class="botao-adicionar"><h2>Marcar todas como lidas</h2></button>
            </form>
        @endif
    </section>

    @include('partials.erros')

    <section class="lista">
        @forelse ($notificacoes as $notificacao)
            <div class="linha {{ $notificacao->lida ? '' : 'nao-lida' }}">
                <div class="linha-info">
                    <strong>{{ $notificacao->texto }}</strong>
                    <span>{{ $notificacao->created_at->format('d/m/Y H:i') }}</span>
                </div>
                <div class="linha-acoes">
                    @unless ($notificacao->lida)
                        <form method="POST" action="/notificacoes/{{ $notificacao->id }}">
                            @csrf
                            @method('PATCH')
                            <button type="submit" class="botao-mini">Marcar como lida</button>
                        </form>
                    @endunless
                    <form method="POST" action="/notificacoes/{{ $notificacao->id }}">
                        @csrf
                        @method('DELETE')
                        <button type="submit" class="botao-mini perigo">Excluir</button>
                    </form>
                </div>
            </div>
        @empty
            <p class="vazio">Você não tem notificações.</p>
        @endforelse
    </section>
@endsection
