<?php

namespace App\Http\Controllers;

use App\Models\Materia;
use App\Models\Notificacao;
use App\Models\Termo;
use Illuminate\Http\Request;

class TermoController extends Controller
{
    /**
     * Lista os termos do usuário (GET /inicio)
     */
    public function index(Request $request)
    {
        $usuario = $request->user();
        $hoje = now()->dayOfWeekIso;

        return view('termos.index', [
            'termos' => Termo::where('user_id', $usuario->id)->withCount('materias')->orderBy('id')->get(),
            'hoje' => $hoje,
            'aulasHoje' => Materia::where('user_id', $usuario->id)->where('dia_semana', $hoje)->with('termo')->ordenadas()->get(),
        ]);
    }

    /**
     * Exibe as matérias de um termo (GET /termos/{id})
     */
    public function show(Request $request, Termo $termo)
    {
        abort_unless($termo->user_id === $request->user()->id, 403);

        return view('termos.show', ['termo' => $termo, 'materias' => $termo->materias()->ordenadas()->get()]);
    }

    /**
     * Grava uma nova turma (POST /termos)
     */
    public function store(Request $request)
    {
        $dados = $request->validate([
            'nome' => 'required|string|max:50',
            'cor' => ['required', 'regex:/^#[0-9A-Fa-f]{6}$/'],
        ]);
        $dados['user_id'] = $request->user()->id;

        Termo::create($dados);
        Notificacao::create(['user_id' => $dados['user_id'], 'texto' => "Turma \"{$dados['nome']}\" adicionada."]);

        return redirect('/inicio')->with('sucesso', 'Turma adicionada com sucesso!');
    }

    /**
     * Remove a turma e suas matérias (DELETE /termos/{id})
     */
    public function destroy(Request $request, Termo $termo)
    {
        abort_unless($termo->user_id === $request->user()->id, 403);

        $termo->delete();
        Notificacao::create(['user_id' => $request->user()->id, 'texto' => "Turma \"{$termo->nome}\" removida."]);

        return redirect('/inicio')->with('sucesso', 'Turma removida com sucesso!');
    }
}
