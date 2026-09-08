# OCaml

Proyectos en **OCaml**, con programas simples ejecutados con el intérprete `ocaml` o compilados con `ocamlc`/`ocamlopt`, y proyectos con pruebas unitarias gestionados con **Dune** y el framework **Alcotest**.

---

## 📂 Módulos / Modules

| Módulo | Descripción |
| ------ | ----------- |
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `unit_test/calculator`, `numbers` |

---

## ▶️ Comenzar / Getting Started

```bash
# Hello, World!
cd core/foundations/helloworld
ocaml helloworld.ml

# Hello, User!
cd core/foundations/hellouser
ocaml hellouser.ml

# Calculator Tests
cd core/foundations/unit_test/calculator
dune runtest

# Numbers Tests
cd core/foundations/numbers
dune runtest
```

---

## 📦 Requisitos / Requirements

| Herramienta | Instalación |
| ----------- | ----------- |
| [OCaml](https://ocaml.org/install) | `opam init && opam switch create default` (Linux/macOS) / [Instalar](https://ocaml.org/install) |
| [Dune](https://dune.build/) | `opam install dune` |
| [Alcotest](https://github.com/mirage/alcotest) | `opam install alcotest` (solo para proyectos con tests) |

```bash
# Verificar instalación
ocaml --version
dune --version
```

---

## 🏗️ Tipos de proyecto / Project Types

### 1. Programa simple (intérprete o compilador directo)

**ES:** Un único archivo fuente, sin dependencias externas, ejecutado con el intérprete `ocaml` o compilado con `ocamlc` (bytecode) / `ocamlopt` (nativo). Ideal para `helloworld` y `hellouser`. No requiere Dune.

**EN:** A single source file, no external dependencies, run with the `ocaml` interpreter or compiled with `ocamlc` (bytecode) / `ocamlopt` (native). Ideal for `helloworld` and `hellouser`. No Dune required.

```bash
ocaml <File>.ml                    # intérprete
ocamlc <File>.ml -o <out>          # bytecode
ocamlopt <File>.ml -o <out>.native # nativo
```

### 2. Proyecto con pruebas unitarias (Dune + Alcotest)

**ES:** Para proyectos que requieren pruebas unitarias, se usa **Dune** (`dune-project` + un archivo `dune` por directorio) y **Alcotest** como dependencia de test (instalada vía opam). El código fuente se organiza en `src/` (librería) y las pruebas en `test/` (ejecutables de test), con `dune runtest` como punto de entrada.

**EN:** For projects that require unit tests, **Dune** (`dune-project` + one `dune` file per directory) and **Alcotest** are used as a test dependency (installed via opam). Source code goes in `src/` (library) and tests in `test/` (test executables), with `dune runtest` as the entry point.

```bash
dune runtest
```

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*