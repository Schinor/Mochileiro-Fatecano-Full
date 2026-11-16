<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('materias', function (Blueprint $table) {
            $table->unsignedTinyInteger('dia_semana')->nullable()->after('professor');
            $table->string('horario_inicio', 5)->nullable()->after('dia_semana');
            $table->string('horario_fim', 5)->nullable()->after('horario_inicio');
        });
    }

    public function down(): void
    {
        Schema::table('materias', function (Blueprint $table) {
            $table->dropColumn(['dia_semana', 'horario_inicio', 'horario_fim']);
        });
    }
};
