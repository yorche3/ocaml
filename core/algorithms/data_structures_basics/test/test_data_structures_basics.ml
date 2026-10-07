(* Casos de prueba de la especificación 06_Data_Structures_Basics.md.

   Adaptación de tipo: OCaml representa enlaces y lecturas fallibles con
   [option]; [None] es el indicador de ausencia. Los casos son pasos
   sucesivos sobre una instancia mutable y cada test crea su propia instancia. *)

let node_initial_input = 10
let node_initial_value_output = 10
let node_linked_input = 20
let node_linked_value_output = 20

let list_tail_first_input = 10
let list_tail_second_input = 20
let list_head_input = 5
let list_tail_duplicate_input = 10
let list_initial_size_output = 0
let list_populated_size_output = 4
let list_after_delete_size_output = 3
let list_empty_size_output = 0
let list_absent_input = 99

let stack_first_input = 10
let stack_second_input = 20
let stack_third_input = 30
let stack_reused_input = 40
let stack_populated_size_output = 3
let stack_empty_size_output = 0

let queue_first_input = 10
let queue_second_input = 20
let queue_third_input = 30
let queue_reused_input = 40
let queue_populated_size_output = 3
let queue_empty_size_output = 0

type test_case = {
  description : string;
  verify : unit -> unit;
}

let run_cases _subject cases =
  List.iter
    (fun { description = _; verify } -> verify ())
    cases

let node_cases () =
  let a = Data_structures_basics.Node.create node_initial_input in
  let b = Data_structures_basics.Node.create node_linked_input in
  [
    {
      description = "initialize and observe value/link";
      verify =
        (fun () ->
          Alcotest.check Alcotest.int
            "Node should retain its initialized value"
            node_initial_value_output
            (Data_structures_basics.Node.value a);
          Alcotest.check (Alcotest.option Alcotest.int)
            "Node should have no link after initialization"
            None
            (Option.map Data_structures_basics.Node.value
               (Data_structures_basics.Node.next a)));
    };
    {
      description = "initialize another node, link and traverse";
      verify =
        (fun () ->
          Data_structures_basics.Node.set_next a (Some b);
          Alcotest.check (Alcotest.option Alcotest.int)
            "Node should expose the linked node value"
            (Some node_linked_value_output)
            (Option.map Data_structures_basics.Node.value
               (Data_structures_basics.Node.next a));
          Alcotest.check (Alcotest.option Alcotest.int)
            "Node should leave the linked node without a successor"
            None
            (Option.map Data_structures_basics.Node.value
               (Data_structures_basics.Node.next b)));
    };
  ]

