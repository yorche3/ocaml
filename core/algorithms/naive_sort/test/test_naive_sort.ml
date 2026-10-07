(* Casos de prueba de la especificación 05_Naive_Sort.md

   Caso nulo omitido: OCaml no tiene `null`/`nil` para `int array` y esta fase
   todavía no usa `option` como indicador de fallo, así que una entrada nula no
   es representable en la firma y no hay indicador que comprobar. Se conservan
   los 7 casos de la especificación. *)

let standard_input = [| 5; 2; 9; 1; 5; 6 |]
let standard_output = [| 1; 2; 5; 5; 6; 9 |]

let sorted_input = [| 1; 2; 3; 4; 5 |]
let sorted_output = [| 1; 2; 3; 4; 5 |]

let reverse_input = [| 5; 4; 3; 2; 1 |]
let reverse_output = [| 1; 2; 3; 4; 5 |]

let identical_input = [| 7; 7; 7; 7 |]
let identical_output = [| 7; 7; 7; 7 |]

let negative_input = [| 3; -1; 4; -5; 0 |]
let negative_output = [| -5; -1; 0; 3; 4 |]

let single_input = [| 42 |]
let single_output = [| 42 |]

let empty_input : int array = [||]
let empty_output : int array = [||]

type sort_case = {
  description : string;
  input : int array;
  expected : int array;
}

let cases =
  [
    { description = "an unsorted array"; input = standard_input; expected = standard_output };
    { description = "an already sorted array"; input = sorted_input; expected = sorted_output };
    { description = "a reverse ordered array"; input = reverse_input; expected = reverse_output };
    {
      description = "an array of identical elements";
      input = identical_input;
      expected = identical_output;
    };
    {
      description = "an array with negative numbers";
      input = negative_input;
      expected = negative_output;
    };
    { description = "a single element array"; input = single_input; expected = single_output };
    { description = "an empty array"; input = empty_input; expected = empty_output };
  ]

(* Helper compartido: recibe la función a probar y el nombre del algoritmo, y
   ejecuta todos los casos con un mensaje descriptivo cada uno.

   Cada caso ordena una copia del fixture (`Array.copy`), porque los tres
   algoritmos ordenan in-place y los arrays de OCaml son mutables. *)
let assert_sorts_all_cases sort algorithm =
  List.iter
    (fun case ->
      Alcotest.check
        (Alcotest.array Alcotest.int)
        (algorithm ^ " should sort " ^ case.description)
        case.expected
        (sort (Array.copy case.input)))
    cases

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
