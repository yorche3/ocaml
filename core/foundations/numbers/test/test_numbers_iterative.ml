let () =
  let open Alcotest in
  run "numbers iterative"
    [
      ( "iterative",
        [
          test_case "sum_of_first_n_ite" `Quick (fun () ->
              check int "n=0" 0 (Numbers.sum_of_first_n_ite 0);
              check int "n=3" 6 (Numbers.sum_of_first_n_ite 3));
          test_case "factorial_ite" `Quick (fun () ->
              check int "n=0" 1 (Numbers.factorial_ite 0);
              check int "n=4" 24 (Numbers.factorial_ite 4));
          test_case "fibonacci_ite" `Quick (fun () ->
              check int "n=0" 0 (Numbers.fibonacci_ite 0);
              check int "n=1" 1 (Numbers.fibonacci_ite 1);
              check int "n=6" 8 (Numbers.fibonacci_ite 6));
          test_case "greatest_common_divisor_ite" `Quick (fun () ->
              check int "(12,8)" 4 (Numbers.greatest_common_divisor_ite 12 8);
              check int "(7,5)" 1 (Numbers.greatest_common_divisor_ite 7 5));
          test_case "least_common_multiple_ite" `Quick (fun () ->
              check int "(4,6)" 12 (Numbers.least_common_multiple_ite 4 6);
              check int "(6,8)" 24 (Numbers.least_common_multiple_ite 6 8));
        ] );
    ]
