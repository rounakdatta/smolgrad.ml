let () =
  (* unit tests for Variable *)
  Variable_operations.test_simple_operation ();
  Variable_operations.test_custom_operator ();
  Variable_operations.test_graph_construction ();
  Variable_operations.test_backpropagation ();
;;
