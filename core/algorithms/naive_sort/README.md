# Naive Sort — OCaml

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **OCaml**, con **Dune** como sistema de construcción y **Alcotest** como framework de pruebas unitarias.

Tres algoritmos de ordenación con coste $O(n^2)$: **selection sort**, **bubble sort** e **insertion sort**, todos ordenando de forma ascendente el array recibido, sin bibliotecas de ordenamiento ni estructuras auxiliares.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`dune-project`](dune-project) | Proyecto Dune — declara el lenguaje de configuración (3.0) y el nombre del proyecto. |
| [`src/dune`](src/dune) | Declara la librería `naive_sort`. |
| [`src/naive_sort.ml`](src/naive_sort.ml) | Módulo `Naive_sort` — 3 funciones de ordenación. |
| [`test/dune`](test/dune) | Declara el test ejecutable, que depende de `naive_sort` y `alcotest`. |
| [`test/naive_sort_tests.ml`](test/naive_sort_tests.ml) | Suite única: 3 tests (7 casos cada uno). |

**Estructura de directorios esperada:**

```text
naive_sort/
├── dune-project                       # Proyecto Dune
├── src/
│   ├── dune                           # Librería naive_sort
│   └── naive_sort.ml                  # selection_sort, bubble_sort, insertion_sort
├── test/
│   ├── dune                           # Test ejecutable
│   └── naive_sort_tests.ml            # 3 tests, 7 casos cada uno
└── _build/                            # Generado por Dune (no versionado)
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Sigue el mismo patrón que [`numbers`](../../foundations/numbers/) y [`calculator`](../../foundations/unit_test/calculator/): proyecto Dune con la librería en `src/` y los tests en `test/`, usando Alcotest. Las tres funciones se exponen desde el módulo `Naive_sort` y operan sobre el mismo `int array` que reciben.

**EN:** Follows the same pattern as [`numbers`](../../foundations/numbers/) and [`calculator`](../../foundations/unit_test/calculator/): a Dune project with the library in `src/` and the tests in `test/`, using Alcotest. All three functions are exposed from the `Naive_sort` module and operate on the same `int array` they receive.

**Combinación aplicada:** algoritmo iterativo (la especificación no usa recursión) → **1 suite × 3 tests = 3 tests (21 casos)**.

**Applied combination:** iterative algorithm (the specification uses no recursion) → **1 suite × 3 tests = 3 tests (21 cases)**.

### Inicialización / Initialization

**ES:** El proyecto se inició con `dune init proj naive_sort`, que genera un layout ajeno a la convención: un ejecutable de ejemplo en `bin/` (`main.ml` con `print_endline "Hello, World!"`), una librería vacía en `lib/`, un `naive_sort.opam` generado y un `dune-project` con `(lang dune 3.24)`, `generate_opam_files` activado y marcadores de posición (`username/reponame`, `"Author Name"`). Se reestructuró al patrón de `numbers/`: `(lang dune 3.0)` y sin fichero opam, la librería en `src/` en lugar de `lib/`, y se eliminaron `bin/`, `lib/` y el `.opam`.

**EN:** The project was started with `dune init proj naive_sort`, which generates a layout foreign to the convention: a sample executable in `bin/` (`main.ml` with `print_endline "Hello, World!"`), an empty library in `lib/`, a generated `naive_sort.opam` and a `dune-project` with `(lang dune 3.24)`, `generate_opam_files` enabled and placeholder values (`username/reponame`, `"Author Name"`). It was restructured to the `numbers/` pattern: `(lang dune 3.0)` with no opam file, the library in `src/` instead of `lib/`, and `bin/`, `lib/` and the `.opam` were removed.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `dune-project`, `src/dune` y `test/dune` — Configuración de Dune

**ES:** La librería `naive_sort` se declara en `src/dune`; el ejecutable de test en `test/dune` depende de `naive_sort` y `alcotest`.

**EN:** The `naive_sort` library is declared in `src/dune`; the test executable in `test/dune` depends on `naive_sort` and `alcotest`.

```lisp
; dune-project
(lang dune 3.0)
(name naive_sort)
```

```lisp
; src/dune
(library
 (name naive_sort))
```

```lisp
; test/dune
(test
 (name naive_sort_tests)
 (libraries naive_sort alcotest))
