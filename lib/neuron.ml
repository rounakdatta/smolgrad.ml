module Neuron = struct
  type t = {
    mutable data : float;
    mutable grad : float;
    mutable backward : unit -> unit;
    op : string;
    prev : t list;
  }

  let create data operator = { data; grad = 0.;
    backward = (fun () -> ()); op = operator; prev = []
  }

  let add a b =
    let out = create (a.data +. b.data) "+" in
    out.backward <- (fun () ->
      a.grad <- a.grad +. out.grad;
      b.grad <- b.grad +. out.grad;
    );
    out

  let mul a b =
    let out = create (a.data *. b.data) "*" in
    out.backward <- (fun () ->
      a.grad <- a.grad +. b.data *. out.grad;
      b.grad <- b.grad +. a.data *. out.grad;
    );
    out
end
