// =====================================================================
// modelo.typ — estilos (base ABNT NBR 14724) e marcadores de preenchimento
// Não precisa mexer aqui para preencher o relatório: edite relatorio.typ.
// =====================================================================

// Compile com `typst compile relatorio.typ --input final=true` para a
// versão de entrega: qualquer marcador esquecido faz a compilação FALHAR.
#let modo-final = sys.inputs.at("final", default: "false") == "true"

// ---------------------------------------------------------------------
// Marcadores
//   PREENCHER  → dado que sai do repositório (Claude Code preenche)
//   VERIFICAR  → texto já escrito, conferir no código antes de manter
//   EQUIPE     → texto autoral do grupo (Marcio / Luis escrevem)
//   PRINT      → figura/print de tela pendente
// ---------------------------------------------------------------------
#let _cores = (
  PREENCHER: rgb("#d4a017"),
  VERIFICAR: rgb("#e06c00"),
  EQUIPE: rgb("#1f6fb2"),
  PRINT: rgb("#6b6b6b"),
)

#let _marca(tipo, corpo) = {
  if modo-final { panic("Marcador " + tipo + " pendente no relatório") }
  let cor = _cores.at(tipo)
  highlight(fill: cor.lighten(78%), extent: 1pt)[
    #text(size: 0.72em, weight: "bold", fill: cor.darken(25%))[#tipo:] #corpo
  ]
}

#let preencher(corpo) = _marca("PREENCHER", corpo)
#let verificar(corpo) = _marca("VERIFICAR", corpo)
#let equipe(corpo) = _marca("EQUIPE", corpo)

// Bloco grande, para parágrafos inteiros a escrever
#let bloco(tipo, corpo) = {
  if modo-final { panic("Bloco " + tipo + " pendente no relatório") }
  let cor = _cores.at(tipo)
  block(
    width: 100%, inset: 8pt, radius: 3pt,
    fill: cor.lighten(85%), stroke: (left: 3pt + cor),
  )[
    #set par(first-line-indent: 0pt, justify: false)
    #set text(size: 10pt)
    #text(weight: "bold", fill: cor.darken(25%))[#tipo] \
    #corpo
  ]
}

// Print pendente: vira a imagem real quando o arquivo existir.
// Uso: #print-tela("figuras/login.png", "Tela de login")
#let print-tela(arquivo, descricao) = {
  if modo-final { panic("Print pendente: " + arquivo) }
  block(
    width: 100%, height: 5.5cm, radius: 3pt,
    stroke: (paint: _cores.PRINT, thickness: 1pt, dash: "dashed"),
    fill: _cores.PRINT.lighten(90%),
  )[
    #set align(center + horizon)
    #set par(first-line-indent: 0pt)
    #text(weight: "bold", fill: _cores.PRINT)[PRINT PENDENTE] \
    #text(size: 9pt)[#descricao] \
    #text(size: 8pt, font: "Liberation Mono")[#arquivo]
  ]
}

// ---------------------------------------------------------------------
// Figura e tabela no padrão ABNT: legenda em cima, "Fonte:" embaixo
// ---------------------------------------------------------------------
#let fonte(txt) = align(center, text(size: 10pt)[Fonte: #txt])

#let figura(corpo, legenda: [], fonte-txt: [Elaborado pelos autores (2026).]) = figure(
  [#corpo #fonte(fonte-txt)],
  caption: legenda,
  kind: image,
)

#let tabela(corpo, legenda: [], fonte-txt: [Elaborado pelos autores (2026).]) = figure(
  [#corpo #fonte(fonte-txt)],
  caption: legenda,
  kind: table,
)

// Trecho de código com legenda ("Código 1 – ...")
#let codigo(corpo, legenda: [], fonte-txt: [Elaborado pelos autores (2026).]) = figure(
  [#block(width: 100%, inset: 8pt, fill: luma(245), radius: 2pt, align(left, corpo)) #fonte(fonte-txt)],
  caption: legenda,
  kind: "codigo",
  supplement: [Código],
)

// Título de página pré-textual (centralizado, fora do sumário)
#let titulo-pre(t) = align(center, block(below: 1.2em, text(weight: "bold")[#t]))

// ---------------------------------------------------------------------
// Template principal
// ---------------------------------------------------------------------
#let relatorio(
  instituicao: [],
  curso: [],
  disciplina: [],
  professor: [],
  autores: (),
  titulo: [],
  subtitulo: none,
  natureza: [],
  cidade: [],
  ano: [],
  doc,
) = {
  set document(title: "Relatório técnico")
  set page(
    paper: "a4",
    margin: (top: 3cm, left: 3cm, bottom: 2cm, right: 2cm),
  )
  set text(font: ("Times New Roman", "Liberation Serif", "TeX Gyre Termes"), size: 12pt, lang: "pt", region: "br")
  set par(justify: true, leading: 0.9em, first-line-indent: (amount: 1.25cm, all: true), spacing: 0.9em)
  set heading(numbering: "1.1.1")
  show raw: set text(font: ("Liberation Mono", "DejaVu Sans Mono"), size: 9pt)

  // Títulos: nível 1 em CAIXA ALTA, nova página
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(size: 12pt, weight: "bold")
    block(below: 1.4em)[#if it.numbering != none [#counter(heading).display() #h(0.6em)]#upper(it.body)]
  }
  show heading.where(level: 2): it => {
    set text(size: 12pt, weight: "bold")
    block(above: 1.4em, below: 1em)[#counter(heading).display() #h(0.6em)#it.body]
  }
  show heading.where(level: 3): it => {
    set text(size: 12pt, weight: "regular", style: "italic")
    block(above: 1.2em, below: 0.8em)[#counter(heading).display() #h(0.6em)#it.body]
  }

  // Legendas ABNT
  set figure.caption(position: top, separator: [ – ])
  show figure.caption: set text(size: 10pt)
  show figure.where(kind: table): set block(breakable: true)
  set table(stroke: 0.5pt, inset: 5pt)
  show table: set text(size: 10pt)
  show table: set par(justify: false, first-line-indent: 0pt)

  // ----------------------------- CAPA -----------------------------
  page(numbering: none)[
    #set align(center)
    #set par(first-line-indent: 0pt, justify: false)
    #text(weight: "bold")[#upper(instituicao)] \
    #upper(curso) \
    #if disciplina != [] [Disciplina: #disciplina]
    #v(3cm)
    #for a in autores [#upper(a) \ ]
    #v(1fr)
    #text(size: 14pt, weight: "bold")[#upper(titulo)]
    #if subtitulo != none [ \ #text(size: 12pt)[#subtitulo]]
    #v(1fr)
    #cidade \
    #ano
  ]

  // ------------------------- FOLHA DE ROSTO -----------------------
  page(numbering: none)[
    #set align(center)
    #set par(first-line-indent: 0pt, justify: false)
    #for a in autores [#upper(a) \ ]
    #v(1fr)
    #text(size: 14pt, weight: "bold")[#upper(titulo)]
    #if subtitulo != none [ \ #subtitulo]
    #v(1.5cm)
    #align(right, box(width: 55%, align(left, par(justify: true, leading: 0.6em, text(size: 10pt)[
      #natureza \
      Disciplina: #disciplina \
      Professor(a): #professor
    ]))))
    #v(1fr)
    #cidade \
    #ano
  ]

  doc
}
