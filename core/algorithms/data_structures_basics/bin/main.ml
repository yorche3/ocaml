(* Punto de entrada de demostración del módulo Data_structures_basics.
   Recorre las cuatro estructuras con valores de ejemplo y muestra el
   indicador de fallo (-1) al consultar estructuras vacías.
   Uso: dune exec data_structures_basics *)

open Data_structures_basics

let () =
  let node = Node.create 10 in
  Printf.printf "Node.value = %d\n" (Node.value node);

  let list = LinkedList.create () in
  LinkedList.insert_tail list 10;
  LinkedList.insert_head list 5;
  Printf.printf "LinkedList: head = %d, length = %d\n"
    (LinkedList.head list) (LinkedList.length list);
  let deleted = LinkedList.delete list 10 in
  Printf.printf "LinkedList.delete 10 = %b\n" deleted;

  let stack = Stack.create () in
  Stack.push stack 10;
  Stack.push stack 20;
  let top = Stack.peek stack in
  Printf.printf "Stack: peek = %d\n" top;
  let first = Stack.pop stack in
  let second = Stack.pop stack in
  let empty = Stack.pop stack in
  Printf.printf "Stack: pop = %d, pop = %d, pop (vacía) = %d\n" first second
    empty;

  let queue = Queue.create () in
  Queue.enqueue queue 10;
  Queue.enqueue queue 20;
  let front = Queue.peek queue in
  Printf.printf "Queue: peek = %d\n" front;
  let a = Queue.dequeue queue in
  let b = Queue.dequeue queue in
  let c = Queue.dequeue queue in
  Printf.printf "Queue: dequeue = %d, dequeue = %d, dequeue (vacía) = %d\n" a b c