```

### `src/naive_sort.ml` — Implementación

**ES:** Las tres funciones reciben un `int array`, lo ordenan *in-place* y devuelven ese mismo array. Como OCaml es funcional e inmutable por defecto, los acumuladores mutables del pseudocódigo (`min_idx`, `j`, `swapped`) se implementan con `ref`. Extracto de `selection_sort`:

**EN:** All three functions take an `int array`, sort it *in-place* and return that same array. Since OCaml is functional and immutable by default, the pseudocode's mutable accumulators (`min_idx`, `j`, `swapped`) are implemented with `ref`. Excerpt from `selection_sort`:

```ocaml
let selection_sort arr =
  let n = Array.length arr in
  if n <= 1 then arr
  else begin
    for i = 0 to n - 2 do
      let min_index = ref i in
      for j = i + 1 to n - 1 do
        if arr.(j) < arr.(!min_index) then min_index := j
      done;
      if !min_index <> i then begin
        let temp = arr.(i) in
        arr.(i) <- arr.(!min_index);
        arr.(!min_index) <- temp
      end
    done;
    arr
  end
```

### `test/naive_sort_tests.ml` — Suite de pruebas

**ES:** Una única suite con un `test_case` por función. Los 7 casos viven en una lista de constantes compartida y un único helper los recorre para cualquier función:

**EN:** A single suite with one `test_case` per function. The 7 cases live in a shared list of constants and a single helper walks them for any function:

```ocaml
let assert_sorts_all_cases sort algorithm =
  List.iter
    (fun case ->
      Alcotest.check
        (Alcotest.array Alcotest.int)
        (algorithm ^ " should sort " ^ case.description)
        case.expected
        (sort (Array.copy case.input)))
    cases
```

**ES:** `sort` llega como función de primera clase (`Naive_sort.selection_sort`), y la comparación usa el *testable* `Alcotest.array Alcotest.int`, que muestra las diferencias elemento a elemento.

**EN:** `sort` arrives as a first-class function (`Naive_sort.selection_sort`), and the comparison uses the `Alcotest.array Alcotest.int` testable, which shows element-by-element differences.

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

### Verificación estática / Static check

**ES:** El perfil `dev` de Dune activa un conjunto amplio de warnings y los trata **como errores**, así que compilar ya es la verificación estática:

**EN:** Dune's `dev` profile enables a broad set of warnings and treats them **as errors**, so building already is the static check:

```bash
cd ocaml/core/algorithms/naive_sort
dune build @all
```

### Ejecutar las pruebas unitarias / Run tests

```bash
cd ocaml/core/algorithms/naive_sort
dune runtest
```

### Salida esperada / Expected output

```text
Testing `naive_sort'.
  [OK]          naive_sort          0   selection_sort.
  [OK]          naive_sort          1   bubble_sort.
  [OK]          naive_sort          2   insertion_sort.
Test Successful in 0.001s. 3 tests run.
```

> **ES:** 3 tests en total (uno por algoritmo); los 21 casos viven como `check` dentro de ellos (7 por algoritmo), todos pasando.
> **EN:** 3 tests in total (one per algorithm); the 21 cases live as `check`s within them (7 per algorithm), all passing.

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Algoritmo | Función | Entrada ordenada | Entrada invertida |
|-----------|---------|:----------------:|:-----------------:|
| Selection sort | `selection_sort` | $O(n^2)$ | $O(n^2)$ |
| Bubble sort | `bubble_sort` | $O(n)$ (salida temprana) | $O(n^2)$ |
| Insertion sort | `insertion_sort` | $O(n)$ | $O(n^2)$ |

**ES:** Los tres algoritmos operan **in-place** sobre el `int array` recibido; no se crea ningún array auxiliar.

**EN:** All three algorithms operate **in-place** on the received `int array`; no auxiliary array is created.

### Casos cubiertos / Covered cases

| # | Entrada | Salida esperada |
|:-:|---------|-----------------|
| 1 | `[|5; 2; 9; 1; 5; 6|]` | `[|1; 2; 5; 5; 6; 9|]` |
| 2 | `[|1; 2; 3; 4; 5|]` | `[|1; 2; 3; 4; 5|]` |
| 3 | `[|5; 4; 3; 2; 1|]` | `[|1; 2; 3; 4; 5|]` |
| 4 | `[|7; 7; 7; 7|]` | `[|7; 7; 7; 7|]` |
| 5 | `[|3; -1; 4; -5; 0|]` | `[|-5; -1; 0; 3; 4|]` |
| 6 | `[|42|]` | `[|42|]` |
| 7 | `[||]` | `[||]` |

