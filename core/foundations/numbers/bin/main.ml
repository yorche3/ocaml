(* Punto de entrada de demostración del módulo Numbers.
   Ejecuta los cinco algoritmos en su variante iterativa con valores de
   ejemplo y muestra el resultado.
   Uso: dune exec numbers *)

let () =
  Printf.printf "sum_of_first_n_ite 5 = %d\n" (Numbers.sum_of_first_n_ite 5);
  Printf.printf "factorial_ite 5 = %d\n" (Numbers.factorial_ite 5);
  Printf.printf "fibonacci_ite 10 = %d\n" (Numbers.fibonacci_ite 10);
  Printf.printf "greatest_common_divisor_ite 12 8 = %d\n"
    (Numbers.greatest_common_divisor_ite 12 8);
  Printf.printf "least_common_multiple_ite 4 6 = %d\n"
    (Numbers.least_common_multiple_ite 4 6)
