open Smolgrad.Neuron

let test_neuron_initialization () =
  let n = Neuron.create 5 true in
  let n_weights = (Neuron.parameters n).weights in
  assert (Smolgrad.Variable.Variable.data (Neuron.parameters n).bias = 0.0);

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
    "Neuron: All weights are in range [-1, 1]"
    true
    (are_weights_in_range n_weights);
;;