let linked_list_cases () =
  let list = Data_structures_basics.LinkedList.create () in
  [
    {
      description = "empty state";
      verify =
        (fun () ->
          Alcotest.check Alcotest.bool
            "LinkedList should be empty after initialization"
            true
            (Data_structures_basics.LinkedList.is_empty list);
          Alcotest.check Alcotest.int
            "LinkedList should have size zero after initialization"
            list_initial_size_output
            (Data_structures_basics.LinkedList.length list);
          Alcotest.check (Alcotest.option Alcotest.int)
            "LinkedList should return None for an empty head"
            None
            (Data_structures_basics.LinkedList.head list));
    };
    {
      description = "insert at both ends";
      verify =
        (fun () ->
          Data_structures_basics.LinkedList.insert_tail list list_tail_first_input;
          Data_structures_basics.LinkedList.insert_tail list list_tail_second_input;
          Data_structures_basics.LinkedList.insert_head list list_head_input;
          Data_structures_basics.LinkedList.insert_tail list list_tail_duplicate_input;
          Alcotest.check Alcotest.int
            "LinkedList should contain all inserted values"
            list_populated_size_output
            (Data_structures_basics.LinkedList.length list);
          Alcotest.check (Alcotest.option Alcotest.int)
            "LinkedList should expose the head insertion first"
            (Some list_head_input)
            (Data_structures_basics.LinkedList.head list));
    };
    {
      description = "delete first occurrence";
      verify =
        (fun () ->
          Alcotest.check Alcotest.bool
            "LinkedList should delete the first matching value"
            true
            (Data_structures_basics.LinkedList.delete list list_tail_first_input);
          Alcotest.check Alcotest.int
            "LinkedList should reduce size after deletion"
            list_after_delete_size_output
            (Data_structures_basics.LinkedList.length list);
          Alcotest.check (Alcotest.option Alcotest.int)
            "LinkedList should preserve its head when deleting a later value"
            (Some list_head_input)
            (Data_structures_basics.LinkedList.head list));
    };
    {
      description = "absent value";
      verify =
        (fun () ->
          Alcotest.check Alcotest.bool
            "LinkedList should report failure for an absent value"
            false
            (Data_structures_basics.LinkedList.delete list list_absent_input);
          Alcotest.check Alcotest.int
            "LinkedList should preserve size after failed deletion"
            list_after_delete_size_output
            (Data_structures_basics.LinkedList.length list));
    };
    {
      description = "empty the list";
      verify =
        (fun () ->
          Alcotest.check Alcotest.bool
            "LinkedList should delete its head"
            true
            (Data_structures_basics.LinkedList.delete list list_head_input);
          Alcotest.check Alcotest.bool
            "LinkedList should delete its middle value"
            true
            (Data_structures_basics.LinkedList.delete list list_tail_second_input);
          Alcotest.check Alcotest.bool
            "LinkedList should delete its final value"
            true
            (Data_structures_basics.LinkedList.delete list list_tail_duplicate_input);
          Alcotest.check Alcotest.bool
            "LinkedList should be empty after all values are deleted"
            true
            (Data_structures_basics.LinkedList.is_empty list);
          Alcotest.check Alcotest.int
            "LinkedList should have size zero after all values are deleted"
            list_empty_size_output
            (Data_structures_basics.LinkedList.length list);
          Alcotest.check (Alcotest.option Alcotest.int)
            "LinkedList should return None after all values are deleted"
            None
            (Data_structures_basics.LinkedList.head list));
    };
  ]

let stack_cases () =
  let stack = Data_structures_basics.Stack.create () in
  [
    {
      description = "empty state and failed removal";
      verify =
        (fun () ->
          Alcotest.check Alcotest.bool
            "Stack should be empty after initialization"
            true
            (Data_structures_basics.Stack.is_empty stack);
          Alcotest.check Alcotest.int
            "Stack should have size zero after initialization"
            stack_empty_size_output
            (Data_structures_basics.Stack.length stack);
          Alcotest.check (Alcotest.option Alcotest.int)
            "Stack should return None when peeking while empty"
            None
            (Data_structures_basics.Stack.peek stack);
          Alcotest.check (Alcotest.option Alcotest.int)
            "Stack should return None when popping while empty"
            None
            (Data_structures_basics.Stack.pop stack));
    };
    {
      description = "LIFO and non-mutating peek";
      verify =
        (fun () ->
          Data_structures_basics.Stack.push stack stack_first_input;
          Data_structures_basics.Stack.push stack stack_second_input;
          Data_structures_basics.Stack.push stack stack_third_input;
          Alcotest.check (Alcotest.option Alcotest.int)
            "Stack should peek at the most recently pushed value"
            (Some stack_third_input)
            (Data_structures_basics.Stack.peek stack);
          Alcotest.check Alcotest.int
            "Stack should preserve size when peeking"
            stack_populated_size_output
            (Data_structures_basics.Stack.length stack));
    };
    {
      description = "removal and reuse";
      verify =
        (fun () ->
          Alcotest.check (Alcotest.option Alcotest.int)
            "Stack should pop in LIFO order"
            (Some stack_third_input)
            (Data_structures_basics.Stack.pop stack);
          Data_structures_basics.Stack.push stack stack_reused_input;
          Alcotest.check (Alcotest.option Alcotest.int)
            "Stack should pop the reused value first"
            (Some stack_reused_input)
            (Data_structures_basics.Stack.pop stack);
          Alcotest.check (Alcotest.option Alcotest.int)
            "Stack should retain the next LIFO value"
            (Some stack_second_input)
            (Data_structures_basics.Stack.pop stack);
          Alcotest.check (Alcotest.option Alcotest.int)
            "Stack should retain the oldest value last"
            (Some stack_first_input)
            (Data_structures_basics.Stack.pop stack);
          Alcotest.check Alcotest.bool
            "Stack should be empty after all values are popped"
            true
            (Data_structures_basics.Stack.is_empty stack);
          Alcotest.check Alcotest.int
            "Stack should have size zero after all values are popped"
            stack_empty_size_output
            (Data_structures_basics.Stack.length stack));
    };
    {
      description = "empty after removal";
      verify =
        (fun () ->
          Alcotest.check (Alcotest.option Alcotest.int)
            "Stack should return None after all values are popped"
            None
            (Data_structures_basics.Stack.pop stack);
          Alcotest.check Alcotest.bool
            "Stack should remain empty after a failed pop"
            true
            (Data_structures_basics.Stack.is_empty stack));
    };
  ]

