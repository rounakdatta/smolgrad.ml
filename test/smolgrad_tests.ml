open Smolgrad.Neuron

let test_simple_operation () =
  let a = Neuron.create 4.0 in
  let b = Neuron.create 2.0 in
  
  let abba = Neuron.(a + b) in
  assert (Neuron.data abba = 6.0);
;;

(* here we open the Neuron module wide open locally, thereby allowing the clean custom `+` operator usage *)
let test_custom_operator () =
  let open Neuron in
  let a = create 4.0 in
  let b = create 2.0 in

  let abba = a + b in
  assert (Neuron.data abba = 6.0);
;;
  
let () =
  test_simple_operation ();
  test_custom_operator ();
;;
