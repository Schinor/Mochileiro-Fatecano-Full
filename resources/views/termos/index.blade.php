@extends('layouts.painel')

@section('titulo', 'Início')

@section('pagina')
    <section class="parte-superior">
        <div>
            <span class="saudacao">Olá, {{ explode(' ', auth()->user()->name)[0] }}</span>
            <h1>Seus termos</h1>
            <p>Qual termo gostaria de acessar hoje?</p>
        </div>
        <button type="button" class="botao-adicionar" onclick="document.getElementById('nova-turma').showModal()">
            <img src="/icons/iconeAdicionarHome.png" alt="Icone de Adição"><h2>Adicionar turma</h2>
        </button>
    </section>

    @include('partials.erros')

    <section class="hoje">
        <div class="hoje-titulo">
            <h2>Aulas de hoje</h2>
            <p>{{ \App\Models\Materia::DIAS[$hoje] }}, {{ now()->format('d/m') }}</p>
        </div>
        <div class="hoje-lista">
            @forelse ($aulasHoje as $aula)
                <a class="hoje-aula" href="/termos/{{ $aula->termo_id }}">
                    <span class="hoje-hora">{{ $aula->horario_inicio }} às {{ $aula->horario_fim }}</span>
                    <span class="hoje-nome">{{ $aula->nome }}</span>
                    <span class="hoje-sala">{{ $aula->sala ?: 'Sala não informada' }}</span>
                </a>
            @empty
                <p class="hoje-vazio">Nenhuma aula cadastrada para hoje.</p>
            @endforelse
        </div>
    </section>

    <section class="parte-inferior">
        @forelse ($termos as $termo)
            <div class="meu-card">
                <a class="card-link" href="/termos/{{ $termo->id }}">
                    <span class="card-topo" style="background-color: {{ $termo->cor }}"><h1>{{ $termo->nome }}</h1></span>
                    <span class="card-base">
                        <span class="card-sub">{{ $termo->materias_count }} {{ $termo->materias_count === 1 ? 'matéria' : 'matérias' }}</span>
                        <span class="card-acessar">Acessar</span>
                    </span>
                </a>
                <form method="POST" action="/termos/{{ $termo->id }}" onsubmit="return confirm('Remover esta turma e suas matérias?')">
                    @csrf
                    @method('DELETE')
                    <button type="submit" class="remover" title="Remover turma" aria-label="Remover {{ $termo->nome }}">&times;</button>
                </form>
            </div>
        @empty
            <p class="vazio">Nenhuma turma ainda. Clique em "Adicionar turma".</p>
        @endforelse
    </section>
@endsection

@section('extra')
    <dialog id="nova-turma">
        <form class="formulario" method="POST" action="/termos">
            @csrf
            <h1>Adicionar turma</h1>
            <div class="campo">
                <label for="nome">Nome</label>
                <input id="nome" type="text" name="nome" placeholder="Ex.: 7°Termo" maxlength="50" required>
            </div>
            <div class="campo">
                <label for="cor">Cor do cartão</label>
                <input id="cor" type="color" name="cor" value="#E2F4C5">
            </div>
            <button type="submit" class="botao"><strong>Adicionar</strong></button>
            <button type="button" class="botao cancelar" onclick="document.getElementById('nova-turma').close()">Cancelar</button>
        </form>
    </dialog>
@endsection
