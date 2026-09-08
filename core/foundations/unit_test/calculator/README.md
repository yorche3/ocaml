# Calculator — OCaml

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **OCaml**, usando **Dune** como sistema de construcción y **Alcotest** como framework de pruebas unitarias.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`dune-project`](dune-project) | Proyecto Dune — declara el lenguaje de configuración (3.0) y el nombre del proyecto. |
| [`src/dune`](src/dune) | Declara la librería `calculator`. |
| [`src/calculator.ml`](src/calculator.ml) | Módulo `Calculator` con las 5 operaciones aritméticas. |
| [`test/dune`](test/dune) | Declara el test ejecutable con las librerías `calculator` y `alcotest`. |
| [`test/calculator_test.ml`](test/calculator_test.ml) | 5 pruebas unitarias con `Alcotest.run` y `Alcotest.check`. |

**Estructura de directorios esperada:**

```text
calculator/
├── dune-project                  # Proyecto Dune
├── src/
│   ├── dune                      # Librería calculator
│   └── calculator.ml             # 5 operaciones aritméticas
├── test/
│   ├── dune                      # Test con Alcotest
│   └── calculator_test.ml        # 5 tests
└── _build/                       # Generado por Dune (no versionado)
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **Dune** (el sistema de construcción estándar de OCaml) con el layout `src/` (librería) + `test/` (test ejecutable) y **Alcotest**:

1. `calculator` es una librería con funciones simples; el módulo se llama `Calculator` (capitalización automática del archivo `calculator.ml`).
2. Cada prueba es un `test_case` de Alcotest y verifica con `check int`.
3. `dune runtest` compila y ejecuta la suite automáticamente.
4. `multiplication`, `division` y `modulus` se implementan con las estrategias educativas de la especificación (sin usar los operadores `*`, `/` ni `mod` respectivamente).

**EN:** This project uses **Dune** (OCaml's standard build system) with the `src/` (library) + `test/` (test executable) layout and **Alcotest**:

1. `calculator` is a library with plain functions; the module is named `Calculator` (automatic capitalization of `calculator.ml`).
2. Each test is an Alcotest `test_case` and verifies with `check int`.
3. `dune runtest` compiles and runs the suite automatically.
4. `multiplication`, `division` and `modulus` are implemented with the educational strategies from the specification (without using the `*`, `/` or `mod` operators respectively).

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `dune-project` y `src/dune` — Configuración de Dune

**ES:** El proyecto usa Dune lang 3.0. La librería `calculator` se declara en `src/dune` y el test en `test/dune` con la dependencia `alcotest`.

**EN:** The project uses Dune lang 3.0. The `calculator` library is declared in `src/dune`, and the test in `test/dune` with the `alcotest` dependency.

```lisp
; dune-project
(lang dune 3.0)
(name calculator)
```

```lisp
; src/dune
(library
 (name calculator))
```

```lisp
; test/dune
(test
 (name calculator_test)
 (libraries calculator alcotest))
```

### `src/calculator.ml` — Módulo principal

| Operación | Implementación educativa |
| --------- | ------------------------ |
| `addition(a, b)` | Suma directa (`a + b`). |
| `subtraction(a, b)` | Resta directa (`a - b`). |
| `multiplication(a, b)` | Suma repetitiva: acumula `a`, `b` veces (no usa `*`). |
| `division(a, b)` | Resta repetitiva: resta `b` de `a` mientras `a >= b` (no usa `/`). |
| `modulus(a, b)` | Construida sobre `division` y `multiplication` (no usa `mod`). |

```ocaml
let addition a b = a + b

let subtraction a b = a - b

let multiplication a b =
  let result = ref 0 in
  for _ = 1 to b do
    result := addition !result a
  done;
  !result

let division a b =
  let remaining = ref a in
  let quotient = ref 0 in
  while !remaining >= b do
    remaining := subtraction !remaining b;
    quotient := addition !quotient 1
  done;
  !quotient

let modulus a b =
  let q = division a b in
  let p = multiplication q b in
  subtraction a p
```

### `test/calculator_test.ml` — Pruebas unitarias (Alcotest)

**ES:** Un `test_case` por operación, con los mismos casos del pseudocódigo de la especificación.

**EN:** One `test_case` per operation, with the same cases as the specification pseudocode.

```ocaml
let () =
  let open Alcotest in
  run "calculator"
    [
      ( "calculator",
        [
          test_case "addition(2, 3) returns 5" `Quick (fun () ->
              check int "addition" 5 (Calculator.addition 2 3));
          test_case "subtraction(5, 2) returns 3" `Quick (fun () ->
              check int "subtraction" 3 (Calculator.subtraction 5 2));
          test_case "multiplication(3, 4) returns 12" `Quick (fun () ->
              check int "multiplication" 12 (Calculator.multiplication 3 4));
          test_case "division(10, 3) returns 3" `Quick (fun () ->
              check int "division" 3 (Calculator.division 10 3));
          test_case "modulus(10, 3) returns 1" `Quick (fun () ->
              check int "modulus" 1 (Calculator.modulus 10 3));
        ] );
    ]
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **OCaml** (`ocaml`, `ocamlc`) — vía switch de opam.
- **Dune** (`dune`).
- **Alcotest** (paquete de opam).

```bash
ocaml --version
dune --version

# Instalar alcotest en el switch activo
opam install alcotest
```

### Ejecutar las pruebas unitarias / Run tests

```bash
cd ocaml/core/foundations/unit_test/calculator
dune runtest
```

### Salida esperada / Expected output

```text
Testing `calculator'.
  [OK]          calculator          0   addition(2, 3) returns 5.
  [OK]          calculator          1   subtraction(5, 2) returns 3.
  [OK]          calculator          2   multiplication(3, 4) returns 12.
  [OK]          calculator          3   division(10, 3) returns 3.
  [OK]          calculator          4   modulus(10, 3) returns 1.
Test Successful in 0.000s. 5 tests run.
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** El proyecto no usa un `main`: el "punto de entrada" es `dune runtest`, que compila el ejecutable de test y lo ejecuta. Por eso no se necesita el `run_tests` del pseudocódigo (la especificación lo pide solo si el framework no lo incluye).
- **EN:** The project has no `main`: the "entry point" is `dune runtest`, which compiles and runs the test executable. That's why the pseudocode's `run_tests` is not needed (the specification asks for it only if the framework doesn't include one).
- **ES:** Alcotest es una dependencia externa (opam) **solo para pruebas**; la librería `calculator` usa únicamente la biblioteca estándar.
- **EN:** Alcotest is an external (opam) dependency **for tests only**; the `calculator` library uses only the standard library.
- **ES:** Al ser OCaml inmutable, los bucles usan `ref` para mutar `result`/`remaining`/`quotient`.
- **EN:** Since OCaml is immutable, the loops use `ref` to mutate `result`/`remaining`/`quotient`.
- **ES:** El índice del bucle se declara con `_` (`for _ = 1 to b`) porque no se usa; Dune trata el warning 35 como error.
- **EN:** The loop index uses `_` (`for _ = 1 to b`) because it is unused; Dune treats warning 35 as an error.
- **ES:** `division` no valida `b == 0` (fuera del alcance de este ejemplo, como indica la especificación).
- **EN:** `division` does not validate `b == 0` (out of scope for this example, as the specification states).

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
