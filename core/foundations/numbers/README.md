# Numbers — OCaml

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **OCaml**, usando **Dune** como sistema de construcción y **Alcotest** como framework de pruebas unitarias.

Tres enfoques de implementación para los mismos 5 algoritmos: **recursivo directo** (`_rec`), **recursivo con acumulador** (`_acc`) e **iterativo** (`_ite`).

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`dune-project`](dune-project) | Proyecto Dune — declara el lenguaje de configuración (3.0) y el nombre del proyecto. |
| [`src/dune`](src/dune) | Declara la librería `numbers`. |
| [`src/numbers.ml`](src/numbers.ml) | Módulo `Numbers` — 15 funciones (3 enfoques × 5 algoritmos) + 4 helpers `_help`. |
| [`src/numbers.mli`](src/numbers.mli) | Interfaz del módulo: expone solo las 15 funciones públicas (los `_help` quedan privados). |
| [`test/dune`](test/dune) | Declara los 3 test ejecutables con `numbers` y `alcotest`. |
| [`test/recursive_tests.ml`](test/recursive_tests.ml) | Suite recursiva: 5 tests (11 casos). |
| [`test/recursive_with_acc_tests.ml`](test/recursive_with_acc_tests.ml) | Suite con acumulador: 5 tests (11 casos). |
| [`test/iterative_tests.ml`](test/iterative_tests.ml) | Suite iterativa: 5 tests (11 casos). |

**Estructura de directorios esperada:**

```text
numbers/
├── dune-project                       # Proyecto Dune
├── src/
│   ├── dune                           # Librería numbers
│   ├── numbers.ml                     # 15 funciones + 4 helpers privados
│   └── numbers.mli                    # Interfaz pública (oculta los helpers)
├── test/
│   ├── dune                           # 3 test ejecutables
│   ├── recursive_tests.ml             # Tests recursivos (5 tests, 11 casos)
│   ├── recursive_with_acc_tests.ml    # Tests con acumulador (5 tests, 11 casos)
│   └── iterative_tests.ml             # Tests iterativos (5 tests, 11 casos)
└── _build/                            # Generado por Dune (no versionado)
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Sigue el mismo patrón que [`calculator`](../unit_test/calculator/): proyecto Dune con librería en `src/` y tests en `test/`, usando Alcotest. Las 15 funciones se organizan en 3 grupos por enfoque:

| Enfoque | Sufijo | Ejemplo | ¿Tiene tests directos? |
| ------- | ------ | ------- | :---------------------: |
| Recursivo directo | `_rec` | `fibonacci_rec(n)` | ✅ Sí |
| Recursivo con acumulador | `_acc` | `fibonacci_acc(n)` | ✅ Sí (ver nota TCO) |
| Iterativo | `_ite` | `fibonacci_ite(n)` | ✅ Sí |

**EN:** Follows the same pattern as [`calculator`](../unit_test/calculator/): a Dune project with a library in `src/` and tests in `test/`, using Alcotest. The 15 functions are organized into 3 groups by approach:

| Approach | Suffix | Example | Direct tests? |
| -------- | ------ | ------- | :-----------: |
| Direct recursion | `_rec` | `fibonacci_rec(n)` | ✅ Yes |
| Accumulator recursion | `_acc` | `fibonacci_acc(n)` | ✅ Yes (see TCO note) |
| Iterative | `_ite` | `fibonacci_ite(n)` | ✅ Yes |

**Combinación aplicada:** TCO ✅ + iteración ✅ → `_rec` + `_acc` + `_ite` = **3 suites × 5 tests = 15 tests (33 casos)**.

**Applied combination:** TCO ✅ + iteration ✅ → `_rec` + `_acc` + `_ite` = **3 suites × 5 tests = 15 tests (33 cases)**.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `dune-project`, `src/dune` y `test/dune` — Configuración de Dune

**ES:** La librería `numbers` se declara en `src/dune`; los 3 ejecutables de test en `test/dune` dependen de `numbers` y `alcotest`.

**EN:** The `numbers` library is declared in `src/dune`; the 3 test executables in `test/dune` depend on `numbers` and `alcotest`.

```lisp
; src/dune
(library
 (name numbers))
```

```lisp
; test/dune
(test
 (name recursive_tests)
 (libraries numbers alcotest))

(test
 (name recursive_with_acc_tests)
 (libraries numbers alcotest))

(test
 (name iterative_tests)
 (libraries numbers alcotest))
```

### `src/numbers.ml` — Implementación

**ES:** Cada algoritmo tiene 3 implementaciones en un único archivo. Los helpers del enfoque con acumulador quedan **privados** gracias a `numbers.mli`, que solo expone las 15 funciones públicas. Por ejemplo, `fibonacci`:

**EN:** Each algorithm has 3 implementations in a single file. The accumulator helpers stay **private** thanks to `numbers.mli`, which only exposes the 15 public functions. For example, `fibonacci`:

```ocaml
(* Enfoque recursivo directo / Direct recursion *)
let rec fibonacci_rec n =
  if n <= 1 then n
  else fibonacci_rec (n - 1) + fibonacci_rec (n - 2)

(* Enfoque con acumulador / Accumulator recursion *)
let rec fibonacci_acc_help n acc2 acc1 =
  if n <= 0 then acc2
  else if n <= 2 then acc1 + acc2
  else fibonacci_acc_help (n - 1) acc1 (acc1 + acc2)

