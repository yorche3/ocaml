# Data Structures Basics — OCaml

Implementación de la especificación [06_Data_Structures_Basics.md](../../../../docs/core/algorithms/06_Data_Structures_Basics.md) en **OCaml**, con un enfoque manual y minimalista.

**ES:** Implementación de `Node`, `LinkedList`, `Stack` y `Queue` sobre registros mutables con enlaces opcionales, usando Dune como sistema de construcción y Alcotest como framework de pruebas.

**EN:** Implementation of `Node`, `LinkedList`, `Stack` and `Queue` over mutable records with optional links, using Dune as the build system and Alcotest as the test framework.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| `lib/data_structures_basics.ml` | Código fuente principal con los cuatro ADT / Main source code with the four ADTs |
| `lib/data_structures_basics.mli` | Interfaz del módulo / Module interface |
| `lib/dune` | Configuración de la biblioteca / Library configuration |
| `test/test_data_structures_basics.ml` | Suite de pruebas con Alcotest / Test suite with Alcotest |
| `test/dune` | Configuración de pruebas / Test configuration |
| `bin/main.ml` | Punto de entrada ejecutable / Executable entry point |
| `bin/dune` | Configuración del ejecutable / Executable configuration |
| `dune-project` | Configuración del proyecto Dune / Dune project configuration |
| `data_structures_basics.opam` | Manifiesto de dependencias generado / Generated dependency manifest |

**ES:** La estructura sigue el layout estándar de Dune (`lib/`, `bin/`, `test/`) en lugar de `src/` y `test/` propuestos por la especificación. Esta es la convención idiomática de OCaml para proyectos con biblioteca, ejecutable y pruebas separadas.

**EN:** The structure follows Dune's standard layout (`lib/`, `bin/`, `test/`) instead of the `src/` and `test/` proposed by the specification. This is OCaml's idiomatic convention for projects with separate library, executable and tests.

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Proyecto creado manualmente con Dune 3.24. La biblioteca se define en `lib/`, el ejecutable en `bin/` y las pruebas en `test/`, siguiendo el layout estándar de Dune para proyectos con múltiples componentes.

**EN:** Project created manually with Dune 3.24. The library is defined in `lib/`, the executable in `bin/` and tests in `test/`, following Dune's standard layout for projects with multiple components.

## 📄 Configuración clave / Key Configuration

**ES:** El archivo `dune-project` define el proyecto con Dune 3.24 y genera automáticamente el archivo `.opam`. La biblioteca depende únicamente de OCaml; las pruebas usan Alcotest como framework. No hay dependencias externas para los algoritmos.

**EN:** The `dune-project` file defines the project with Dune 3.24 and automatically generates the `.opam` file. The library depends only on OCaml; tests use Alcotest as the framework. There are no external dependencies for the algorithms.

## 🚀 Compilación y ejecución / Build & Run

```bash
dune build
dune runtest
```

**Salida real / Actual output:**

