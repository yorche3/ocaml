(* NaiveSort — ordenamientos elementales O(n²).

   Especificación: 05_Naive_Sort *)

let selection_sort arr =
  let n = Array.length arr in
  if n <= 1 then arr
  else begin
    for i = 0 to n - 2 do
      let min_index = ref i in
      for j = i + 1 to n - 1 do
        if arr.(j) < arr.(!min_index) then min_index := j
      done;
      if !min_index <> i then begin
        let temp = arr.(i) in
        arr.(i) <- arr.(!min_index);
        arr.(!min_index) <- temp
      end
    done;
    arr
  end

let bubble_sort arr =
  let n = Array.length arr in
  if n <= 1 then arr
  else begin
    let swapped = ref true in
    let i = ref 0 in
    while !i < n - 1 && !swapped do
      swapped := false;
      for j = 0 to n - 2 - !i do
        if arr.(j) > arr.(j + 1) then begin
          let temp = arr.(j) in
          arr.(j) <- arr.(j + 1);
          arr.(j + 1) <- temp;
          swapped := true
        end
      done;
      incr i
    done;
    arr
  end

let insertion_sort arr =
  let n = Array.length arr in
  if n <= 1 then arr
  else begin
    for i = 1 to n - 1 do
      let key = arr.(i) in
      let j = ref (i - 1) in
      while !j >= 0 && arr.(!j) > key do
        arr.(!j + 1) <- arr.(!j);
        decr j
      done;
      arr.(!j + 1) <- key
    done;
    arr
  end
