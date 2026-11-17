# Data Structures Advanced — OCaml

Implementación de la especificación [07_Data_Structures_Advanced.md](../../../../docs/core/algorithms/07_Data_Structures_Advanced.md) en **OCaml**, con un enfoque manual y minimalista.

**ES:** Implementación funcional e inmutable de `TreeNode`, `BinaryTree` (árbol binario de búsqueda) y `Graph` (grafo dirigido con registro canónico enlazado y adyacencia ordenada), usando Dune como sistema de construcción y Alcotest como framework de pruebas.

**EN:** Functional immutable implementation of `TreeNode`, `BinaryTree` (binary search tree) and `Graph` (directed graph with linked canonical registry and sorted adjacency), using Dune as build system and Alcotest as test framework.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| `lib/data_structures_advanced.ml` | Código fuente principal con `TreeNode`, `BinaryTree` y `Graph` / Main source code with `TreeNode`, `BinaryTree` and `Graph` |
| `lib/data_structures_advanced.mli` | Interfaz del módulo con contratos y firmas públicas / Module interface with public contracts and signatures |
| `lib/dune` | Configuración de compilación de la biblioteca / Library build configuration |
| `test/test_data_structures_advanced.ml` | Suite de pruebas unitarias con Alcotest / Unit test suite with Alcotest |
| `test/dune` | Configuración de compilación de pruebas / Test build configuration |
| `bin/main.ml` | Punto de entrada ejecutable / Executable entry point |
| `bin/dune` | Configuración del ejecutable / Executable configuration |
| `dune-project` | Configuración del proyecto Dune / Dune project configuration |
| `data_structures_advanced.opam` | Manifiesto de dependencias generado / Generated dependency manifest |
| `.gitignore` | Archivos generados excluidos del control de versiones / Ignored generated files |

**ES:** La estructura sigue el layout estándar de Dune (`lib/`, `bin/`, `test/`) en lugar de `src/` y `test/` propuestos por la especificación. Esta es la convención idiomática de OCaml para proyectos modulares con biblioteca, ejecutable y pruebas separadas.

**EN:** The structure follows Dune's standard layout (`lib/`, `bin/`, `test/`) instead of the `src/` and `test/` proposed by the specification. This is OCaml's idiomatic convention for modular projects with separate library, executable and tests.

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Proyecto creado manualmente con Dune 3.24. Se adopta la variante persistente e inmutable (V2): las operaciones que actualizan estructuras devuelven una nueva versión sin mutar las instancias previas. La biblioteca se define en `lib/`, el ejecutable en `bin/` y las pruebas en `test/`.

**EN:** Project created manually with Dune 3.24. A persistent and immutable variant (V2) is adopted: operations that update structures return a new version without mutating previous instances. The library is defined in `lib/`, executable in `bin/` and tests in `test/`.

## 📄 Configuración clave / Key Configuration

**ES:** El archivo `dune-project` define el proyecto con Dune 3.24 y genera automáticamente el manifiesto `.opam`. La biblioteca no requiere dependencias externas más allá del compilador OCaml estándar. La suite de pruebas usa Alcotest como framework.

**EN:** The `dune-project` file defines the project with Dune 3.24 and automatically generates the `.opam` manifest. The library requires no external dependencies beyond the standard OCaml compiler. The test suite uses Alcotest as the test framework.

## 🚀 Compilación y ejecución / Build & Run

```bash
dune build
dune runtest
```

**Salida real / Actual output:**

