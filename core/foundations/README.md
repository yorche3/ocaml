# 🚀 Fundamentos / Foundations — OCaml

Implementación de los ejercicios de la sección [Fundamentos / Foundations](https://yorche3.github.io/programming_languages/core/foundations/) del repositorio principal en **OCaml**.

---

## 📖 Descripción / Description

**ES:** Esta sección reúne los conceptos esenciales para empezar a trabajar con **OCaml**. Cubre desde los programas más básicos (`Hello, World!` y `Hello, User!`) hasta la implementación de una calculadora con pruebas unitarias y algoritmos numéricos en tres enfoques progresivos (recursivo directo, recursivo con acumulador e iterativo).

**EN:** This section brings together the essential concepts to start working with **OCaml**. It covers everything from the most basic programs (`Hello, World!` and `Hello, User!`) to the implementation of a calculator with unit tests and numerical algorithms in three progressive approaches (direct recursion, accumulator recursion, and iterative).

---

## 📁 Estructura / Structure

```text
ocaml/
└── core/
    └── foundations/
        ├── README.md              # Este archivo / This file
        ├── helloworld/            # 01_Hello_World — Primer programa
        │   ├── helloworld.ml
        │   └── README.md
        ├── hellouser/             # 02_Hello_User — Entrada y salida
        │   ├── hellouser.ml
        │   └── README.md
        ├── unit_test/
        │   └── calculator/        # 03_Unit_Test_Calculator — Pruebas unitarias
        │       ├── dune-project
        │       ├── src/
        │       │   ├── dune
        │       │   └── calculator.ml
        │       ├── test/
        │       │   ├── dune
        │       │   └── calculator_test.ml
        │       └── README.md
        └── numbers/               # 04_Numbers — Algoritmos numéricos
            ├── dune-project
            ├── src/
            │   ├── dune
            │   ├── numbers.ml
            │   └── numbers.mli
            ├── test/
            │   ├── dune
            │   ├── recursive_tests.ml
            │   ├── recursive_with_acc_tests.ml
            │   └── iterative_tests.ml
            └── README.md
```

---

## 🔢 Progresión / Progression

| Especificación | Proyecto | Conceptos | Tests | Dependencias externas |
| -------------- | -------- | --------- | :---: | :-------------------: |
| [`01_Hello_World`](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | [`helloworld/`](helloworld/) | `let () = ...`, `print_endline`, `ocamlc`/`ocamlopt` | — | ❌ Solo stdlib |
| [`02_Hello_User`](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | [`hellouser/`](hellouser/) | `print_string`, `read_line`, `Printf.printf`, inmutabilidad | — | ❌ Solo stdlib |
| [`03_Unit_Test_Calculator`](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | [`unit_test/calculator/`](unit_test/calculator/) | Dune, Alcotest, `test_case`, `check`, `ref` | 5 | ✅ Alcotest (solo test) |
| [`04_Numbers`](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | [`numbers/`](numbers/) | Recursión (`let rec`), iteración, acumuladores, `.mli`, TCO | 15 | ✅ Alcotest (solo test) |

---

## 🛠️ Enfoque general / General Approach

**ES:** Los proyectos en esta sección siguen un patrón progresivo:

1. **Hello World** y **Hello User**: Programas de un solo archivo, ejecutados con el intérprete `ocaml` o compilados con `ocamlc`/`ocamlopt`, sin Dune. Usan exclusivamente la biblioteca estándar.
2. **Calculator**: Primer proyecto con dependencia externa (**Alcotest**, vía opam). Introduce **Dune** (`dune-project` + `dune` por directorio), la separación `src/` (librería) + `test/` (ejecutable de test) y el ecosistema `dune runtest`.
3. **Numbers**: Expande el patrón de Calculator a tres suites de prueba (una por enfoque). OCaml **sí garantiza TCO** (llamadas de cola a pila constante), por lo que los tres enfoques (`_rec`, `_acc`, `_ite`) tienen pruebas directas: 15 tests (33 casos).

**EN:** The projects in this section follow a progressive pattern:

1. **Hello World** and **Hello User**: Single-file programs, run with the `ocaml` interpreter or compiled with `ocamlc`/`ocamlopt`, without Dune. Use only the standard library.
2. **Calculator**: First project with an external dependency (**Alcotest**, via opam). Introduces **Dune** (`dune-project` + per-directory `dune` files), the `src/` (library) + `test/` (test executable) separation, and the `dune runtest` ecosystem.
3. **Numbers**: Expands the Calculator pattern to three test suites (one per approach). OCaml **does guarantee TCO** (tail calls to constant stack), so all three approaches (`_rec`, `_acc`, `_ite`) have direct tests: 15 tests (33 cases).

---

## 🚀 Ejecución rápida / Quick Start

### Hello World

```bash
cd ocaml/core/foundations/helloworld
ocaml helloworld.ml
```

### Hello User

```bash
cd ocaml/core/foundations/hellouser
ocaml hellouser.ml
```

### Calculator (pruebas)

```bash
cd ocaml/core/foundations/unit_test/calculator
dune runtest
```

### Numbers (pruebas)

```bash
cd ocaml/core/foundations/numbers
dune runtest
```

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
