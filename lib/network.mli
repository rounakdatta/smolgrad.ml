(* Multi-Layer Perceptron so that we can connect  multiple stacked layers *)
module Network : sig
    type t

    val create : int -> int list -> t

    val propagate_input : t -> Variable.Variable.t list -> Variable.Variable.t list
end
