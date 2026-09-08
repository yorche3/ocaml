(* Direct recursion (_rec) *)

let rec sum_of_first_n_rec n =
  if n <= 0 then 0
  else n + sum_of_first_n_rec (n - 1)

let rec factorial_rec n =
  if n <= 0 then 1
  else n * factorial_rec (n - 1)

let rec fibonacci_rec n =
  if n <= 1 then n
  else fibonacci_rec (n - 1) + fibonacci_rec (n - 2)

let rec greatest_common_divisor_rec a b =
  if b = 0 then a
  else greatest_common_divisor_rec b (a mod b)

let least_common_multiple_rec a b =
  (a * b) / greatest_common_divisor_rec a b

(* Accumulator recursion (_acc) *)

let rec sum_of_first_n_acc_help n acc =
  if n <= 0 then acc
  else sum_of_first_n_acc_help (n - 1) (n + acc)

let sum_of_first_n_acc n =
  sum_of_first_n_acc_help n 0

let rec factorial_acc_help n acc =
  if n <= 1 then acc
  else factorial_acc_help (n - 1) (n * acc)

let factorial_acc n =
  factorial_acc_help n 1

let rec fibonacci_acc_help n acc2 acc1 =
  if n <= 0 then acc2
  else if n <= 2 then acc1 + acc2
  else fibonacci_acc_help (n - 1) acc1 (acc1 + acc2)

let fibonacci_acc n =
  fibonacci_acc_help n 0 1

let rec greatest_common_divisor_acc_help a b =
  if b = 0 then a
  else greatest_common_divisor_acc_help b (a mod b)

let greatest_common_divisor_acc a b =
  greatest_common_divisor_acc_help a b

let least_common_multiple_acc a b =
  (a * b) / greatest_common_divisor_acc a b

(* Iterative (_ite) *)

let sum_of_first_n_ite n =
  let result = ref 0 in
  for i = 1 to n do
    result := !result + i
  done;
  !result

let factorial_ite n =
  let result = ref 1 in
  for i = 2 to n do
    result := !result * i
  done;
  !result

let fibonacci_ite n =
  if n <= 1 then n
  else begin
    let acc2 = ref 0 in
    let acc1 = ref 1 in
    for _ = 2 to n do
      let temp = !acc1 + !acc2 in
      acc2 := !acc1;
      acc1 := temp
    done;
    !acc1
  end

let greatest_common_divisor_ite a b =
  let x = ref a in
  let y = ref b in
  while !y <> 0 do
    let temp = !y in
    y := !x mod !y;
    x := temp
  done;
  !x

let least_common_multiple_ite a b =
  (a * b) / greatest_common_divisor_ite a b
