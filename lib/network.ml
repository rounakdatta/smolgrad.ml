module Network = struct
  type t = {
    layers : Layer.Layer.t list;
  }

  (* the number of output parameters of a layer is the number of neurons in that layer *)
  (* important to understand that the input layer isn't truly a layer with weights and biases; just an abstraction *)
  let create number_of_input_dimensions number_of_neurons_per_layer =
    let size_of_each_layer = number_of_input_dimensions :: number_of_neurons_per_layer in

    let rec build_layers stacked_layers sizes =
      match sizes with
      | input :: output :: rest ->
        let layer = Layer.Layer.create input output true in

        (* note how we are stacking the layers in reverse order *)
        build_layers (layer :: stacked_layers) (output :: rest)

      (* hence we got to reverse it at the end *)
      | _ -> List.rev stacked_layers
    in
    { layers = build_layers [] size_of_each_layer }
  
  (* the input vector as it propagates through each layer, is considered the intermediate output
    and of course the input for the next layer, until the last one is the final output vector *)
  let propagate_input (network: t) input_vector =
    List.fold_left (fun intermediate_output layer -> Layer.Layer.propagate_input layer intermediate_output) input_vector network.layers
end
