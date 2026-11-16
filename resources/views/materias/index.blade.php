@extends('layouts.painel')

@section('titulo', 'Matérias')

@section('pagina')
    <section class="parte-superior">
        <div>
            <h1>Matérias</h1>
            <p>Todas as matérias, organizadas por termo</p>
        </div>
        <a class="botao-adicionar" href="/materias/create"><img src="/icons/iconeAdicionarHome.png" alt=""><h2>Adicionar matéria</h2></a>
    </section>

    @include('partials.erros')

    <section class="lista">
        @forelse ($termos as $termo)
            <h3 class="grupo"><span class="bolinha" style="background-color: {{ $termo->cor }}"></span>{{ $termo->nome }}</h3>
            @forelse ($termo->materias->sortBy('nome') as $materia)
                @include('materias._linha', ['materia' => $materia])
            @empty
                <p class="vazio pequeno">Nenhuma matéria neste termo.</p>
            @endforelse
        @empty
            <p class="vazio">Crie uma turma na página inicial para cadastrar matérias.</p>
        @endforelse
    </section>
@endsection