```text
Testing `data_structures_basics'.
This run has ID `IKOOIUNC'.

  [OK]          data_structures_basics          0   Node.
  [OK]          data_structures_basics          1   LinkedList.
  [OK]          data_structures_basics          2   Stack.
  [OK]          data_structures_basics          3   Queue.

Full test results in `~/programming_languages/ocaml/core/algorithms/data_structures_basics/_build/.sandbox/64102584ddbde8720def0f246751c68b/default/test/_build/_tests/data_structures_basics'.
Test Successful in 0.001s. 4 tests run.
```

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Node.create` | `int → Node.t` | `O(1)` | Crea un nodo con valor y enlace ausente / Creates a node with value and absent link |
| `Node.value` | `Node.t → int` | `O(1)` | Observa el valor del nodo / Observes the node's value |
| `Node.next` | `Node.t → Node.t option` | `O(1)` | Observa el enlace, `None` si está ausente / Observes the link, `None` if absent |
| `Node.set_next` | `Node.t → Node.t option → unit` | `O(1)` | Reemplaza el enlace / Replaces the link |
| `LinkedList.create` | `unit → LinkedList.t` | `O(1)` | Crea una lista vacía / Creates an empty list |
| `LinkedList.head` | `LinkedList.t → int option` | `O(1)` | Valor de la cabeza, `None` si está vacía / Head value, `None` if empty |
| `LinkedList.insert_head` | `LinkedList.t → int → unit` | `O(1)` | Inserta al inicio / Inserts at the head |
| `LinkedList.insert_tail` | `LinkedList.t → int → unit` | `O(1)` | Inserta al final / Inserts at the tail |
| `LinkedList.delete` | `LinkedList.t → int → bool` | `O(n)` | Elimina la primera aparición, devuelve `true` si tuvo éxito / Removes first occurrence, returns `true` if successful |
| `LinkedList.is_empty` | `LinkedList.t → bool` | `O(1)` | Verdadero si la lista está vacía / True if the list is empty |
| `LinkedList.length` | `LinkedList.t → int` | `O(1)` | Número de nodos / Number of nodes |
| `Stack.create` | `unit → Stack.t` | `O(1)` | Crea una pila vacía / Creates an empty stack |
| `Stack.push` | `Stack.t → int → unit` | `O(1)` | Apila un valor / Pushes a value |
| `Stack.pop` | `Stack.t → int option` | `O(1)` | Desapila el tope, `None` si está vacía / Pops the top, `None` if empty |
| `Stack.peek` | `Stack.t → int option` | `O(1)` | Observa el tope sin extraerlo, `None` si está vacía / Observes the top without removing, `None` if empty |
| `Stack.is_empty` | `Stack.t → bool` | `O(1)` | Verdadero si la pila está vacía / True if the stack is empty |
| `Stack.length` | `Stack.t → int` | `O(1)` | Número de elementos / Number of elements |
| `Queue.create` | `unit → Queue.t` | `O(1)` | Crea una cola vacía / Creates an empty queue |
| `Queue.enqueue` | `Queue.t → int → unit` | `O(1)` | Añade al final / Adds at the rear |
| `Queue.dequeue` | `Queue.t → int option` | `O(1)` | Extrae el frente, `None` si está vacía / Removes the front, `None` if empty |
| `Queue.peek` | `Queue.t → int option` | `O(1)` | Observa el frente sin extraerlo, `None` si está vacía / Observes the front without removing, `None` if empty |
| `Queue.is_empty` | `Queue.t → bool` | `O(1)` | Verdadero si la cola está vacía / True if the queue is empty |
| `Queue.length` | `Queue.t → int` | `O(1)` | Número de elementos / Number of elements |

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Registros mutables con campos `option` | Tipos algebraicos inmutables | Permite mutación local sin reconstruir la estructura, conservando `O(1)` para inserciones y eliminaciones / Allows local mutation without rebuilding the structure, preserving `O(1)` for insertions and deletions |
| `option` para enlaces y lecturas fallibles | Centinela `-1` o excepciones | `option` es el mecanismo idiomático de OCaml para valores opcionales, sin ambigüedad con valores válidos / `option` is OCaml's idiomatic mechanism for optional values, without ambiguity with valid values |
| Contador explícito en cada estructura | Recorrer la estructura para calcular el tamaño | Mantiene `O(1)` para `length` e `is_empty` en lugar de `O(n)` / Keeps `O(1)` for `length` and `is_empty` instead of `O(n)` |
| Interfaz `.mli` separada | Solo archivo `.ml` | Separa el contrato público de la implementación, siguiendo la convención de OCaml / Separates the public contract from the implementation, following OCaml's convention |

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `init(value)` para `Node` | `create value` | `create` es el nombre idiomático de OCaml para constructores / `create` is OCaml's idiomatic name for constructors |
| `init()` para `LinkedList`, `Stack`, `Queue` | `create ()` | Mismo convenio: `create` para constructores / Same convention: `create` for constructors |
| `get_value()`, `get_next()`, `get_head()` | `value`, `next`, `head` | OCaml omite el prefijo `get_` en funciones de acceso / OCaml omits the `get_` prefix in accessor functions |
| `is_empty()` | `is_empty` | Función sin argumentos explícitos, recibe la instancia directamente / Function without explicit arguments, receives the instance directly |
| `size()` | `length` | `length` es el nombre idiomático de OCaml para contar elementos / `length` is OCaml's idiomatic name for counting elements |
| `set_next(next)` | `set_next node link` | Función que recibe el nodo y el nuevo enlace, no método del nodo / Function that receives the node and the new link, not a node method |
| `delete(value)` devuelve éxito/fallo | `delete list value` devuelve `bool` | `true` si eliminó un nodo, `false` si el valor no está / `true` if a node was removed, `false` if the value is absent |
| `pop()`, `peek()`, `dequeue()` devuelven indicador de fallo | Devuelven `int option` | `Some value` en éxito, `None` en fallo, sin centinelas / `Some value` on success, `None` on failure, without sentinels |
| Estructura en `src/` | Estructura en `lib/`, `bin/`, `test/` | Layout estándar de Dune para proyectos con biblioteca, ejecutable y pruebas / Dune's standard layout for projects with library, executable and tests |

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `Node.next` | Enlace ausente | `None` | `Node.next node` devuelve `None` |
| `LinkedList.head` | Lista vacía | `None` | `LinkedList.head empty_list` devuelve `None` |
| `LinkedList.delete` | Valor no encontrado | `false` | `LinkedList.delete list 99` devuelve `false` |
| `Stack.pop` | Pila vacía | `None` | `Stack.pop empty_stack` devuelve `None` |
| `Stack.peek` | Pila vacía | `None` | `Stack.peek empty_stack` devuelve `None` |
| `Queue.dequeue` | Cola vacía | `None` | `Queue.dequeue empty_queue` devuelve `None` |
| `Queue.peek` | Cola vacía | `None` | `Queue.peek empty_queue` devuelve `None` |

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| **Node**: Inicializar y observar valor/enlace | Sí | `test/test_data_structures_basics.ml:node_cases` | Verifica `value` y `next` tras `create` / Verifies `value` and `next` after `create` |
| **Node**: Inicializar otro nodo, enlazar y recorrer | Sí | `test/test_data_structures_basics.ml:node_cases` | Verifica `set_next` y recorrido / Verifies `set_next` and traversal |
| **LinkedList**: Estado vacío | Sí | `test/test_data_structures_basics.ml:linked_list_cases` | Verifica `is_empty`, `length` y `head` tras `create` / Verifies `is_empty`, `length` and `head` after `create` |
| **LinkedList**: Insertar por ambos extremos | Sí | `test/test_data_structures_basics.ml:linked_list_cases` | Inserta 4 elementos y verifica orden / Inserts 4 elements and verifies order |
| **LinkedList**: Eliminar primera aparición | Sí | `test/test_data_structures_basics.ml:linked_list_cases` | Elimina 10 y verifica tamaño y cabeza / Deletes 10 and verifies size and head |
| **LinkedList**: Valor ausente | Sí | `test/test_data_structures_basics.ml:linked_list_cases` | Intenta eliminar 99 y verifica que no cambia / Tries to delete 99 and verifies no change |
| **LinkedList**: Vaciar | Sí | `test/test_data_structures_basics.ml:linked_list_cases` | Elimina todos los elementos y verifica vacío / Deletes all elements and verifies empty |
| **Stack**: Estado vacío y extracción fallida | Sí | `test/test_data_structures_basics.ml:stack_cases` | Verifica `is_empty`, `length`, `peek` y `pop` en pila vacía / Verifies `is_empty`, `length`, `peek` and `pop` on empty stack |
| **Stack**: LIFO y `peek` no mutante | Sí | `test/test_data_structures_basics.ml:stack_cases` | Apila 3 elementos y verifica `peek` sin cambiar tamaño / Pushes 3 elements and verifies `peek` without changing size |
| **Stack**: Extracción y reutilización | Sí | `test/test_data_structures_basics.ml:stack_cases` | Extrae y reutiliza, verifica orden LIFO / Pops and reuses, verifies LIFO order |
| **Stack**: Vacío tras extracción | Sí | `test/test_data_structures_basics.ml:stack_cases` | Intenta `pop` en pila vacía y verifica `is_empty` / Tries `pop` on empty stack and verifies `is_empty` |
| **Queue**: Estado vacío y extracción fallida | Sí | `test/test_data_structures_basics.ml:queue_cases` | Verifica `is_empty`, `length`, `peek` y `dequeue` en cola vacía / Verifies `is_empty`, `length`, `peek` and `dequeue` on empty queue |
| **Queue**: FIFO y `peek` no mutante | Sí | `test/test_data_structures_basics.ml:queue_cases` | Encola 3 elementos y verifica `peek` sin cambiar tamaño / Enqueues 3 elements and verifies `peek` without changing size |
| **Queue**: Extracción y reutilización | Sí | `test/test_data_structures_basics.ml:queue_cases` | Extrae y reutiliza, verifica orden FIFO / Dequeues and reuses, verifies FIFO order |
| **Queue**: Vacío tras extracción | Sí | `test/test_data_structures_basics.ml:queue_cases` | Intenta `dequeue` en cola vacía y verifica `is_empty` / Tries `dequeue` on empty queue and verifies `is_empty` |

