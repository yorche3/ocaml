let () =
  let open Alcotest in
  run "calculator"
    [
      ( "calculator",
        [
          test_case "addition(2, 3) returns 5" `Quick (fun () ->
              check int "addition" 5 (Calculator.addition 2 3));
          test_case "subtraction(5, 2) returns 3" `Quick (fun () ->
              check int "subtraction" 3 (Calculator.subtraction 5 2));
          test_case "multiplication(3, 4) returns 12" `Quick (fun () ->
              check int "multiplication" 12 (Calculator.multiplication 3 4));
          test_case "division(10, 3) returns 3" `Quick (fun () ->
              check int "division" 3 (Calculator.division 10 3));
          test_case "modulus(10, 3) returns 1" `Quick (fun () ->
              check int "modulus" 1 (Calculator.modulus 10 3));
        ] );
    ]
