@extends('layouts.app')

@section('titulo', 'Login')

@section('conteudo')
    <main class="geral">
        <section class="parte-esquerda">
            <img src="/imagens/imagemLogin.png" alt="Imagem de um jovem lendo">
        </section>
        <section class="parte-direita">
            <img class="logo" src="/icons/iconeMochilaLogin.png" alt="Icone de mochila">
            <h1>Guia do Mochileiro <br>Fatecano</h1>
            <form class="formulario" method="POST" action="/login">
                @csrf
                @include('partials.erros')
                <div class="campo">
                    <label for="email">E-mail</label>
                    <input id="email" type="email" name="email" value="{{ old('email') }}" placeholder="Digite seu e-mail" required>
                </div>
                <div class="campo">
                    <label for="password">Senha</label>
                    <input id="password" type="password" name="password" placeholder="Digite sua senha" required>
                </div>
                <button type="submit" class="botao"><strong>Entrar</strong></button>
            </form>
            <p class="rodape-form">Ainda não possui conta? <a href="/register"><strong>Cadastrar-se</strong></a></p>
        </section>
    </main>
@endsection
