open Smolgrad.Variable
open Smolgrad.Network

let test_neural_network_initialization () =
  let nn = Network.create 3 [5; 2; 3] in

  Alcotest.(check int)
    "Network: Number of layers are expected"
    3
    (List.length (Network.parameters nn));
;;

let test_neural_network_propagation_of_input () =
  let nn = Network.create 3 [5; 2; 6] in
  let input_vector = [Variable.create 3.0; Variable.create 2.0; Variable.create 1.0] in
  let output_vector = Network.propagate_input nn input_vector in

  (* the dimension of the output vector should be equal to the number of neurons in the last layer *)
  Alcotest.(check int)
    "Network: Output vector has the expected number of dimensions"
    6
    (List.length output_vector);
;;
