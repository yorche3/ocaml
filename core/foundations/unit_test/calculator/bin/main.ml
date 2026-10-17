(* Punto de entrada de demostración del módulo Calculator.
   Ejecuta las cinco operaciones con valores de ejemplo y muestra el resultado.
   Uso: dune exec calculator *)

let () =
  Printf.printf "addition(2, 3) = %d\n" (Calculator.addition 2 3);
  Printf.printf "subtraction(5, 2) = %d\n" (Calculator.subtraction 5 2);
  Printf.printf "multiplication(3, 4) = %d\n" (Calculator.multiplication 3 4);
  Printf.printf "division(10, 3) = %d\n" (Calculator.division 10 3);
  Printf.printf "modulus(10, 3) = %d\n" (Calculator.modulus 10 3)
