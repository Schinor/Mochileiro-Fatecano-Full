<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Notificacao extends Model
{
    protected $table = 'notificacoes';

    protected $fillable = ['user_id', 'texto', 'lida'];

    protected function casts(): array
    {
        return ['lida' => 'boolean'];
    }
}
