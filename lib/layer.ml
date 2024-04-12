module Layer = struct
  type t = {
    neurons : Neuron.Neuron.t list
  }

  let create number_of_inputs number_of_neurons is_non_linear =
    let neurons = List.init number_of_neurons (fun _ -> Neuron.Neuron.create number_of_inputs is_non_linear) in
    { neurons = neurons }

  let propagate_input (layer: t) input_vector =
    List.map (fun neuron -> Neuron.Neuron.weigh_input neuron input_vector) layer.neurons
end
