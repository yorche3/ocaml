(** Advanced structures of the 07_Data_Structures_Advanced specification:
    binary search tree and directed graph.

    Declared adaptation (V2 immutable): every operation returns a new value, so
    the "set" operations become [with_left] and [with_right] and the graph
    insertions return the resulting structure. Absence uses OCaml's native
    [option]: [None] for an absent link and for an unregistered vertex,
    [Some []] for a registered vertex without neighbours. No wrapper types and
    no exceptions are introduced. *)

module TreeNode : sig
  type t

  (** Node holding [value] with both links absent ([init]). *)
  val create : int -> t

  (** Observes the node's value. *)
  val value : t -> int

  (** Observes the left link, or [None] when absent. *)
  val left : t -> t option

  (** Observes the right link, or [None] when absent. *)
  val right : t -> t option

  (** Copy of [node] whose left link is [link], the V2 form of [set_left]. *)
  val with_left : t -> t option -> t

  (** Copy of [node] whose right link is [link], the V2 form of [set_right]. *)
  val with_right : t -> t option -> t
end

module BinaryTree : sig
  type t

  (** Empty tree: absent root and size 0 ([init]). *)
  val create : unit -> t

  (** Inserts [value]; a duplicate is also a success and does not grow. *)
  val insert : t -> int -> t

  (** Membership according to the search-tree invariant. *)
  val contains : t -> int -> bool

  (** True when the tree stores no value. *)
  val is_empty : t -> bool

  (** Number of distinct values stored. *)
  val size : t -> int
end

module Graph : sig
  type t

  (** Empty graph: no vertices and both counters at 0 ([init]). *)
  val create : unit -> t

  (** Registers [label]; a duplicate is also a success and keeps the
      adjacency. *)
  val add_vertex : t -> int -> t

  (** Directed edge [u -> v]: [(true, graph)] when it is added or already
      present, [(false, graph)] when either endpoint is missing. *)
  val add_edge : t -> int -> int -> bool * t

  (** True when the directed edge [u -> v] exists. *)
  val has_edge : t -> int -> int -> bool

  (** Sorted neighbours: [None] when [u] is not registered, [Some []] when it
      is isolated. *)
  val get_neighbors : t -> int -> int list option

  (** True when no vertex is registered. *)
  val is_empty : t -> bool

  (** Number of registered vertices. *)
  val vertex_count : t -> int

  (** Number of registered edges. *)
  val edge_count : t -> int
end
