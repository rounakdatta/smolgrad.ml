open Smolgrad.Variable

let test_simple_operation () =
  let a = Variable.create 4.0 in
  let b = Variable.create 2.0 in
  
  let abba = Variable.(a + b) in
  Alcotest.(check (float 0.0))
    "Nodes add up correctly"
    6.0
    (Variable.data abba);
;;

(* here we open the Variable module wide open locally, thereby allowing the clean custom `+` operator usage *)
(* we'll avoid this pattern elsewhere in the tests *)
let test_custom_operator () =
  let open Variable in
  let a = create 4.0 in
  let b = create 2.0 in

  let abba = a + b in
  Alcotest.(check (float 0.0))
    "Nodes add up correctly with custom operator"
    6.0
    (Variable.data abba);
;;

let test_graph_construction () =
  let a = Variable.create 4.0 in
  let b = Variable.create 2.0 in

  let c = Variable.(a * b + b ** 3.0) in
  (* c essentially depends on (a * b) as the first node and (b ** 3.0) as the second node *)
  (* interesting how BODMAS rules automagically apply here for the operators *)

  let d = Variable.(c + a) in
  (* d essentially depends on c and a - simple and obvious *)

  Alcotest.(check (list (float 0.0)))
    "Dependency graph is constructed correctly for c"
    (List.map (fun x -> Variable.data x) [Variable.(a * b); Variable.(b ** 3.0)])
    (List.map (fun x -> Variable.data x) (Variable.dependencies c));

  Alcotest.(check (list (float 0.0)))
    "Dependency graph is constructed correctly for d"
    (List.map (fun x -> Variable.data x) [c; a])
    (List.map (fun x -> Variable.data x) (Variable.dependencies d));
;;

let test_backpropagation () =
  let a = Variable.create (-4.0) in
  let b = Variable.create 2.0 in
  let c = Variable.(a * b + b ** 3.0) in

  Variable.backpropagate c;

  Alcotest.(check (float 0.0))
    "Backpropagation yields correct gradient for a for a complex graph"
    2.0
    (Variable.grad a);

  Alcotest.(check (float 0.0))
    "Backpropagation yields correct gradient for b a complex graph"
    8.0
    (Variable.grad b);
;;

let () =
  test_simple_operation ();
  test_custom_operator ();
  test_graph_construction ();
  test_backpropagation ();
;;
