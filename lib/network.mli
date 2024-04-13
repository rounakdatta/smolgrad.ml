(* Multi-Layer Perceptron so that we can connect  multiple stacked layers *)
module Network : sig
    type t

    (* getter for the parameters (aka weights and biases) of the entire network *)
    val parameters : t -> Neuron.Neuron.out_t list list

    val create : int -> int list -> t

    val propagate_input : t -> Variable.Variable.t list -> Variable.Variable.t list
end
