(* Layer is the aggregator of many neurons parallelly
   captures essence of an input by adjusting it's weights and biases *)
module Layer : sig
    type t

    (* Constructor; constructs a layer of neurons *)
    val create : int -> int -> bool -> t

    (* Propagates the input across all the neurons in the layer *)
    val propagate_input : t -> Variable.Variable.t list -> Variable.Variable.t list
end
