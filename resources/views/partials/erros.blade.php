@if (session('sucesso'))
    <p class="aviso sucesso">{{ session('sucesso') }}</p>
@endif
@if ($errors->any())
    <ul class="aviso erro">
        @foreach ($errors->all() as $erro)
            <li>{{ $erro }}</li>
        @endforeach
    </ul>
@endif
