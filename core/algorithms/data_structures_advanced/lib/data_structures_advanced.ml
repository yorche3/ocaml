(* Contract of the `data_structures_advanced` module — specification
   07_Data_Structures_Advanced.

   Complete contract: new types, signatures and one sentinel body per
   operation. The real implementation arrives in the next step; until then the
   operations return the neutral value of their type, so the suite must fail.

   Natural indicators:
   - absent links are [None] and a successful link is [Some node];
   - [get_neighbors] returns [int list option]: [None] when the vertex is not
     registered, [Some []] when it is isolated;
   - [add_edge] returns the success flag and the resulting graph: on failure
     [false] with the same graph, never an exception;
   - flags return [bool], counters return [int] and an empty structure
     reports 0. *)

module TreeNode = struct
  type t = {
    value : int;
    left : t option;
    right : t option;
  }

  let create _value =
    { value = 0; left = None; right = None }

  let value node =
    node.value

  let left node =
    node.left

  let right node =
    node.right

  let with_left node _link =
    node

  let with_right node _link =
    node
end

module BinaryTree = struct
  type t = {
    root : TreeNode.t option;
    count : int;
  }

  let create () =
    { root = None; count = 0 }

  let insert tree _value =
    tree

  let contains _tree _value =
    false

  let is_empty _tree =
    false

  let size _tree =
    0
end

module Graph = struct
  type graph_node = {
    label : int;
    neighbors : int list;
    next_vertex : graph_node option;
  }

  type t = {
    vertices : graph_node option;
    vertex_count : int;
    edge_count : int;
  }

  let create () =
    { vertices = None; vertex_count = 0; edge_count = 0 }

  let add_vertex graph _label =
    graph

  let add_edge graph _u _v =
    (false, graph)

  let has_edge _graph _u _v =
    false

  let get_neighbors _graph _u =
    None

  let is_empty _graph =
    false

  let vertex_count _graph =
    0

  let edge_count _graph =
    0
end
