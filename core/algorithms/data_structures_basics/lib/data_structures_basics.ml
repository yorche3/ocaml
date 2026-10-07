module Node = struct
  type t = {
    value : int;
    mutable next : t option;
  }

  let create value =
    { value; next = None }

  let value node =
    node.value

  let next node =
    node.next

  let set_next node link =
    node.next <- link
end

module LinkedList = struct
  type t = {
    mutable head : Node.t option;
    mutable tail : Node.t option;
    mutable count : int;
  }

  let create () =
    { head = None; tail = None; count = 0 }

  let head list =
    match list.head with
    | Some node -> Some node.value
    | None -> None

  let insert_head list value =
    let new_node = Node.create value in
    (match list.head with
    | Some old_head -> Node.set_next new_node (Some old_head)
    | None -> list.tail <- Some new_node);
    list.head <- Some new_node;
    list.count <- list.count + 1

  let insert_tail list value =
    let new_node = Node.create value in
    (match list.tail with
    | Some old_tail -> Node.set_next old_tail (Some new_node)
    | None -> list.head <- Some new_node);
    list.tail <- Some new_node;
    list.count <- list.count + 1

  let delete list value =
    let rec delete_node prev_opt current_opt =
      match current_opt with
      | Some current ->
        if Node.value current = value then begin
          (match prev_opt with
          | Some prev -> Node.set_next prev (Node.next current)
          | None -> list.head <- Node.next current);
          if list.tail = current_opt then list.tail <- prev_opt;
          list.count <- list.count - 1;
          true
        end
        else
          delete_node current_opt (Node.next current)
      | None -> false
    in
    delete_node None list.head

  let is_empty list =
    list.count = 0

  let length list =
    list.count
end

module Stack = struct
  type t = {
    mutable top : Node.t option;
    mutable count : int;
  }

  let create () =
    { top = None; count = 0 }

  let push stack value =
    let new_node = Node.create value in
    (match stack.top with
    | Some old_top -> Node.set_next new_node (Some old_top)
    | None -> ());
    stack.top <- Some new_node;
    stack.count <- stack.count + 1

  let pop stack =
    match stack.top with
    | Some top_node ->
        stack.top <- Node.next top_node;
        stack.count <- stack.count - 1;
        Some top_node.value
    | None -> None

  let peek stack =
    match stack.top with
    | Some top_node -> Some top_node.value
    | None -> None

  let is_empty stack =
    stack.count = 0

  let length stack =
    stack.count
end

module Queue = struct
  type t = {
    mutable front : Node.t option;
    mutable rear : Node.t option;
    mutable count : int;
  }

  let create () =
    { front = None; rear = None; count = 0 }

  let enqueue queue value =
    let new_node = Node.create value in
    (match queue.rear with
    | Some old_rear -> Node.set_next old_rear (Some new_node)
    | None -> queue.front <- Some new_node);
    queue.rear <- Some new_node;
    queue.count <- queue.count + 1

  let dequeue queue =
    match queue.front with
    | Some front_node ->
        queue.front <- Node.next front_node;
        if queue.front = None then queue.rear <- None;
        queue.count <- queue.count - 1;
        Some front_node.value
    | None -> None

  let peek queue =
    match queue.front with
    | Some front_node -> Some front_node.value
    | None -> None

  let is_empty queue =
    queue.count = 0

  let length queue =
    queue.count
end
