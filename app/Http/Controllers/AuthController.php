<?php

namespace App\Http\Controllers;

use App\Models\Notificacao;
use App\Models\Termo;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    /**
     * Cores dos termos criados automaticamente no cadastro.
     */
    private const CORES = ['#E2F4C5', '#EEE7DA', '#A5DD9B', '#C5EBAA', '#FFFFDD', '#AFC8AD'];

    public function showLogin()
    {
        return view('auth.login');
    }

    public function login(Request $request)
    {
        $credenciais = $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        if (! Auth::attempt($credenciais)) {
            return back()->withInput($request->only('email'))
                ->withErrors(['email' => 'E-mail ou senha incorretos.']);
        }

        $request->session()->regenerate();

        return redirect()->intended('/inicio');
    }

    public function showRegister()
    {
        return view('auth.register');
    }

    public function register(Request $request)
    {
        $dados = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255|unique:users,email',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $usuario = User::create($dados);

        foreach (self::CORES as $i => $cor) {
            Termo::create(['user_id' => $usuario->id, 'nome' => ($i + 1) . '°Termo', 'cor' => $cor]);
        }

        Notificacao::create(['user_id' => $usuario->id, 'texto' => 'Bem-vindo ao Guia do Mochileiro Fatecano!']);

        return redirect('/login')->with('sucesso', 'Cadastro realizado! Faça login para continuar.');
    }

    public function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect('/');
    }
}
