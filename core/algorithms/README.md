# Algorithms Pure — OCaml

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **OCaml**: ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase trabajan sobre `int array`, que en OCaml **es mutable**, **se indexa desde 0** y **no admite `null`/`nil`**.

---

## 📂 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `dune runtest` + Alcotest | 3 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
└── naive_sort/                        # 05_Naive_Sort
    ├── dune-project                   # (lang dune 3.0) + (name naive_sort)
    ├── src/
    │   ├── dune                       # Librería naive_sort
    │   └── naive_sort.ml              # selection_sort, bubble_sort, insertion_sort
    ├── test/
    │   ├── dune                       # Test ejecutable con alcotest
    │   └── naive_sort_tests.ml        # 3 tests × 7 casos
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | OCaml nativo, compilado con `ocamlopt` a través de Dune |
| **CLI** | `dune runtest` |
| **Proyecto Dune** | `dune-project` con `(lang dune 3.0)` y `(name naive_sort)`; sin fichero opam |
| **Librería** | `src/dune` con `(library (name naive_sort))` → módulo `Naive_sort` |
| **Framework de tests** | Alcotest (`test/dune` con `(test (name …) (libraries … alcotest))`) |
| **Verificación estática** | `dune build @all`: el perfil `dev` trata los warnings como errores |
| **Runner** | `dune runtest`, que compila y ejecuta el test ejecutable declarado en `test/dune` |
| **Separación** | `src/{modulo}.ml` (módulo) ↔ `test/` (suites `*_tests.ml`) |
| **Iteración** | Bucles `for`/`while` nativos; los acumuladores mutables del pseudocódigo se hacen con `ref` |
| **Indexación** | **0-based**, como el pseudocódigo |
| **Naming** | `snake_case` para funciones (`selection_sort`), igual que la especificación; módulo en `PascalCase` generado por Dune |
| **Mutabilidad del array** | `int array` es mutable: `arr.(i) <- v`, con lectura `arr.(i)` |
| **Nulabilidad** | `int array` no admite `null`/`nil`; el caso nulo no es representable y se omite |
| **Sin `break`** | La salida temprana de bubble se expresa como condición del `while` externo |
| **Comparación de arrays** | *Testable* `Alcotest.array Alcotest.int`; `=` también compara contenidos |
| **Artefactos** | `_build/` y los `*.cmi`/`*.annot` — cubiertos por el `.gitignore` de la raíz de `ocaml/` |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Naive Sort Tests
cd naive_sort
dune runtest
```

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).
👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