let fibonacci_acc n =
  fibonacci_acc_help n 0 1

(* Enfoque iterativo / Iterative *)
let fibonacci_ite n =
  if n <= 1 then n
  else begin
    let acc2 = ref 0 in
    let acc1 = ref 1 in
    for _ = 2 to n do
      let temp = !acc1 + !acc2 in
      acc2 := !acc1;
      acc1 := temp
    done;
    !acc1
  end
```

| Algoritmo | `_rec` | `_acc` | `_ite` |
| --------- | ------ | ------ | ------ |
| `sum_of_first_n` | `n + sum_rec(n-1)` | helper con `acc + n` | bucle `1..n` |
| `factorial` | `n * fact_rec(n-1)` | helper con `acc * n` | bucle `2..n` |
| `fibonacci` | `fib_rec(n-1) + fib_rec(n-2)` | helper con `acc2, acc1` | bucle de intercambio |
| `greatest_common_divisor` | Euclides recursivo | helper (Euclides) | Euclides con `while y <> 0` |
| `least_common_multiple` | `(a*b) / gcd_rec` | `(a*b) / gcd_acc` | `(a*b) / gcd_ite` |

### Suites de pruebas — Alcotest

**ES:** Tres ejecutables de test, uno por enfoque. Cada suite agrupa un `test_case` por función (5 por suite); los 11 casos del pseudocódigo viven como `check` dentro de ellos (33 en total).

**EN:** Three test executables, one per approach. Each suite groups one `test_case` per function (5 per suite); the specification pseudocode's 11 cases live as `check`s within them (33 in total).

```ocaml
test_case "fibonacci_rec" `Quick (fun () ->
    check int "n=0" 0 (Numbers.fibonacci_rec 0);
    check int "n=1" 1 (Numbers.fibonacci_rec 1);
    check int "n=6" 8 (Numbers.fibonacci_rec 6));
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
cd ocaml/core/foundations/numbers
dune runtest
```

### Salida esperada / Expected output

```text
Testing `numbers recursive'.
  [OK]          recursive          0   sum_of_first_n_rec.
  [OK]          recursive          1   factorial_rec.
  [OK]          recursive          2   fibonacci_rec.
  [OK]          recursive          3   greatest_common_divisor_rec.
  [OK]          recursive          4   least_common_multiple_rec.
Test Successful in 0.000s. 5 tests run.
Testing `numbers recursive_with_accumulator'.
  [OK]          recursive_with_accumulator          0   sum_of_first_n_acc.
  ...
Test Successful in 0.001s. 5 tests run.
Testing `numbers iterative'.
  [OK]          iterative          0   sum_of_first_n_ite.
  ...
Test Successful in 0.000s. 5 tests run.
```

> **ES:** 15 tests en total (5 por suite); los 33 casos viven como `check` dentro de ellos, todos pasando.
> **EN:** 15 tests in total (5 per suite); the 33 cases live as `check`s within them, all passing.

---

## 🔁 Sobre recursión con acumulador y Tail Call Optimization (TCO)

**ES:**
Tail recursion ocurre cuando la llamada recursiva es la última acción que ejecuta una función; después de la llamada no hay más instrucciones. La recursión con acumulador consigue esto pasando el estado previo como parámetro, sin dejar trabajo pendiente en la pila.

En OCaml, **sí se garantiza TCO**: tanto el compilador nativo (`ocamlopt`) como el de bytecode (`ocamlc`) optimizan las llamadas de cola, compilándolas como saltos con pila constante. Por eso **sí se desarrollan pruebas unitarias específicas para las funciones `_acc`** (5 tests, 11 casos).

**EN:**
Tail recursion occurs when the recursive call is the last action executed by a function; after the call there are no more instructions. Accumulator recursion achieves this by passing the previous state as a parameter, leaving no pending work on the stack.

In OCaml, **TCO is guaranteed**: both the native compiler (`ocamlopt`) and the bytecode compiler (`ocamlc`) optimize tail calls, compiling them as jumps with constant stack. This is why **dedicated unit tests are written for the `_acc` functions** (5 tests, 11 cases).

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** El proyecto no usa un `main`: el "punto de entrada" es `dune runtest`, que compila y ejecuta los 3 ejecutables de test. Por eso no se necesita el `run_tests` del pseudocódigo (la especificación lo pide solo si el framework no lo incluye).
- **EN:** The project has no `main`: the "entry point" is `dune runtest`, which compiles and runs the 3 test executables. That's why the pseudocode's `run_tests` is not needed (the specification asks for it only if the framework doesn't include one).
- **ES:** Los helpers `_help` no aparecen en `numbers.mli`, por lo que son privados del módulo (equivalente a los helpers privados del pseudocódigo).
- **EN:** The `_help` helpers are not listed in `numbers.mli`, so they are private to the module (equivalent to the pseudocode's private helpers).
- **ES:** La recursión se declara con `let rec`. El resto se calcula con `mod`; la división entera con `/` (en OCaml, `int / int` es entera, sin `Float64`).
- **EN:** Recursion is declared with `let rec`. The remainder is computed with `mod`; integer division with `/` (in OCaml, `int / int` is integer division, no `Float64`).
- **ES:** Al ser OCaml inmutable, las variantes iterativas usan `ref` para mutar acumuladores y contadores.
- **EN:** Since OCaml is immutable, the iterative variants use `ref` to mutate accumulators and counters.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