**ES:** Son los 7 casos obligatorios de la especificación. El **caso nulo se omite** (ver la nota correspondiente).

**EN:** These are the 7 mandatory cases from the specification. The **null case is omitted** (see the corresponding note).

---

## 📝 Notas de implementación / Implementation Notes

### 🧬 Ordenamiento *in-place* / In-place sorting

**ES:** Los tres algoritmos reciben un `int array`, que en OCaml es mutable, lo reordenan en el sitio y devuelven ese mismo array. Los tests aíslan cada caso copiando la entrada con `Array.copy`, de modo que un caso no contamine los siguientes.

**EN:** All three algorithms take an `int array`, which is mutable in OCaml, reorder it in place and return that same array. The tests isolate each case by copying the input with `Array.copy`, so one case cannot contaminate the next.

### 🚫 Caso nulo omitido / Null case omitted

**ES:** La especificación pide devolver un indicador de fallo si la entrada es nula. OCaml **no tiene `null`/`nil`**: un `int array` siempre es un array válido, así que una entrada nula no es representable en la firma y no hay indicador que comprobar. La representación alternativa que menciona la especificación (`Option`/`Maybe` vacío) queda fuera de alcance porque esta fase todavía no introduce ese tipo. La guarda `if n <= 1 then arr` cubre el array vacío, que sí es representable, y se prueba como caso 7.

**EN:** The specification asks for a failure indicator when the input is null. OCaml **has no `null`/`nil`**: an `int array` is always a valid array, so a null input is not representable in the signature and there is no indicator to check. The alternative representation the specification mentions (empty `Option`/`Maybe`) is out of scope because this phase does not introduce that type yet. The `if n <= 1 then arr` guard covers the empty array, which is representable, and it is tested as case 7.

### 🔁 Estado mutable con `ref` / Mutable state via `ref`

**ES:** OCaml es funcional e inmutable por defecto, así que los acumuladores que el pseudocódigo escribe como variables mutables (`min_idx`, `j`, `swapped`) se implementan con referencias: `let min_index = ref i in` y escrituras con `min_index := j`, lecturas con `!min_index`. El array, en cambio, es intrínsecamente mutable (`arr.(i) <- v`).

**EN:** OCaml is functional and immutable by default, so the accumulators the pseudocode writes as mutable variables (`min_idx`, `j`, `swapped`) are implemented with references: `let min_index = ref i in` with writes via `min_index := j` and reads via `!min_index`. The array, on the other hand, is intrinsically mutable (`arr.(i) <- v`).

### 🚪 Sin `break`: la salida temprana como condición de `while` / No `break`: early exit as a `while` condition

**ES:** OCaml **no tiene `break`**, así que la optimización de `bubble_sort` no puede escribirse como el `if not swapped then break` del pseudocódigo. Se expresa como condición del bucle externo: `while !i < n - 1 && !swapped do`, con `swapped` inicializado a `true` e `incr i` al final de cada pasada. El comportamiento observable es el mismo —se deja de iterar en cuanto una pasada completa no intercambia nada— y el mejor caso sigue siendo $O(n)$.

**EN:** OCaml **has no `break`**, so `bubble_sort`'s optimisation cannot be written as the pseudocode's `if not swapped then break`. It is expressed as the outer loop's condition: `while !i < n - 1 && !swapped do`, with `swapped` initialised to `true` and `incr i` at the end of each pass. The observable behaviour is the same — it stops iterating as soon as a full pass swaps nothing — and the best case remains $O(n)$.

### ➿ Cotas de los bucles / Loop bounds

**ES:** Las cotas reproducen las del pseudocódigo: `for i = 0 to n - 2` en selection y bubble, `for j = i + 1 to n - 1` en la búsqueda del mínimo, `for j = 0 to n - 2 - !i` en la pasada interna de bubble y `for i = 1 to n - 1` en insertion. Como `for` en OCaml es inclusivo en ambos extremos, coinciden literalmente. Un rango con cota superior negativa no itera ninguna vez, así que no hacen falta guardas extra.

**EN:** The bounds reproduce the pseudocode's: `for i = 0 to n - 2` in selection and bubble, `for j = i + 1 to n - 1` in the minimum search, `for j = 0 to n - 2 - !i` in bubble's inner pass and `for i = 1 to n - 1` in insertion. Since OCaml's `for` is inclusive at both ends, they match literally. A range with a negative upper bound iterates zero times, so no extra guards are needed.

