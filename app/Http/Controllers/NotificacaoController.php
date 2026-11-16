<?php

namespace App\Http\Controllers;

use App\Models\Notificacao;
use Illuminate\Http\Request;

class NotificacaoController extends Controller
{
    /**
     * Lista as notificações (GET /notificacoes)
     */
    public function index(Request $request)
    {
        $notificacoes = Notificacao::where('user_id', $request->user()->id)->latest('id')->get();

        return view('notificacoes.index', ['notificacoes' => $notificacoes]);
    }

    /**
     * Marca uma notificação como lida (PATCH /notificacoes/{id})
     */
    public function update(Request $request, Notificacao $notificacao)
    {
        abort_unless($notificacao->user_id === $request->user()->id, 403);

        $notificacao->update(['lida' => true]);

        return redirect('/notificacoes');
    }

    /**
     * Marca todas como lidas (POST /notificacoes/ler-todas)
     */
    public function lerTodas(Request $request)
    {
        Notificacao::where('user_id', $request->user()->id)->update(['lida' => true]);

        return redirect('/notificacoes')->with('sucesso', 'Todas as notificações foram marcadas como lidas.');
    }

    /**
     * Remove a notificação (DELETE /notificacoes/{id})
     */
    public function destroy(Request $request, Notificacao $notificacao)
    {
        abort_unless($notificacao->user_id === $request->user()->id, 403);

        $notificacao->delete();

        return redirect('/notificacoes');
    }
}
