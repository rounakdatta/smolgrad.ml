module Neuron : sig
    type t

    (* Constructor; constructs a unit neuron of a value and an operator. *)
    val create : float -> string -> t

    (* Adds two values, resulting in a new value. *)
    val add : t -> t -> t

    (* Multiplies two values, resulting in a new value. *)
    val mul : t -> t -> t
end
