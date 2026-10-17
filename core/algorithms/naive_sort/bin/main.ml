(* Punto de entrada de demostración del módulo Naive_sort.
   Ejecuta los tres algoritmos con un arreglo de ejemplo y muestra el resultado.
   Uso: dune exec naive_sort *)

let show name result =
  Printf.printf "%s = [%s]\n" name
    (String.concat "; " (Array.to_list (Array.map string_of_int result)))

let () =
  let input = [| 5; 2; 9; 1; 5; 6 |] in
  show "selection_sort" (Naive_sort.selection_sort (Array.copy input));
  show "bubble_sort" (Naive_sort.bubble_sort (Array.copy input));
  show "insertion_sort" (Naive_sort.insertion_sort (Array.copy input))
