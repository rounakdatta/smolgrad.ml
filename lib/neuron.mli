module Neuron : sig
    type t

    (* getter for the data *)
    val data : t -> float

    (* getter for the gradient or weight *)
    val grad : t -> float

    (* getter for the dependencies of the node *)
    val dependencies : t -> t list

    (* Constructor; constructs a unit neuron of a value and an operator. *)
    val create : ?op:string -> ?deps:t list -> float -> t

    (* Handles the gradient flows in addition operation. *)
    val add : t -> t -> t
    val ( + ) : t -> t -> t

    (* Handles the gradient flows in multiplication operation. *)
    val mul : t -> t -> t
    val ( * ) : t -> t -> t

    (* Handles the gradient flows in exponent / power operation. *)
    (* second argument is the exponent. *)
    val exp : t -> float -> t
    val ( ** ) : t -> float -> t

    (* Handles the gradient flows in ReLU operation. *)
    val relu : t -> t

    (* Handles backpropagation of the gradients for all the nodes connected to this as the base node. *)
    val backpropagate : t -> unit
end
