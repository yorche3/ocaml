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

  let head _ =
    None

  let insert_head _ _ =
    ()

  let insert_tail _ _ =
    ()

  let delete _ _ =
    false

  let is_empty _ =
    false

  let length _ =
    0
end

module Stack = struct
  type t = {
    mutable top : Node.t option;
    mutable count : int;
  }

  let create () =
    { top = None; count = 0 }

  let push _ _ =
    ()

  let pop _ =
    None

  let peek _ =
    None

  let is_empty _ =
    false

  let length _ =
    0
end

module Queue = struct
  type t = {
    mutable front : Node.t option;
    mutable rear : Node.t option;
    mutable count : int;
  }

  let create () =
    { front = None; rear = None; count = 0 }

  let enqueue _ _ =
    ()

  let dequeue _ =
    None

  let peek _ =
    None

  let is_empty _ =
    false

  let length _ =
    0
end
