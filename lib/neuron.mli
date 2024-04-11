(* Neuron is the holder of weights and biases, and thereby capable of judging / weighing an input *)
module Neuron : sig
    type t

    (* Constructor; constructs a unit neuron *)
    val create : int -> bool -> t

    (* Passes the training input and lets the neuron weigh the input values against its weights and biases *)
    val weigh_inputs : t -> Variable.Variable.t list -> Variable.Variable.t
end
