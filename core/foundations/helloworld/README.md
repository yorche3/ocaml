# Hello, World! — OCaml

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **OCaml**, con un enfoque manual y minimalista.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`helloworld.ml`](helloworld.ml) | Código fuente: imprime `"Hello, World! from Ocaml!"` en la salida estándar. |
| `helloworld` | Ejecutable bytecode generado por `ocamlc` (no versionado). |
| `helloworld.native` | Ejecutable nativo generado por `ocamlopt` (no versionado). |
| `*.cmo`, `*.cmi`, `*.cmx` | Artefactos de compilación (ignorados en `.gitignore`). |

**Estructura de directorios esperada:**

```text
helloworld/
├── helloworld.ml         # Código fuente
├── helloworld            # Bytecode ejecutable (generado por ocamlc)
├── helloworld.native     # Ejecutable nativo (generado por ocamlopt)
└── README.md             # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding (dune/opam). Un único archivo `.ml` con una expresión de nivel superior es suficiente para compilar y ejecutar con `ocamlc`/`ocamlopt`, o directamente con el intérprete `ocaml`.

**EN:** The project was created manually, without scaffolding tools (dune/opam). A single `.ml` file with a top-level expression is enough to compile and run with `ocamlc`/`ocamlopt`, or directly with the `ocaml` interpreter.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p ocaml/core/foundations/helloworld
   ```

2. Escribir el archivo `helloworld.ml` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El compilador (`ocamlc`/`ocamlopt`) y el intérprete (`ocaml`) se invocan directamente desde línea de comandos.

```ocaml
let () = print_endline "Hello, World! from Ocaml!"
```

| Elemento | Propósito |
|----------|-----------|
| `let () = ...` | Expresión de nivel superior que ejecuta la función por su efecto secundario; `()` es el tipo `unit`. |
| `print_endline "..."` | Imprime la cadena en la salida estándar y añade un salto de línea al final. |

> **ES:** `print_endline` añade `\n` automáticamente; su alternativa `print_string` no lo hace. Para ejecutar una función al nivel superior (fuera de una función), se vincula su resultado `unit` a `()`.
> **EN:** `print_endline` appends `\n` automatically; its counterpart `print_string` does not. To run a function at top level (outside a function), its `unit` result is bound to `()`.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener OCaml instalado

```bash
# Verificar instalación (vía switch de opam)
ocaml --version
ocamlc --version
```

### Ejecutar con el intérprete / Run with the interpreter

```bash
cd ocaml/core/foundations/helloworld
ocaml helloworld.ml
```

### Compilar a bytecode y ejecutar / Compile to bytecode & run

```bash
cd ocaml/core/foundations/helloworld
ocamlc helloworld.ml -o helloworld
./helloworld
```

### Compilar a código nativo y ejecutar / Compile to native code & run

```bash
cd ocaml/core/foundations/helloworld
ocamlopt helloworld.ml -o helloworld.native
./helloworld.native
```

### Salida esperada / Expected output

```text
Hello, World! from Ocaml!
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** OCaml no exige una función `main`: las expresiones de nivel superior se evalúan al arrancar el programa.
- **EN:** OCaml does not require a `main` function: top-level expressions are evaluated at program startup.
- **ES:** `ocamlc` produce bytecode (portátil, requiere el runtime `ocamlrun`); `ocamlopt` produce binario nativo (más rápido, sin runtime externo).
- **EN:** `ocamlc` produces bytecode (portable, requires the `ocamlrun` runtime); `ocamlopt` produces a native binary (faster, no external runtime).

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