### 🔀 Estabilidad de `insertion_sort` / `insertion_sort` stability

**ES:** El bucle interno se detiene con la comparación estricta `arr.(!j) > key`; los elementos iguales no se desplazan, por lo que `insertion_sort` es estable. El caso 1 (`[|5; 2; 9; 1; 5; 6|]`, con dos cincos) se beneficia de ello, aunque la comparación de los tests se hace sobre valores y no sobre identidad.

**EN:** The inner loop stops on the strict comparison `arr.(!j) > key`; equal elements do not shift, so `insertion_sort` is stable. Case 1 (`[|5; 2; 9; 1; 5; 6|]`, with two fives) benefits from it, although the tests compare values rather than identity.

### 🏷️ Naming y visibilidad / Naming and visibility

**ES:** Las funciones usan `snake_case` (`selection_sort`), que es a la vez la convención de OCaml y el nombre que emplea la especificación, así que la API coincide con el contrato sin traducciones. El módulo `Naive_sort` se genera a partir de `src/naive_sort.ml`; no hay `main()`: el punto de entrada es el `let () = Alcotest.run ...` del ejecutable de test.

**EN:** Functions use `snake_case` (`selection_sort`), which is both OCaml's convention and the name used by the specification, so the API matches the contract with no translation. The `Naive_sort` module is generated from `src/naive_sort.ml`; there is no `main()`: the entry point is the test executable's `let () = Alcotest.run ...`.

### 🧪 Estructura de los tests / Test structure

**ES:** Una única suite con 3 tests. Dos detalles importantes: (1) la comparación usa el *testable* `Alcotest.array Alcotest.int`, en lugar de comparar con `=` y un `check bool`, para que el fallo muestre los arrays esperado y obtenido; (2) el mensaje del contrato (`"{algorithm} should sort an unsorted array"`) se pasa como segundo argumento de `Alcotest.check`, que lo imprime como `ASSERT` y `FAIL` cuando la comparación no se cumple.

**EN:** A single suite with 3 tests. Two important details: (1) the comparison uses the `Alcotest.array Alcotest.int` testable instead of comparing with `=` and a `check bool`, so that failures show the expected and obtained arrays; (2) the contract message (`"{algorithm} should sort an unsorted array"`) is passed as `Alcotest.check`'s second argument, which prints it as `ASSERT` and `FAIL` when the comparison does not hold.

```ocaml
let () =
  let open Alcotest in
  run "naive_sort"
    [
      ( "naive_sort",
        [
          test_case "selection_sort" `Quick (fun () ->
              assert_sorts_all_cases Naive_sort.selection_sort "selection_sort");
          test_case "bubble_sort" `Quick (fun () ->
              assert_sorts_all_cases Naive_sort.bubble_sort "bubble_sort");
          test_case "insertion_sort" `Quick (fun () ->
              assert_sorts_all_cases Naive_sort.insertion_sort "insertion_sort");
        ] );
    ]
```

### 📍 Desviaciones respecto a la ubicación esperada / Deviations from the expected location

| Especificación | Implementación | Motivo |
|----------------|----------------|--------|
| `src/naive_sort.ext` | `src/naive_sort.ml` | El nombre coincide exactamente; solo cambia la extensión. |
| `test/naive_sort_test.ext` | `test/naive_sort_tests.ml` | La convención de `numbers/` para las suites es el sufijo plural `_tests.ml` (`recursive_tests.ml`, `iterative_tests.ml`). |
| `test/run_tests.ext` | *(no existe)* | Dune descubre y ejecuta el ejecutable declarado en `test/dune` con `dune runtest`. Ni `numbers/` ni `calculator/` incluyen un runner propio. |

**ES:** A diferencia de `numbers/`, este módulo no incluye un `src/naive_sort.mli`: al no haber helpers privados que ocultar, el módulo expone exactamente las tres funciones del contrato. `calculator/` tampoco lo tiene.

**EN:** Unlike `numbers/`, this module does not include a `src/naive_sort.mli`: with no private helpers to hide, the module exposes exactly the three contract functions. `calculator/` does not have one either.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

*[← Volver a Algoritmos Puros](../README.md) · [↑ Volver a Core](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