**Total de pruebas / Total tests:** 4 tests ejecutados por Alcotest, todos exitosos.

## ⚠️ Limitaciones conocidas / Known limitations

Ninguna / None

**ES:** La implementación cumple todos los criterios de aceptación de la especificación. Las complejidades declaradas se mantienen y no hay límites de capacidad artificiales.

**EN:** The implementation meets all acceptance criteria of the specification. The declared complexities are maintained and there are no artificial capacity limits.

## 📝 Notas de implementación / Implementation Notes

**ES:** OCaml usa registros mutables para los punteros de las estructuras (`head`, `tail`, `top`, `front`, `rear`) y el contador. Los enlaces entre nodos se representan con `option`, donde `None` indica ausencia. Esta es la forma idiomática de OCaml para manejar valores opcionales sin centinelas ni excepciones. La interfaz `.mli` declara el contrato público, separándolo de la implementación. Las pruebas usan Alcotest y cada caso crea su propia instancia para evitar interferencias.

**EN:** OCaml uses mutable records for the structures' pointers (`head`, `tail`, `top`, `front`, `rear`) and the counter. Links between nodes are represented with `option`, where `None` indicates absence. This is OCaml's idiomatic way to handle optional values without sentinels or exceptions. The `.mli` interface declares the public contract, separating it from the implementation. Tests use Alcotest and each case creates its own instance to avoid interference.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_.
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`06_Data_Structures_Basics.md`](../../../../docs/core/algorithms/06_Data_Structures_Basics.md) |
| Módulo homologado del lenguaje / Homologated module | [`ocaml/core/foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [OCaml Official Documentation](https://ocaml.org/docs) |
