(** Basic linked data structures built from scratch over Node.
    Only absent links use [option]; fallible reads return the [-1] sentinel.
    Every constructor is named [create]. *)

module Node : sig
  type t

  (** Creates a node holding [value] with an absent link. *)
  val create : int -> t

  (** Observes the node's value. *)
  val value : t -> int

  (** Observes the node's link, or [None] when absent. *)
  val next : t -> t option

  (** Replaces the node's link. *)
  val set_next : t -> t option -> unit
end

module LinkedList : sig
  type t

  (** Creates an empty list. A fresh instance each call. *)
  val create : unit -> t

  (** Head value, or [-1] when empty. *)
  val head : t -> int

  (** Inserts [value] at the head. O(1). *)
  val insert_head : t -> int -> unit

  (** Inserts [value] at the tail. O(1). *)
  val insert_tail : t -> int -> unit

  (** Removes the first occurrence of [value].
      Returns [true] if a node was removed. O(n). *)
  val delete : t -> int -> bool

  (** True when the list contains no nodes. *)
  val is_empty : t -> bool

  (** Number of nodes stored. *)
  val length : t -> int
end

module Stack : sig
  type t

  val create : unit -> t

  (** Pushes [value] on top. O(1). *)
  val push : t -> int -> unit

  (** Pops the top value, or [-1] when empty. O(1). *)
  val pop : t -> int

  (** Observes the top value without removing it, or [-1]. *)
  val peek : t -> int

  val is_empty : t -> bool
  val length : t -> int
end

module Queue : sig
  type t

  val create : unit -> t

  (** Appends [value] at the rear. O(1). *)
  val enqueue : t -> int -> unit

  (** Removes the front value, or [-1] when empty. O(1). *)
  val dequeue : t -> int

  (** Observes the front value without removing it, or [-1]. *)
  val peek : t -> int

  val is_empty : t -> bool
  val length : t -> int
end
