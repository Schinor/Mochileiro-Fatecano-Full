<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Materia extends Model
{
    public const DIAS = [
        1 => 'Segunda-feira',
        2 => 'Terça-feira',
        3 => 'Quarta-feira',
        4 => 'Quinta-feira',
        5 => 'Sexta-feira',
        6 => 'Sábado',
        7 => 'Domingo',
    ];

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
}
