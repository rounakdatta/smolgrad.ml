open Smolgrad.Variable
open Smolgrad.Neuron

let test_neuron_initialization () =
  let n = Neuron.create 5 true in
  let n_weights = (Neuron.parameters n).weights in

  Alcotest.(check int)
    "Neuron: Right number of parameters are set"
    5
    (List.length (Neuron.parameters n).weights);

  Alcotest.(check (float 0.0))
    "Neuron: Bias is initially set to 0.0"
    0.0
    (Smolgrad.Variable.Variable.data (Neuron.parameters n).bias);

  let are_weights_in_range weights =
    List.for_all (fun x -> (Smolgrad.Variable.Variable.data x) >= -1.0 && (Smolgrad.Variable.Variable.data x) <= 1.0) weights in

  Alcotest.(check bool)
    "Neuron: All weights are in range [-1.0, 1.0]"
    true
    (are_weights_in_range n_weights);
;;

let test_neuron_weights_reacting_to_input () =
  let n = Neuron.create 3 false in
  let n_weight_values = Array.of_list (List.map (fun x -> Variable.data x) (Neuron.parameters n).weights) in

  (* make the same neuron react to two different inputs *)
  let neuron_activation_for_input_1 = Neuron.weigh_input n [Variable.create 3.0; Variable.create 2.0; Variable.create 1.0] in
  let neuron_activation_for_input_2 = Neuron.weigh_input n [Variable.create 8.0; Variable.create 13.0; Variable.create (-4.0)] in

  (* since it is a weighted sum, we'll cleverly subtract the two, and compare the difference *)
  (* remember that weights are initialized as random values, hence all these witchery *)
  let remainder = (3.0 -. 8.0) *. n_weight_values.(0) +. (2.0 -. 13.0) *. n_weight_values.(1) +. (1.0 -. (-4.0)) *. n_weight_values.(2) in

  (* 0.01 is the float tolerance / round-off *)
  Alcotest.(check (float 0.01))
    "Neuron: Neuron activation upon input happened correctly"
    remainder
    (Smolgrad.Variable.Variable.data neuron_activation_for_input_1 -. Smolgrad.Variable.Variable.data neuron_activation_for_input_2);
;;
