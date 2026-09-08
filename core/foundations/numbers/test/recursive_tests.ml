let () =
  let open Alcotest in
  run "numbers recursive"
    [
      ( "recursive",
        [
          test_case "sum_of_first_n_rec" `Quick (fun () ->
              check int "n=0" 0 (Numbers.sum_of_first_n_rec 0);
              check int "n=3" 6 (Numbers.sum_of_first_n_rec 3));
          test_case "factorial_rec" `Quick (fun () ->
              check int "n=0" 1 (Numbers.factorial_rec 0);
              check int "n=4" 24 (Numbers.factorial_rec 4));
          test_case "fibonacci_rec" `Quick (fun () ->
              check int "n=0" 0 (Numbers.fibonacci_rec 0);
              check int "n=1" 1 (Numbers.fibonacci_rec 1);
              check int "n=6" 8 (Numbers.fibonacci_rec 6));
          test_case "greatest_common_divisor_rec" `Quick (fun () ->
              check int "(12,8)" 4 (Numbers.greatest_common_divisor_rec 12 8);
              check int "(7,5)" 1 (Numbers.greatest_common_divisor_rec 7 5));
          test_case "least_common_multiple_rec" `Quick (fun () ->
              check int "(4,6)" 12 (Numbers.least_common_multiple_rec 4 6);
              check int "(6,8)" 24 (Numbers.least_common_multiple_rec 6 8));
        ] );
    ]
