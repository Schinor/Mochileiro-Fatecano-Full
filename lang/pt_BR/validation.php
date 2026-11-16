<?php

return [
    'required' => 'O campo :attribute é obrigatório.',
    'string' => 'O campo :attribute deve ser um texto.',
    'email' => 'Informe um e-mail válido em :attribute.',
    'unique' => 'Este valor de :attribute já está cadastrado.',
    'exists' => 'O valor selecionado em :attribute é inválido.',
    'in' => 'O valor selecionado em :attribute é inválido.',
    'date' => 'O campo :attribute não é uma data válida.',
    'after_or_equal' => 'O campo :attribute deve ser hoje ou uma data futura.',
    'numeric' => 'O campo :attribute deve ser um número.',
    'integer' => 'O campo :attribute deve ser um número inteiro.',
    'min' => [
        'numeric' => 'O campo :attribute deve ser no mínimo :min.',
        'string' => 'O campo :attribute deve ter no mínimo :min caracteres.',
    ],
    'max' => [
        'numeric' => 'O campo :attribute não pode ser maior que :max.',
        'string' => 'O campo :attribute não pode ter mais de :max caracteres.',
    ],
    'attributes' => [
        'nome' => 'nome',
        'telefone' => 'telefone',
        'email' => 'e-mail',
        'password' => 'senha',
        'preco' => 'preço',
        'duracao_minutos' => 'duração',
        'cliente_id' => 'cliente',
        'servico_id' => 'serviço',
        'barbeiro_id' => 'barbeiro',
        'data' => 'data',
        'hora' => 'horário',
        'observacoes' => 'observações',
    ],
];
