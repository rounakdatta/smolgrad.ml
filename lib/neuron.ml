(* this function can reliably generate random float values in the range -1.0 to 1.0 *)
let random_weight_initializer = Random.self_init(); (Random.float 2.0) -. 1.0

module Neuron = struct
  type t = {
    mutable weights : Variable.Variable.t list;
    mutable bias : Variable.Variable.t;
    is_non_linear : bool;
  }

  let create number_of_inputs is_non_linear = {
    weights = List.init number_of_inputs (fun _ -> Variable.Variable.create (random_weight_initializer));
    bias = Variable.Variable.create 0.0;
    is_non_linear = is_non_linear;
  }

  let weigh_inputs neuron input_vector =
    (* one-to-one multiplication of inputs to their corresponding weights *)
    let weighted_sum = List.fold_left2 (fun accumulator weight_i input_i -> Variable.Variable.(accumulator + weight_i * input_i))
      (Variable.Variable.create 0.0) neuron.weights input_vector in

    (* decide whether to apply activation function or not *)
    if neuron.is_non_linear then
      Variable.Variable.relu Variable.Variable.(weighted_sum + neuron.bias)
    else
      Variable.Variable.(weighted_sum + neuron.bias)
end
