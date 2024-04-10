open Smolgrad.Neuron

let test_simple_operation () =
  let a = Neuron.create 4.0 in
  let b = Neuron.create 2.0 in
  
  let abba = Neuron.(a + b) in
  Alcotest.(check (float 0.0))
    "Nodes add up correctly"
    6.0 (Neuron.data abba);
;;

(* here we open the Neuron module wide open locally, thereby allowing the clean custom `+` operator usage *)
(* we'll avoid this pattern elsewhere in the tests *)
let test_custom_operator () =
  let open Neuron in
  let a = create 4.0 in
  let b = create 2.0 in

  let abba = a + b in
  Alcotest.(check (float 0.0))
    "Nodes add up correctly with custom operator"
    6.0 (Neuron.data abba);
;;

let test_graph_construction () =
  let a = Neuron.create 4.0 in
  let b = Neuron.create 2.0 in
  let c = Neuron.(a * b + b**3.0) in
  let d = Neuron.(c + a) in

  Alcotest.(check (list (float 0.0)))
    "Dependency graph is constructed correctly"
    (List.map (fun x -> Neuron.data x) [a; b]) (List.map (fun x -> Neuron.data x) (Neuron.dependencies d));
;;

let test_backpropagation () =
  let a = Neuron.create 4.0 in
  let b = Neuron.create 2.0 in
  let c = Neuron.(a * b + b**3.0) in

  Neuron.backpropagate c;
  Alcotest.(check (float 0.0))
    "Backpropagation yields correct gradient for a complex graph"
    6.0 (Neuron.grad c);
;;

let () =
  test_simple_operation ();
  test_custom_operator ();
  test_graph_construction ();
  (* test_backpropagation (); *)
;;
