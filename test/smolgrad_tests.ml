open Smolgrad.Neuron

let test_simple_operation () =
  let a = Neuron.create 4.0 in
  let b = Neuron.create 2.0 in
  
  let abba = Neuron.(a + b) in
  Alcotest.(check (float 0.0))
    "Nodes add up correctly"
    6.0
    (Neuron.data abba);
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
    6.0
    (Neuron.data abba);
;;

let test_graph_construction () =
  let a = Neuron.create 4.0 in
  let b = Neuron.create 2.0 in

  let c = Neuron.(a * b + b ** 3.0) in
  (* c essentially depends on (a * b) as the first node and b ** 3.0 as the second node *)
  (* interesting how BODMAS rules automagically apply here for the operators *)

  let d = Neuron.(c + a) in
  (* d essentially depends on c and a; simple *)

  Alcotest.(check (list (float 0.0)))
    "Dependency graph is constructed correctly for c"
    (List.map (fun x -> Neuron.data x) [Neuron.(a * b); Neuron.(b ** 3.0)])
    (List.map (fun x -> Neuron.data x) (Neuron.dependencies c));

  Alcotest.(check (list (float 0.0)))
    "Dependency graph is constructed correctly for d"
    (List.map (fun x -> Neuron.data x) [c; a])
    (List.map (fun x -> Neuron.data x) (Neuron.dependencies d));
;;

let test_backpropagation () =
  let a = Neuron.create (-4.0) in
  let b = Neuron.create 2.0 in
  let c = Neuron.(a * b + b ** 3.0) in

  Neuron.backpropagate c;

  Alcotest.(check (float 0.0))
    "Backpropagation yields correct gradient for a for a complex graph"
    2.0
    (Neuron.grad a);

  Alcotest.(check (float 0.0))
    "Backpropagation yields correct gradient for b a complex graph"
    8.0
    (Neuron.grad b);
;;

let () =
  test_simple_operation ();
  test_custom_operator ();
  test_graph_construction ();
  test_backpropagation ();
;;
