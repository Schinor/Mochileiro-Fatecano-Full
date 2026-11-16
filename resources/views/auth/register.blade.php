@extends('layouts.app')

@section('titulo', 'Cadastre-se')

@section('conteudo')
    <main class="geral">
        <section class="parte-esquerda">
            <img src="/imagens/Gemini_Generated_Image_sehlo3sehlo3sehl.png" alt="Jovem lendo livro">
        </section>
        <section class="parte-direita">
            <form class="formulario" method="POST" action="/register">
                @csrf
                <h1>Cadastre-se</h1>
                @include('partials.erros')
                <div class="campo">
                    <label for="name">Nome</label>
                    <input id="name" type="text" name="name" value="{{ old('name') }}" required>
                </div>
                <div class="campo">
                    <label for="email">E-mail</label>
                    <input id="email" type="email" name="email" value="{{ old('email') }}" required>
                </div>
                <div class="campo">
                    <label for="password">Senha</label>
                    <input id="password" type="password" name="password" required>
                </div>
                <div class="campo">
                    <label for="password_confirmation">Confirmação da senha</label>
                    <input id="password_confirmation" type="password" name="password_confirmation" required>
                </div>
                <button type="submit" class="botao"><strong>Cadastrar-se</strong></button>
                <p class="rodape-form">Possui conta? <a href="/login"><strong>Entrar</strong></a></p>
            </form>
        </section>
    </main>
@endsection
