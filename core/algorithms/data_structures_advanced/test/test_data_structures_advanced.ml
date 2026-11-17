(* Casos de prueba de la especificación 07_Data_Structures_Advanced.md.

   Adaptación de tipo: la variante es inmutable (V2), así que los "set" son
   [with_left]/[with_right] y las inserciones devuelven la estructura nueva.
   La ausencia es [None]; [Some []] es un vecindario vacío. [add_edge] devuelve
   [(éxito, grafo)]. Cada fila de la especificación es un test con su propia
   instancia. *)

module T = Data_structures_advanced.TreeNode
module B = Data_structures_advanced.BinaryTree
module G = Data_structures_advanced.Graph

let int_list_option = Alcotest.option (Alcotest.list Alcotest.int)
let check_bool = Alcotest.check Alcotest.bool
let check_int = Alcotest.check Alcotest.int

(* Fixtures *)
let node_parent_input = 10
let node_left_input = 20
let node_right_input = 30
let node_value_output = 10
let node_left_value_output = 20
let node_right_value_output = 30

let tree_root_input = 50
let tree_lower_input = 30
let tree_higher_input = 70
let tree_deep_left_input = 20
let tree_deep_right_input = 40
let tree_missing_input = 99
let tree_three_inputs = [ 50; 30; 70 ]
let tree_five_inputs = [ 50; 30; 70; 20; 40 ]
let tree_duplicate_inputs = [ 50; 30; 70; 30 ]
let tree_ordered_inputs = [ 20; 30; 40; 50; 70 ]

let graph_a_input = 10
let graph_b_input = 30
let graph_c_input = 50
let graph_d_input = 70
let graph_missing_input = 99
let graph_other_missing_input = 98

(* TreeNode *)
let value_of = function Some n -> Some (T.value n) | None -> None

let tree_node_cases =
  [
    ( "create a tree node",
      fun () ->
        check_int "TreeNode should retain its initialized value"
          node_value_output
          (T.value (T.create node_parent_input)) );
    ( "absent initial links",
      fun () ->
        let node = T.create node_parent_input in
        check_bool "TreeNode left link should be absent initially" true
          (T.left node = None);
        check_bool "TreeNode right link should be absent initially" true
          (T.right node = None) );
    ( "link two children",
      fun () ->
        let parent =
          T.create node_parent_input
          |> fun p -> T.with_left p (Some (T.create node_left_input))
          |> fun p -> T.with_right p (Some (T.create node_right_input))
        in
        Alcotest.check (Alcotest.option Alcotest.int)
          "TreeNode left child should hold 20" (Some node_left_value_output)
          (value_of (T.left parent));
        Alcotest.check (Alcotest.option Alcotest.int)
          "TreeNode right child should hold 30" (Some node_right_value_output)
          (value_of (T.right parent)) );
    ( "traverse each link",
      fun () ->
        let parent =
          T.with_right
            (T.with_left (T.create node_parent_input)
               (Some (T.create node_left_input)))
            (Some (T.create node_right_input))
        in
        let left = Option.get (T.left parent) in
        let right = Option.get (T.right parent) in
        check_int "TreeNode left child should lead to 20"
          node_left_value_output (T.value left);
        check_int "TreeNode right child should lead to 30"
          node_right_value_output (T.value right);
        check_bool "TreeNode left child links should be absent" true
          (T.left left = None && T.right left = None);
        check_bool "TreeNode right child links should be absent" true
          (T.left right = None && T.right right = None) );
    ( "unlink children",
      fun () ->
        let parent =
          T.with_right
            (T.with_left (T.create node_parent_input)
               (Some (T.create node_left_input)))
            (Some (T.create node_right_input))
        in
        let no_left = T.with_left parent None in
        check_int "TreeNode should keep value 10 after clearing left"
          node_value_output (T.value no_left);
        check_bool "TreeNode left should be absent after clearing it" true
          (T.left no_left = None);
        Alcotest.check (Alcotest.option Alcotest.int)
          "TreeNode should keep right child 30 after clearing left"
          (Some node_right_value_output)
          (value_of (T.right no_left));
        let no_links = T.with_right no_left None in
        check_bool "TreeNode should have both links absent after clearing right"
          true
          (T.left no_links = None && T.right no_links = None);
        check_int "TreeNode should keep value 10 after clearing right"
          node_value_output (T.value no_links) );
    ( "immutable adaptation",
      fun () ->
        let original = T.create node_parent_input in
        let linked = T.with_left original (Some (T.create node_left_input)) in
        Alcotest.check (Alcotest.option Alcotest.int)
          "TreeNode with_left should return a node with the link"
          (Some node_left_value_output)
          (value_of (T.left linked));
        check_bool "TreeNode original should remain unchanged" true
          (T.left original = None) );
  ]

(* BinaryTree *)
let tree_of values = List.fold_left B.insert (B.create ()) values

