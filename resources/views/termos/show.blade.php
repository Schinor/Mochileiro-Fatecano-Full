@extends('layouts.painel')

@section('titulo', $termo->nome)

@section('pagina')
    <section class="parte-superior">
        <div>
            <a class="voltar" href="/inicio">&larr; Termos</a>
            <h1>{{ $termo->nome }}</h1>
            <p>Matérias deste termo</p>
        </div>
        <a class="botao-adicionar" href="/materias/create?termo_id={{ $termo->id }}"><img src="/icons/iconeAdicionarHome.png" alt=""><h2>Adicionar matéria</h2></a>
    </section>

    @include('partials.erros')

    <section class="lista">
        @forelse ($materias as $materia)
            @include('materias._linha', ['materia' => $materia])
        @empty
            <p class="vazio">Nenhuma matéria cadastrada neste termo.</p>
        @endforelse
    </section>
@endsection
