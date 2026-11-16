<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\MateriaController;
use App\Http\Controllers\NotificacaoController;
use App\Http\Controllers\TermoController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Autenticação (Login e Cadastro)
|--------------------------------------------------------------------------
*/
Route::middleware('guest')->group(function () {
    Route::view('/', 'landing');

    Route::get('/login', [AuthController::class, 'showLogin'])->name('login');
    Route::post('/login', [AuthController::class, 'login'])->middleware('throttle:10,1');

    Route::get('/register', [AuthController::class, 'showRegister']);
    Route::post('/register', [AuthController::class, 'register'])->middleware('throttle:10,1');
});

Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth');

/*
|--------------------------------------------------------------------------
| Termos (Semestres)
|--------------------------------------------------------------------------
*/
Route::middleware('auth')->group(function () {
    Route::get('/inicio', [TermoController::class, 'index']);
    Route::get('/termos/{termo}', [TermoController::class, 'show']);
    Route::post('/termos', [TermoController::class, 'store']);
    Route::delete('/termos/{termo}', [TermoController::class, 'destroy']);

    // Matérias
    Route::resource('materias', MateriaController::class)->except('show');

    // Notificações
    Route::get('/notificacoes', [NotificacaoController::class, 'index']);
    Route::post('/notificacoes/ler-todas', [NotificacaoController::class, 'lerTodas']);
    Route::patch('/notificacoes/{notificacao}', [NotificacaoController::class, 'update']);
    Route::delete('/notificacoes/{notificacao}', [NotificacaoController::class, 'destroy']);
});
