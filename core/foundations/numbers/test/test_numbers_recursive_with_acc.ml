let () =
  let open Alcotest in
  run "numbers recursive_with_accumulator"
    [
      ( "recursive_with_accumulator",
        [
          test_case "sum_of_first_n_acc" `Quick (fun () ->
              check int "n=0" 0 (Numbers.sum_of_first_n_acc 0);
              check int "n=3" 6 (Numbers.sum_of_first_n_acc 3));
          test_case "factorial_acc" `Quick (fun () ->
              check int "n=0" 1 (Numbers.factorial_acc 0);
              check int "n=4" 24 (Numbers.factorial_acc 4));
          test_case "fibonacci_acc" `Quick (fun () ->
              check int "n=0" 0 (Numbers.fibonacci_acc 0);
              check int "n=1" 1 (Numbers.fibonacci_acc 1);
              check int "n=6" 8 (Numbers.fibonacci_acc 6));
          test_case "greatest_common_divisor_acc" `Quick (fun () ->
              check int "(12,8)" 4 (Numbers.greatest_common_divisor_acc 12 8);
              check int "(7,5)" 1 (Numbers.greatest_common_divisor_acc 7 5));
          test_case "least_common_multiple_acc" `Quick (fun () ->
              check int "(4,6)" 12 (Numbers.least_common_multiple_acc 4 6);
              check int "(6,8)" 24 (Numbers.least_common_multiple_acc 6 8));
        ] );
    ]
