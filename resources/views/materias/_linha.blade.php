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
