(* this is essentially the core variable which is differentiable at heart *)
(* these form the base data structure of weights and biases of a neuron *)
module Variable : sig
    type t

    (* getter for the data *)
    val data : t -> float

    (* getter for the gradient *)
    val grad : t -> float

    (* getter for the dependencies of the node *)
    val dependencies : t -> t list

    (* Constructor; constructs a unit variable with a value, *)
    (* and optionally the creation operation and the dependencies. *)
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
