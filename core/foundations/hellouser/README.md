# Hello, User! — OCaml

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **OCaml**, con un enfoque manual y minimalista.

Lee un nombre desde la entrada estándar y saluda al usuario.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hellouser.ml`](hellouser.ml) | Código fuente: solicita un nombre al usuario y saluda. |
| `hellouser` | Ejecutable bytecode generado por `ocamlc` (no versionado). |
| `hellouser.native` | Ejecutable nativo generado por `ocamlopt` (no versionado). |
| `*.cmo`, `*.cmi`, `*.cmx` | Artefactos de compilación (ignorados en `.gitignore`). |

**Estructura de directorios esperada:**

```text
hellouser/
├── hellouser.ml          # Código fuente
├── hellouser             # Bytecode ejecutable (generado por ocamlc)
├── hellouser.native      # Ejecutable nativo (generado por ocamlopt)
└── README.md             # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este programa introduce tres conceptos nuevos respecto a `helloworld`:

1. **Escritura sin salto de línea** — `print_string` imprime el prompt dejando el cursor en la misma línea.
2. **Entrada de usuario** — `read_line ()` lee una línea desde la entrada estándar.
3. **Formato de cadenas** — `Printf.printf` imprime una cadena con formato (`%s` para el nombre).

**EN:** This program introduces three new concepts compared to `helloworld`:

1. **Writing without newline** — `print_string` prints the prompt leaving the cursor on the same line.
2. **User input** — `read_line ()` reads a line from standard input.
3. **String formatting** — `Printf.printf` prints a formatted string (`%s` for the name).

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p ocaml/core/foundations/hellouser
   ```

2. Escribir el archivo `hellouser.ml` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El compilador (`ocamlc`/`ocamlopt`) y el intérprete (`ocaml`) se invocan directamente desde línea de comandos.

**ES:** El flujo del programa es:

1. Imprimir `"Enter your name: "` con `print_string` (sin salto de línea).
2. Leer una línea desde `stdin` con `read_line ()`.
3. Imprimir `"Hello, <nombre>!"` con `Printf.printf` usando el formato `%s`.

**EN:** Program flow:

1. Print `"Enter your name: "` with `print_string` (no newline).
2. Read a line from `stdin` with `read_line ()`.
3. Print `"Hello, <name>!"` with `Printf.printf` using the `%s` format.

```ocaml
let () = print_string "Enter your name: "
let name = read_line ()
let () = Printf.printf "Hello, %s!\n" name
```

| Elemento | Propósito |
|----------|-----------|
| `print_string "..."` | Imprime en la salida estándar **sin** salto de línea al final (el cursor permanece junto al prompt). |
| `read_line ()` | Lee una línea desde la entrada estándar (sin el salto de línea final) y la devuelve como `string`. |
| `let name = ...` | Vinculación inmutable: `name` es un `string` que no se puede reasignar. |
| `Printf.printf "%s" name` | Imprime con formato; `%s` inserta la cadena y `\n` añade el salto de línea. |

> **ES:** A diferencia de `print_endline`, `print_string` no añade `\n`, por lo que es la opción correcta para el prompt. `Printf.printf` sí permite controlar el salto de línea con `\n` en el formato.
> **EN:** Unlike `print_endline`, `print_string` does not append `\n`, making it the right choice for the prompt. `Printf.printf` lets you control the newline with `\n` in the format.

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
cd ocaml/core/foundations/hellouser
ocaml hellouser.ml
```

### Compilar a bytecode y ejecutar / Compile to bytecode & run

```bash
cd ocaml/core/foundations/hellouser
ocamlc hellouser.ml -o hellouser
./hellouser
```

### Compilar a código nativo y ejecutar / Compile to native code & run

```bash
cd ocaml/core/foundations/hellouser
ocamlopt hellouser.ml -o hellouser.native
./hellouser.native
```

### Salida esperada / Expected output

```text
Enter your name: Ada
Hello, Ada!
```

> **ES:** El programa espera a que el usuario escriba su nombre y presione Enter antes de mostrar el saludo.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** OCaml no exige una función `main`: las expresiones de nivel superior se evalúan en orden al arrancar el programa.
- **EN:** OCaml does not require a `main` function: top-level expressions are evaluated in order at program startup.
- **ES:** Las vinculaciones (`let`) son inmutables: `name` no puede reasignarse después de leerla.
- **EN:** Bindings (`let`) are immutable: `name` cannot be reassigned after being read.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
