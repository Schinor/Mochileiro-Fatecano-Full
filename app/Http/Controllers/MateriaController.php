<?php

namespace App\Http\Controllers;

use App\Models\Materia;
use App\Models\Notificacao;
use App\Models\Termo;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class MateriaController extends Controller
{
    /**
     * Lista as matérias agrupadas por termo (GET /materias)
     */
    public function index(Request $request)
    {
        $termos = Termo::where('user_id', $request->user()->id)->with(['materias' => fn ($q) => $q->ordenadas()])->orderBy('id')->get();

        return view('materias.index', ['termos' => $termos]);
    }

    /**
     * Exibe o formulário de criação (GET /materias/create)
     */
    public function create(Request $request)
    {
        return view('materias.form', [
            'materia' => new Materia(['termo_id' => $request->query('termo_id')]),
            'termos' => $this->termos($request),
        ]);
    }

    /**
     * Grava uma nova matéria (POST /materias)
     */
    public function store(Request $request)
    {
        $dados = $this->validar($request);
        $dados['user_id'] = $request->user()->id;

        $materia = Materia::create($dados);
        Notificacao::create(['user_id' => $dados['user_id'], 'texto' => "Matéria \"{$materia->nome}\" adicionada."]);

        return redirect('/termos/' . $materia->termo_id)->with('sucesso', 'Matéria cadastrada com sucesso!');
    }

    /**
     * Exibe o formulário de edição (GET /materias/{id}/edit)
     */
    public function edit(Request $request, Materia $materia)
    {
        $this->autorizar($request, $materia);

        return view('materias.form', ['materia' => $materia, 'termos' => $this->termos($request)]);
    }

    /**
     * Atualiza a matéria (PUT/PATCH /materias/{id})
     */
    public function update(Request $request, Materia $materia)
    {
        $this->autorizar($request, $materia);

        $materia->update($this->validar($request));

        return redirect('/termos/' . $materia->termo_id)->with('sucesso', 'Matéria atualizada com sucesso!');
    }

    /**
     * Remove a matéria (DELETE /materias/{id})
     */
    public function destroy(Request $request, Materia $materia)
    {
        $this->autorizar($request, $materia);

        $materia->delete();

        return back()->with('sucesso', 'Matéria removida com sucesso!');
    }

    private function termos(Request $request)
    {
        return Termo::where('user_id', $request->user()->id)->orderBy('id')->get();
    }

    private function autorizar(Request $request, Materia $materia): void
    {
        abort_unless($materia->user_id === $request->user()->id, 403);
    }

    private function validar(Request $request): array
    {
        return $request->validate([
            'nome' => 'required|string|max:255',
            'professor' => 'nullable|string|max:255',
            'dia_semana' => ['required', Rule::in(array_keys(Materia::DIAS))],
            'horario_inicio' => 'required|date_format:H:i',
            'horario_fim' => 'required|date_format:H:i|after:horario_inicio',
            'sala' => 'required|string|max:50',
            'termo_id' => ['required', Rule::exists('termos', 'id')->where('user_id', $request->user()->id)],
        ], [
            'horario_inicio.date_format' => 'Informe um horário válido.',
            'horario_fim.date_format' => 'Informe um horário válido.',
            'horario_fim.after' => 'O horário de fim deve ser depois do horário de início.',
        ], [
            'dia_semana' => 'dia da semana',
            'horario_inicio' => 'horário de início',
            'horario_fim' => 'horário de fim',
            'termo_id' => 'termo',
        ]);
    }
}
