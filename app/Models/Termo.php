<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Termo extends Model
{
    protected $fillable = ['user_id', 'nome', 'cor'];

    public function materias()
    {
        return $this->hasMany(Materia::class);
    }
}
