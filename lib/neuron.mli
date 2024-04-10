module Neuron : sig
    type t

    (* Constructor; constructs a unit neuron of a value and an operator. *)
    val create : float -> string -> t list -> t

    (* Handles the gradient flows in addition operation. *)
    val add : t -> t -> t

    (* Handles the gradient flows in multiplication operation. *)
    val mul : t -> t -> t

    (* Handles the gradient flows in exponent / power operation. *)
    (* second argument is the exponent. *)
    val exp : t -> float -> t

    (* Handles the gradient flows in ReLU operation. *)
    val relu : t -> t

    (* Handles backpropagation of the gradients for all the nodes connected to the specified base node. *)
    val backpropagate : t -> unit
end
