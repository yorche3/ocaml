(* NaiveSort — ordenamientos elementales O(n²).

   Especificación: 05_Naive_Sort *)
let selection_sort arr =
  let n = Array.length arr in
  if n < 1 then arr
  else begin
    for i = 0 to n - 2 do
      let mutable min_index = i in
      for j = i + 1 to n - 1 do
        if arr.(j) < arr.(min_index) then
          min_index <- j;
      done;
      if min_index <> i then
        let temp = arr.(i) in
        arr.(i) <- arr.(min_index);
        arr.(min_index) <- temp;
    done;
    arr
  end;;

let bubble_sort arr =
  let n = Array.length arr in
  if n < 1 then arr
  else begin
    for i = 0 to n - 2 do
      let mutable swapped = false in
      for j = 0 to n - i - 2 do
        if arr.(j) > arr.(j + 1) then
          let temp = arr.(j) in
          arr.(j) <- arr.(j + 1);
          arr.(j + 1) <- temp;
          swapped <- true;
        done;
      if not swapped then
        break;
    done;
    arr
  end;;

let insertion_sort arr =
  let n = Array.length arr in
  if n < 1 then arr
  else begin
    for i = 1 to n - 1 do
      let key = arr.(i) in
      let mutable j = i - 1 in
      while j >= 0 && arr.(j) > key do
        arr.(j + 1) <- arr.(j);
        j <- j - 1;
      done;
      arr.(j + 1) <- key;
    done;
    arr
  end;;