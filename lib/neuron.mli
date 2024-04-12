(* Neuron is the holder of weights and biases, and thereby capable of judging / weighing an input *)
module Neuron : sig
    type t

    (* we've defined this public type both here in the interface file as well as the implementation file *)
    (* this is required for the internal attributes of the type to be accessible publicly *)
    type out_t = {
        weights : Variable.Variable.t list;
        bias : Variable.Variable.t;
    }

    (* getter for the parameters (aka weights and biases) of the neuron *)
    val parameters : t -> out_t 

    (* Constructor; constructs a unit neuron *)
    val create : int -> bool -> t

    (* Passes the training input and lets the neuron weigh the input values against its weights and biases *)
    val weigh_input : t -> Variable.Variable.t list -> Variable.Variable.t
end
