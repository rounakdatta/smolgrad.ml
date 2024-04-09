module Neuron : sig
    type t

    (* Constructor; constructs a unit neuron of a value and an operator. *)
    val create : float -> string -> t

    (* Handles the gradient flows in addition operation. *)
    val add : t -> t -> t

    (* Handles the gradient flows in multiplication operation. *)
    val mul : t -> t -> t

    (* Handles the gradient flows in exponent / power operation. *)
    (* second argument is the exponent. *)
    val exp : t -> int -> t

    (* Handles the gradient flows in ReLU operation. *)
    val relu : t -> t

    (* Handles backpropagation of the gradients. *)
    val backpropagate : t -> unit
end