let check_members name tree values =
  List.iter
    (fun v ->
      check_bool (Printf.sprintf "BinaryTree %s should contain %d" name v) true
        (B.contains tree v))
    values

let binary_tree_cases =
  [
    ( "create empty",
      fun () ->
        let tree = B.create () in
        check_bool "BinaryTree empty should be empty" true (B.is_empty tree);
        check_int "BinaryTree empty should have size 0" 0 (B.size tree);
        check_bool "BinaryTree empty should not contain 50" false
          (B.contains tree tree_root_input) );
    ( "insert the root",
      fun () ->
        let tree = B.insert (B.create ()) tree_root_input in
        check_int "BinaryTree root insert should give size 1" 1 (B.size tree);
        check_bool "BinaryTree root insert should not be empty" false
          (B.is_empty tree);
        check_bool "BinaryTree root insert should contain 50" true
          (B.contains tree tree_root_input) );
    ( "insert lower and higher",
      fun () ->
        let tree = tree_of tree_three_inputs in
        check_int "BinaryTree lower/higher should have size 3" 3 (B.size tree);
        check_members "lower/higher" tree
          [ tree_root_input; tree_lower_input; tree_higher_input ] );
    ( "multilevel branches",
      fun () ->
        let tree = tree_of tree_five_inputs in
        check_members "multilevel" tree
          [ tree_root_input; tree_lower_input; tree_higher_input;
            tree_deep_left_input; tree_deep_right_input ];
        check_int "BinaryTree multilevel should have size 5" 5 (B.size tree) );
    ( "missing value in nonempty tree",
      fun () ->
        let tree = tree_of [ tree_root_input ] in
        check_bool "BinaryTree should not contain missing 99" false
          (B.contains tree tree_missing_input);
        check_int "BinaryTree should keep size 1 after missing query" 1
          (B.size tree);
        check_bool "BinaryTree should still contain 50" true
          (B.contains tree tree_root_input) );
    ( "idempotent duplicate",
      fun () ->
        let tree = tree_of tree_duplicate_inputs in
        check_int "BinaryTree duplicate should keep size 3" 3 (B.size tree);
        check_members "duplicate" tree
          [ tree_root_input; tree_lower_input; tree_higher_input ] );
    ( "ordered insertions",
      fun () ->
        let tree = tree_of tree_ordered_inputs in
        check_int "BinaryTree ordered should have size 5" 5 (B.size tree);
        check_members "ordered" tree tree_ordered_inputs;
        check_bool "BinaryTree ordered should not contain 99" false
          (B.contains tree tree_missing_input) );
  ]

(* Graph *)
let graph_of labels = List.fold_left G.add_vertex (G.create ()) labels

let add_edge_ok name graph (u, v) =
  let ok, graph = G.add_edge graph u v in
  check_bool (Printf.sprintf "Graph %s add_edge(%d,%d) should succeed" name u v)
    true ok;
  graph

let check_counts name graph vertices edges =
  check_int (Printf.sprintf "Graph %s should have %d vertices" name vertices)
    vertices (G.vertex_count graph);
  check_int (Printf.sprintf "Graph %s should have %d edges" name edges) edges
    (G.edge_count graph)

let check_neighbors name graph u expected =
  Alcotest.check int_list_option
    (Printf.sprintf "Graph %s neighbours of %d should match" name u)
    expected (G.get_neighbors graph u)

