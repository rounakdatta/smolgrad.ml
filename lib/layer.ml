module Layer = struct
  type t = {
    neurons : Neuron.Neuron.t list
  }

  let parameters (layer: t) =
    List.map Neuron.Neuron.parameters layer.neurons

  let create number_of_input_dimensions number_of_neurons is_non_linear =
    let neurons = List.init number_of_neurons (fun _ -> Neuron.Neuron.create number_of_input_dimensions is_non_linear) in
    { neurons = neurons }

  let propagate_input (layer: t) input_vector =
    List.map (fun neuron -> Neuron.Neuron.weigh_input neuron input_vector) layer.neurons
end