```text
Testing `data_structures_advanced'.
This run has ID `7133I00U'.

  [OK]          TreeNode            0   create a tree node.
  [OK]          TreeNode            1   absent initial links.
  [OK]          TreeNode            2   link two children.
  [OK]          TreeNode            3   traverse each link.
  [OK]          TreeNode            4   unlink children.
  [OK]          TreeNode            5   immutable adaptation.
  [OK]          BinaryTree          0   create empty.
  [OK]          BinaryTree          1   insert the root.
  [OK]          BinaryTree          2   insert lower and higher.
  [OK]          BinaryTree          3   multilevel branches.
  [OK]          BinaryTree          4   missing value in nonempty tree.
  [OK]          BinaryTree          5   idempotent duplicate.
  [OK]          BinaryTree          6   ordered insertions.
  [OK]          Graph               0   create empty.
  [OK]          Graph               1   isolated vertex.
  [OK]          Graph               2   nonconsecutive labels and directed edge.
  [OK]          Graph               3   duplicate vertex preserves adjacency.
  [OK]          Graph               4   duplicate edge.
  [OK]          Graph               5   missing endpoint without mutation.
  [OK]          Graph               6   sorted neighbours and counts.
  [OK]          Graph               7   missing-edge query.
  [OK]          Graph               8   neighbours of missing vertex.
  [OK]          Graph               9   self-loop and duplicate.
  [OK]          Graph              10   neighbour-result isolation.

Full test results in `~/programming_languages/ocaml/core/algorithms/data_structures_advanced/_build/.sandbox/589d7fb8121dab5175f27f120262660e/default/test/_build/_tests/data_structures_advanced'.
Test Successful in 0.004s. 24 tests run.
```

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `TreeNode.create` | `int → TreeNode.t` | `O(1)` | Crea un nodo con valor y ambos enlaces ausentes (`None`) / Creates node with value and absent links (`None`) |
| `TreeNode.value` | `TreeNode.t → int` | `O(1)` | Observa el valor almacenado / Observes the stored value |
| `TreeNode.left` | `TreeNode.t → TreeNode.t option` | `O(1)` | Observa el enlace izquierdo (`None` si ausente) / Observes left link (`None` if absent) |
| `TreeNode.right` | `TreeNode.t → TreeNode.t option` | `O(1)` | Observa el enlace derecho (`None` si ausente) / Observes right link (`None` if absent) |
| `TreeNode.with_left` | `TreeNode.t → TreeNode.t option → TreeNode.t` | `O(1)` | Copia inmutable con nuevo subárbol izquierdo / Immutable copy with new left subtree |
| `TreeNode.with_right` | `TreeNode.t → TreeNode.t option → TreeNode.t` | `O(1)` | Copia inmutable con nuevo subárbol derecho / Immutable copy with new right subtree |
| `BinaryTree.create` | `unit → BinaryTree.t` | `O(1)` | Crea un árbol vacío utilizable / Creates a usable empty tree |
| `BinaryTree.insert` | `BinaryTree.t → int → BinaryTree.t` | `O(h)` | Inserta preservando invariante ABB; duplicado es idempotente / Inserts preserving BST invariant; duplicate is idempotent |
| `BinaryTree.contains` | `BinaryTree.t → int → bool` | `O(h)` | Búsqueda según la invariante de ordenación del ABB / Search following BST ordering invariant |
| `BinaryTree.is_empty` | `BinaryTree.t → bool` | `O(1)` | Verdadero si el árbol carece de nodos / True if tree has no nodes |
| `BinaryTree.size` | `BinaryTree.t → int` | `O(1)` | Número de valores almacenados / Number of stored values |
| `Graph.create` | `unit → Graph.t` | `O(1)` | Crea un grafo vacío utilizable / Creates a usable empty graph |
| `Graph.add_vertex` | `Graph.t → int → Graph.t` | `O(V)` | Registra vértice; duplicado conserva vecinos / Registers vertex; duplicate preserves neighbours |
| `Graph.add_edge` | `Graph.t → int → int → bool * Graph.t` | `O(V + d(u))` | Inserta arista dirigida `u -> v`; fallo si falta extremo / Inserts directed edge `u -> v`; fails if endpoint missing |
| `Graph.has_edge` | `Graph.t → int → int → bool` | `O(V + d(u))` | Comprueba existencia de arista dirigida `u -> v` / Checks existence of directed edge `u -> v` |
| `Graph.get_neighbors` | `Graph.t → int → int list option` | `O(V + d(u))` | Vecinos ordenados; `None` si `u` falta, `Some []` si aislado / Sorted neighbours; `None` if missing, `Some []` if isolated |
| `Graph.is_empty` | `Graph.t → bool` | `O(1)` | Verdadero si no hay vértices / True if no vertices registered |
| `Graph.vertex_count` | `Graph.t → int` | `O(1)` | Cantidad de vértices registrados / Number of registered vertices |
| `Graph.edge_count` | `Graph.t → int` | `O(1)` | Cantidad de aristas registradas / Number of registered edges |

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Inmutabilidad y persistencia funcional (V2) | Registros mutables con referencias (`ref`) | En OCaml la inmutabilidad estructural es idiomática, evita estados compartidos accidentales y permite que consultas previas permanezcan aisladas de modificaciones posteriores sin copias defensivas / In OCaml structural immutability is idiomatic, prevents accidental shared state and ensures previous queries remain isolated from subsequent updates without defensive copying |
| Valor embebido (composición) en nodos | Herencia de clases o tipos abiertos | OCaml favorece tipos de registro algebraicos sobre jerarquías de clases orientadas a objetos; la especificación autoriza explícitamente el valor embebido (`value : int` y `label : int`) / OCaml favors algebraic record types over object-oriented class hierarchies; the specification explicitly authorizes embedded values (`value : int` and `label : int`) |
| Ausencia con `option` (`None`/`Some`) | Excepciones o centinelas como `-1` | La ausencia de enlace o la inexistencia de un vértice es un flujo esperado; `option` es seguro en tipos y no introduce efectos secundarios / Link absence or unregistered vertex is an expected flow; `option` is type-safe and introduces no side-effects |
| Registro canónico manual enlazado y adyacencia manual | `Map`, `Set` o tablas hash de biblioteca | La especificación prohíbe explícitamente delegar el registro de vértices o la adyacencia en colecciones de biblioteca; se implementó una lista enlazada canónica y un algoritmo manual de inserción ordenada `insert_sorted` / The specification explicitly forbids delegating the vertex registry or adjacency to library collections; a canonical linked list and a manual sorted insertion algorithm `insert_sorted` were implemented |

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `Node` base (`init(value)`, `get_value()`) | Valor embebido en `TreeNode` y `graph_node` | OCaml no utiliza herencia basada en clases para registros funcionales; la especificación autoriza la reutilización mediante valor embebido / OCaml does not use class-based inheritance for functional records; the specification authorizes embedded value reuse |
| Constructores `init()` e `init(value)` | `create ()` y `create value` | `create` es la convención idiomática de nombres para constructores en OCaml / `create` is OCaml's idiomatic constructor naming convention |
| `set_left(node)` y `set_right(node)` mutantes | `with_left node link` y `with_right node link` devolviendo nuevo `TreeNode.t` | Variante inmutable; permite actualizar enlaces generando un nuevo nodo sin mutar el nodo original / Immutable variant; allows updating links producing a new node without mutating the original node |
| `add_edge(u, v)` con indicador de fallo | Devuelve tupla `(bool, Graph.t)` | Comunica éxito o fallo de forma pura junto con el nuevo estado del grafo sin recurrir a excepciones / Communicates success or failure purely alongside the new graph state without resorting to exceptions |
| `get_neighbors(u)` con fallo si `u` falta | Devuelve `int list option`: `None` si falta, `Some []` si aislado | Distingue de manera inequívoca entre vértice ausente (`None`) y vértice existente sin aristas salientes (`Some []`) / Unambiguously distinguishes missing vertex (`None`) from existing vertex with no outgoing edges (`Some []`) |
| `LinkedList<T>` de biblioteca para adyacencia | `int list` nativa con inserción ordenada manual | La lista enlazada inmutable de OCaml es la estructura canónica; la búsqueda e inserción ordenada se escriben a mano sin funciones de ordenación de biblioteca / OCaml's native immutable linked list is the canonical structure; lookup and sorted insertion are written manually without library sorting |
| Layout en `src/` | Layout estándar de Dune en `lib/`, `bin/`, `test/` | Convención estándar del ecosistema OCaml para proyectos compilados con Dune / Standard OCaml ecosystem convention for Dune-built projects |

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `TreeNode.left` | Enlace izquierdo ausente | `None` | `TreeNode.left node` devuelve `None` |
| `TreeNode.right` | Enlace derecho ausente | `None` | `TreeNode.right node` devuelve `None` |
| `BinaryTree.contains` | Valor ausente en el árbol | `false` | `BinaryTree.contains tree 99` devuelve `false` |
| `Graph.add_edge` | Extremo `u` o `v` no registrado | `(false, graph)` | `Graph.add_edge graph 10 99` devuelve `(false, graph)` sin mutar |
| `Graph.has_edge` | Arista ausente o extremo no registrado | `false` | `Graph.has_edge graph 10 99` devuelve `false` |
| `Graph.get_neighbors` | Vértice `u` no registrado | `None` | `Graph.get_neighbors graph 99` devuelve `None` |

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| **TreeNode**: Crear un nodo de árbol / Create a tree node | Sí | `test/test_data_structures_advanced.ml:tree_node_cases` (0) | `TreeNode` (inmutable) → `tree_node_cases` → Alcotest / Dune |
| **TreeNode**: Enlaces iniciales ausentes / Absent initial links | Sí | `test/test_data_structures_advanced.ml:tree_node_cases` (1) | Comprueba que `left` y `right` son `None` / Checks `left` and `right` are `None` |
| **TreeNode**: Enlazar dos hijos / Link two children | Sí | `test/test_data_structures_advanced.ml:tree_node_cases` (2) | Enlaza hijos 20 y 30 con `with_left` y `with_right` / Links children 20 and 30 with `with_left` and `with_right` |
| **TreeNode**: Recorrer cada enlace / Traverse each link | Sí | `test/test_data_structures_advanced.ml:tree_node_cases` (3) | Recorre enlaces y verifica ausencia de enlaces en hijos / Traverses links and verifies absent child links |
| **TreeNode**: Desenlazar hijos / Unlink children | Sí | `test/test_data_structures_advanced.ml:tree_node_cases` (4) | Desenlaza izquierdo y derecho con `None` / Unlinks left and right with `None` |
| **TreeNode**: Adaptación inmutable / Immutable adaptation | Sí | `test/test_data_structures_advanced.ml:tree_node_cases` (5) | Comprueba que `with_left` no modifica el nodo original / Checks `with_left` does not mutate original node |
| **BinaryTree**: Crear vacío / Create empty | Sí | `test/test_data_structures_advanced.ml:binary_tree_cases` (0) | `BinaryTree` (inmutable) → `binary_tree_cases` → Alcotest / Dune |
| **BinaryTree**: Insertar la raíz / Insert the root | Sí | `test/test_data_structures_advanced.ml:binary_tree_cases` (1) | Inserta 50: tamaño 1, no vacío y pertenencia positiva / Inserts 50: size 1, not empty, positive membership |
| **BinaryTree**: Insertar menor y mayor / Insert lower and higher | Sí | `test/test_data_structures_advanced.ml:binary_tree_cases` (2) | Inserta 50, 30, 70: tamaño 3 y los tres presentes / Inserts 50, 30, 70: size 3 and all present |
| **BinaryTree**: Ramas de varios niveles / Multilevel branches | Sí | `test/test_data_structures_advanced.ml:binary_tree_cases` (3) | Inserta 50, 30, 70, 20, 40: tamaño 5 y todos presentes / Inserts 50, 30, 70, 20, 40: size 5 and all present |
| **BinaryTree**: Valor ausente en árbol no vacío / Missing value in nonempty tree | Sí | `test/test_data_structures_advanced.ml:binary_tree_cases` (4) | `contains 99` devuelve `false`; tamaño se mantiene en 1 / `contains 99` returns `false`; size stays 1 |
| **BinaryTree**: Duplicado idempotente / Idempotent duplicate | Sí | `test/test_data_structures_advanced.ml:binary_tree_cases` (5) | Reinsertar 30 mantiene tamaño 3 y valores / Reinserting 30 preserves size 3 and values |
| **BinaryTree**: Inserciones ordenadas / Ordered insertions | Sí | `test/test_data_structures_advanced.ml:binary_tree_cases` (6) | Inserta 20, 30, 40, 50, 70: tamaño 5 y 99 ausente / Inserts 20, 30, 40, 50, 70: size 5 and 99 absent |
| **Graph**: Crear vacío / Create empty | Sí | `test/test_data_structures_advanced.ml:graph_cases` (0) | `Graph` (inmutable) → `graph_cases` → Alcotest / Dune |
| **Graph**: Vértice aislado / Isolated vertex | Sí | `test/test_data_structures_advanced.ml:graph_cases` (1) | Vértice 10: 1 vértice, 0 aristas y vecinos `Some []` / Vertex 10: 1 vertex, 0 edges and neighbours `Some []` |
| **Graph**: Etiquetas no consecutivas y arista dirigida / Nonconsecutive labels and directed edge | Sí | `test/test_data_structures_advanced.ml:graph_cases` (2) | Arista 10->70: presente en dirección directa y ausente en inversa / Edge 10->70: forward present, reverse absent |
| **Graph**: Vértice duplicado conserva adyacencia / Duplicate vertex preserves adjacency | Sí | `test/test_data_structures_advanced.ml:graph_cases` (3) | Re-registrar 10 mantiene 2 vértices, 1 arista y vecino `[30]` / Re-registering 10 keeps 2 vertices, 1 edge and neighbour `[30]` |
| **Graph**: Arista duplicada / Duplicate edge | Sí | `test/test_data_structures_advanced.ml:graph_cases` (4) | Añadir 10->30 dos veces mantiene 1 arista / Adding 10->30 twice preserves 1 edge |
| **Graph**: Extremo inexistente sin mutación / Missing endpoint without mutation | Sí | `test/test_data_structures_advanced.ml:graph_cases` (5) | Fallos en 4 intentos con extremos ausentes; contadores intactos / Fails 4 attempts with missing endpoints; counts intact |
| **Graph**: Vecinos ordenados y contadores / Sorted neighbours and counts | Sí | `test/test_data_structures_advanced.ml:graph_cases` (6) | Vecinos de 10 son `[30, 50, 70]`; 4 vértices, 4 aristas / Neighbours of 10 are `[30, 50, 70]`; 4 vertices, 4 edges |
| **Graph**: Consulta de arista ausente / Missing-edge query | Sí | `test/test_data_structures_advanced.ml:graph_cases` (7) | `has_edge 10 30` es `false`; 2 vértices, 0 aristas / `has_edge 10 30` is `false`; 2 vertices, 0 edges |
| **Graph**: Vecinos de vértice inexistente / Neighbours of missing vertex | Sí | `test/test_data_structures_advanced.ml:graph_cases` (8) | `get_neighbors 99` devuelve `None`, distinto de `Some []` / `get_neighbors 99` returns `None`, distinct from `Some []` |
| **Graph**: Bucle y duplicado / Self-loop and duplicate | Sí | `test/test_data_structures_advanced.ml:graph_cases` (9) | Arista 10->10 dos veces: 1 vértice, 1 arista, vecinos `[10]` / Edge 10->10 twice: 1 vertex, 1 edge, neighbours `[10]` |
| **Graph**: Aislamiento del resultado de vecinos / Neighbour-result isolation | Sí | `test/test_data_structures_advanced.ml:graph_cases` (10) | Listas inmutables en OCaml; altas posteriores no mutan resultados previos / Immutable lists in OCaml; later additions do not mutate prior results |

**Total de pruebas / Total tests:** 24 tests ejecutados por Alcotest, todos exitosos.

## ⚠️ Limitaciones conocidas / Known limitations

Ninguna / None

**ES:** La implementación cumple todos los criterios de aceptación y complejidades temporales declaradas en la especificación. No se imponen capacidades máximas artificiales ni restricciones en las etiquetas.

**EN:** The implementation satisfies all acceptance criteria and time complexities declared in the specification. No artificial maximum capacities or label constraints are imposed.

## 📝 Notas de implementación / Implementation Notes

**ES:** Se utiliza un diseño funcional e inmutable (V2): árboles y grafos son valores inmutables. En OCaml las listas estándar son listas simplemente enlazadas inmutables, lo que garantiza por definición el aislamiento de los resultados devueltos por `get_neighbors` respecto a operaciones posteriores. El registro de vértices se construye manualmente mediante una lista enlazada canónica de nodos (`graph_node option` con enlace `next_vertex`), y la adyacencia se mantiene ordenada mediante una función de inserción ordenada recursiva manual (`insert_sorted`) que no delega en mapas, conjuntos ni algoritmos de ordenación de biblioteca.

**EN:** A functional and immutable design (V2) is used: trees and graphs are immutable values. In OCaml standard lists are immutable singly linked lists, which by definition guarantees isolation of the results returned by `get_neighbors` with respect to subsequent operations. The vertex registry is manually constructed using a canonical linked list of nodes (`graph_node option` with `next_vertex` link), and adjacency is kept sorted through a manual recursive sorted insertion function (`insert_sorted`) that does not delegate to library maps, sets or sorting algorithms.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`07_Data_Structures_Advanced.md`](../../../../docs/core/algorithms/07_Data_Structures_Advanced.md) |
| Primera base del lenguaje / First language reference | `data_structures_basics` — [`../data_structures_basics/`](../data_structures_basics/) |
| Segunda base del lenguaje / Second language reference | `numbers` — [`../../foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [OCaml Official Documentation](https://ocaml.org/docs) |