let queue_cases () =
  let queue = Data_structures_basics.Queue.create () in
  [
    {
      description = "empty state and failed removal";
      verify =
        (fun () ->
          Alcotest.check Alcotest.bool
            "Queue should be empty after initialization"
            true
            (Data_structures_basics.Queue.is_empty queue);
          Alcotest.check Alcotest.int
            "Queue should have size zero after initialization"
            queue_empty_size_output
            (Data_structures_basics.Queue.length queue);
          Alcotest.check (Alcotest.option Alcotest.int)
            "Queue should return None when peeking while empty"
            None
            (Data_structures_basics.Queue.peek queue);
          Alcotest.check (Alcotest.option Alcotest.int)
            "Queue should return None when dequeuing while empty"
            None
            (Data_structures_basics.Queue.dequeue queue));
    };
    {
      description = "FIFO and non-mutating peek";
      verify =
        (fun () ->
          Data_structures_basics.Queue.enqueue queue queue_first_input;
          Data_structures_basics.Queue.enqueue queue queue_second_input;
          Data_structures_basics.Queue.enqueue queue queue_third_input;
          Alcotest.check (Alcotest.option Alcotest.int)
            "Queue should peek at the earliest enqueued value"
            (Some queue_first_input)
            (Data_structures_basics.Queue.peek queue);
          Alcotest.check Alcotest.int
            "Queue should preserve size when peeking"
            queue_populated_size_output
            (Data_structures_basics.Queue.length queue));
    };
    {
      description = "removal and reuse";
      verify =
        (fun () ->
          Alcotest.check (Alcotest.option Alcotest.int)
            "Queue should dequeue in FIFO order"
            (Some queue_first_input)
            (Data_structures_basics.Queue.dequeue queue);
          Data_structures_basics.Queue.enqueue queue queue_reused_input;
          Alcotest.check (Alcotest.option Alcotest.int)
            "Queue should retain the second enqueued value"
            (Some queue_second_input)
            (Data_structures_basics.Queue.dequeue queue);
          Alcotest.check (Alcotest.option Alcotest.int)
            "Queue should retain the third enqueued value"
            (Some queue_third_input)
            (Data_structures_basics.Queue.dequeue queue);
          Alcotest.check (Alcotest.option Alcotest.int)
            "Queue should dequeue the reused value last"
            (Some queue_reused_input)
            (Data_structures_basics.Queue.dequeue queue);
          Alcotest.check Alcotest.bool
            "Queue should be empty after all values are dequeued"
            true
            (Data_structures_basics.Queue.is_empty queue);
          Alcotest.check Alcotest.int
            "Queue should have size zero after all values are dequeued"
            queue_empty_size_output
            (Data_structures_basics.Queue.length queue));
    };
    {
      description = "empty after removal";
      verify =
        (fun () ->
          Alcotest.check (Alcotest.option Alcotest.int)
            "Queue should return None after all values are dequeued"
            None
            (Data_structures_basics.Queue.dequeue queue);
          Alcotest.check Alcotest.bool
            "Queue should remain empty after a failed dequeue"
            true
            (Data_structures_basics.Queue.is_empty queue));
    };
  ]

let () =
  Alcotest.run "data_structures_basics"
    [
      ( "data_structures_basics",
        [
          Alcotest.test_case "Node" `Quick (fun () ->
              run_cases "Node" (node_cases ()));
          Alcotest.test_case "LinkedList" `Quick (fun () ->
              run_cases "LinkedList" (linked_list_cases ()));
          Alcotest.test_case "Stack" `Quick (fun () ->
              run_cases "Stack" (stack_cases ()));
          Alcotest.test_case "Queue" `Quick (fun () ->
              run_cases "Queue" (queue_cases ()));
        ] );
    ]