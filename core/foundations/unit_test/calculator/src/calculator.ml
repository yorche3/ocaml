let addition a b = a + b

let subtraction a b = a - b

let multiplication a b =
  let result = ref 0 in
  for _ = 1 to b do
    result := addition !result a
  done;
  !result

let division a b =
  let remaining = ref a in
  let quotient = ref 0 in
  while !remaining >= b do
    remaining := subtraction !remaining b;
    quotient := addition !quotient 1
  done;
  !quotient

let modulus a b =
  let q = division a b in
  let p = multiplication q b in
  subtraction a p