let graph_cases =
  [
    ( "create empty",
      fun () ->
        let g = G.create () in
        check_bool "Graph empty should be empty" true (G.is_empty g);
        check_counts "empty" g 0 0;
        check_bool "Graph empty should not have edge 10->30" false
          (G.has_edge g graph_a_input graph_b_input);
        check_neighbors "empty" g graph_a_input None );
    ( "isolated vertex",
      fun () ->
        let g = G.add_vertex (G.create ()) graph_a_input in
        check_bool "Graph isolated should not be empty" false (G.is_empty g);
        check_counts "isolated" g 1 0;
        check_neighbors "isolated" g graph_a_input (Some []) );
    ( "nonconsecutive labels and directed edge",
      fun () ->
        let g =
          add_edge_ok "directed"
            (graph_of [ graph_a_input; graph_d_input ])
            (graph_a_input, graph_d_input)
        in
        check_bool "Graph directed should have edge 10->70" true
          (G.has_edge g graph_a_input graph_d_input);
        check_bool "Graph directed should not have reverse edge 70->10" false
          (G.has_edge g graph_d_input graph_a_input);
        check_counts "directed" g 2 1 );
    ( "duplicate vertex preserves adjacency",
      fun () ->
        let g =
          add_edge_ok "duplicate vertex"
            (graph_of [ graph_a_input; graph_b_input ])
            (graph_a_input, graph_b_input)
        in
        let g = G.add_vertex g graph_a_input in
        check_counts "duplicate vertex" g 2 1;
        check_neighbors "duplicate vertex" g graph_a_input
          (Some [ graph_b_input ]) );
    ( "duplicate edge",
      fun () ->
        let g = graph_of [ graph_a_input; graph_b_input ] in
        let g =
          add_edge_ok "duplicate edge first" g (graph_a_input, graph_b_input)
        in
        let g =
          add_edge_ok "duplicate edge second" g (graph_a_input, graph_b_input)
        in
        check_counts "duplicate edge" g 2 1;
        check_neighbors "duplicate edge" g graph_a_input
          (Some [ graph_b_input ]) );
    ( "missing endpoint without mutation",
      fun () ->
        let g =
          add_edge_ok "missing endpoint"
            (graph_of [ graph_a_input; graph_b_input ])
            (graph_a_input, graph_b_input)
        in
        let attempts =
          [ (graph_a_input, graph_missing_input);
            (graph_missing_input, graph_a_input);
            (graph_other_missing_input, graph_missing_input);
            (graph_missing_input, graph_missing_input) ]
        in
        let g =
          List.fold_left
            (fun g (u, v) ->
              let ok, g = G.add_edge g u v in
              check_bool
                (Printf.sprintf "Graph add_edge(%d,%d) should fail" u v)
                false ok;
              g)
            g attempts
        in
        check_counts "missing endpoint" g 2 1;
        check_neighbors "missing endpoint" g graph_a_input
          (Some [ graph_b_input ]);
        check_neighbors "missing endpoint" g graph_b_input (Some []);
        List.iter
          (fun (u, v) ->
            check_bool
              (Printf.sprintf "Graph attempted edge %d->%d should stay absent"
                 u v)
              false (G.has_edge g u v))
          attempts;
        check_neighbors "missing endpoint" g graph_other_missing_input None;
        check_neighbors "missing endpoint" g graph_missing_input None );
    ( "sorted neighbours and counts",
      fun () ->
        let g =
          graph_of
            [ graph_a_input; graph_b_input; graph_c_input; graph_d_input ]
        in
        let g =
          List.fold_left (add_edge_ok "sorted") g
            [ (graph_a_input, graph_d_input); (graph_a_input, graph_b_input);
              (graph_a_input, graph_c_input); (graph_b_input, graph_c_input) ]
        in
        check_neighbors "sorted" g graph_a_input
          (Some [ graph_b_input; graph_c_input; graph_d_input ]);
        check_neighbors "sorted" g graph_b_input (Some [ graph_c_input ]);
        check_neighbors "sorted" g graph_c_input (Some []);
        check_neighbors "sorted" g graph_d_input (Some []);
        check_counts "sorted" g 4 4 );
    ( "missing-edge query",
      fun () ->
        let g = graph_of [ graph_a_input; graph_b_input ] in
        check_bool "Graph should not have unadded edge 10->30" false
          (G.has_edge g graph_a_input graph_b_input);
        check_counts "missing edge" g 2 0;
        check_bool "Graph missing-edge should not be empty" false
          (G.is_empty g) );
    ( "neighbours of missing vertex",
      fun () ->
        let g = G.add_vertex (G.create ()) graph_a_input in
        check_neighbors "missing vertex" g graph_missing_input None;
        check_neighbors "missing vertex" g graph_a_input (Some []);
        check_counts "missing vertex" g 1 0 );
    ( "self-loop and duplicate",
      fun () ->
        let g = G.add_vertex (G.create ()) graph_a_input in
        let g = add_edge_ok "loop first" g (graph_a_input, graph_a_input) in
        let g = add_edge_ok "loop second" g (graph_a_input, graph_a_input) in
        check_bool "Graph loop should have edge 10->10" true
          (G.has_edge g graph_a_input graph_a_input);
        check_neighbors "loop" g graph_a_input (Some [ graph_a_input ]);
        check_counts "loop" g 1 1 );
    ( "neighbour-result isolation",
      fun () ->
        let g =
          add_edge_ok "isolation"
            (graph_of [ graph_a_input; graph_b_input; graph_c_input ])
            (graph_a_input, graph_b_input)
        in
        let saved = G.get_neighbors g graph_a_input in
        (* Las listas OCaml son inmutables: no hay copia modificable. *)
        let g =
          add_edge_ok "isolation later" g (graph_a_input, graph_c_input)
        in
        Alcotest.check int_list_option
          "Graph saved neighbours should remain [30]"
          (Some [ graph_b_input ]) saved;
        check_neighbors "isolation fresh" g graph_a_input
          (Some [ graph_b_input; graph_c_input ]);
        check_counts "isolation" g 3 2 );
  ]

let group name cases =
  ( name,
    List.map
      (fun (case, verify) -> Alcotest.test_case case `Quick verify)
      cases )

let () =
  Alcotest.run "data_structures_advanced"
    [
      group "TreeNode" tree_node_cases;
      group "BinaryTree" binary_tree_cases;
      group "Graph" graph_cases;
    ]
