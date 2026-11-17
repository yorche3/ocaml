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

  let create value =
    { value; left = None; right = None }

  let value node =
    node.value

  let left node =
    node.left

  let right node =
    node.right

  let with_left node link =
    { node with left = link }

  let with_right node link =
    { node with right = link }
end

module BinaryTree = struct
  type t = {
    root : TreeNode.t option;
    count : int;
  }

  let create () =
    { root = None; count = 0 }

  let rec insert_node value node =
    match node with
    | None -> (Some (TreeNode.create value), true)
    | Some n ->
      if value = n.TreeNode.value then
        (Some n, false)
      else if value < n.TreeNode.value then
        let left, grew = insert_node value (TreeNode.left n) in
        (Some (TreeNode.with_left n left), grew)
      else
        let right, grew = insert_node value (TreeNode.right n) in
        (Some (TreeNode.with_right n right), grew)

  let insert tree value =
    let new_root, inserted = insert_node value tree.root in
    { root = new_root; count = tree.count + (if inserted then 1 else 0) }

  let rec contains_node value node =
    match node with
    | None -> false
    | Some n ->
      if value = n.TreeNode.value then true
      else if value < n.TreeNode.value then contains_node value (TreeNode.left n)
      else contains_node value (TreeNode.right n)

  let contains tree value =
    contains_node value tree.root

  let is_empty tree =
    tree.count = 0

  let size tree =
    tree.count
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

  let rec find_vertex label node =
    match node with
    | None -> None
    | Some n ->
      if label = n.label then Some n
      else find_vertex label n.next_vertex

  let add_vertex graph label =
    match find_vertex label graph.vertices with
    | Some _ -> graph
    | None ->
      let new_vertex = { label; neighbors = []; next_vertex = graph.vertices } in
      { graph with vertices = Some new_vertex; vertex_count = graph.vertex_count + 1 }

  let rec insert_sorted value list =
    match list with
    | [] -> [value]
    | h :: _ when value < h -> value :: list
    | h :: t when value > h -> h :: insert_sorted value t
    | _ -> list

  let rec update_neighbors label new_neighbors node =
    match node with
    | None -> None
    | Some n ->
      if label = n.label then Some { n with neighbors = new_neighbors }
      else Some { n with next_vertex = update_neighbors label new_neighbors n.next_vertex }

  let add_edge graph u v =
    match (find_vertex u graph.vertices, find_vertex v graph.vertices) with
    | Some u_vertex, Some _->
      if List.mem v u_vertex.neighbors then 
        (true, graph)
      else
        let new_neighbors = insert_sorted v u_vertex.neighbors in
        let new_vertices = update_neighbors u new_neighbors graph.vertices in
        (true, { graph with vertices = new_vertices; edge_count = graph.edge_count + 1 })
    | _ -> (false, graph)

  let has_edge graph u v =
    match (find_vertex u graph.vertices, find_vertex v graph.vertices) with
    | Some u_vertex, Some _ -> List.mem v u_vertex.neighbors
    | _ -> false

  let get_neighbors graph u =
    match find_vertex u graph.vertices with
    | Some u_vertex -> Some u_vertex.neighbors
    | None -> None

  let is_empty graph =
    graph.vertex_count = 0

  let vertex_count graph =
    graph.vertex_count

  let edge_count graph =
    graph.edge_count
end
