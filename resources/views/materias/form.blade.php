@extends('layouts.painel')

@section('titulo', $materia->exists ? 'Editar matéria' : 'Nova matéria')

@php
    $erro = fn ($campo) => $errors->first($campo);
@endphp

@section('pagina')
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

            <div class="campo">
                <label for="professor">Professor <small>(opcional)</small></label>
                <input id="professor" type="text" name="professor" value="{{ old('professor', $materia->professor) }}" placeholder="Ex.: Maria Souza" maxlength="255" @class(['invalido' => $erro('professor')])>
                @if ($erro('professor')) <span class="erro-campo">{{ $erro('professor') }}</span> @endif
            </div>

            <div class="campo">
                <label for="termo_id">Termo</label>
                <select id="termo_id" name="termo_id" required @class(['invalido' => $erro('termo_id')])>
                    <option value="">Selecione o termo</option>
                    @foreach ($termos as $termo)
                        <option value="{{ $termo->id }}" @selected(old('termo_id', $materia->termo_id) == $termo->id)>{{ $termo->nome }}</option>
                    @endforeach
                </select>
                @if ($erro('termo_id')) <span class="erro-campo">{{ $erro('termo_id') }}</span> @endif
            </div>

            <div class="campo">
                <label for="dia_semana">Dia da semana</label>
                <select id="dia_semana" name="dia_semana" required @class(['invalido' => $erro('dia_semana')])>
                    <option value="">Selecione o dia</option>
                    @foreach (\App\Models\Materia::DIAS as $numero => $dia)
                        <option value="{{ $numero }}" @selected(old('dia_semana', $materia->dia_semana) == $numero)>{{ $dia }}</option>
                    @endforeach
                </select>
                @if ($erro('dia_semana')) <span class="erro-campo">{{ $erro('dia_semana') }}</span> @endif
            </div>

            <div class="campo">
                <label for="sala">Sala</label>
                <input id="sala" type="text" name="sala" value="{{ old('sala', $materia->sala) }}" placeholder="Ex.: Sala 12 ou Laboratório 3" maxlength="50" required @class(['invalido' => $erro('sala')])>
                @if ($erro('sala')) <span class="erro-campo">{{ $erro('sala') }}</span> @endif
            </div>

            <div class="campo">
                <label for="horario_inicio">Horário de início</label>
                <input id="horario_inicio" type="time" name="horario_inicio" value="{{ old('horario_inicio', $materia->horario_inicio) }}" required @class(['invalido' => $erro('horario_inicio')])>
                @if ($erro('horario_inicio')) <span class="erro-campo">{{ $erro('horario_inicio') }}</span> @endif
            </div>

            <div class="campo">
                <label for="horario_fim">Horário de fim</label>
                <input id="horario_fim" type="time" name="horario_fim" value="{{ old('horario_fim', $materia->horario_fim) }}" required @class(['invalido' => $erro('horario_fim')])>
                @if ($erro('horario_fim')) <span class="erro-campo">{{ $erro('horario_fim') }}</span> @endif
            </div>
        </div>

        <div class="form-acoes">
            <a class="botao cancelar" href="{{ $materia->exists ? '/termos/' . $materia->termo_id : '/materias' }}">Cancelar</a>
            <button type="submit" class="botao"><strong>{{ $materia->exists ? 'Salvar alterações' : 'Cadastrar matéria' }}</strong></button>
        </div>
    </form>
@endsection
