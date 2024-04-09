module Neuron = struct
  type t = {
    mutable data : float;
    mutable grad : float;
    mutable backward : unit -> unit;

    (* capturing the operator would be useful later when we add some viz *)
    op : string;
    prev : t list;
  }

  let create data operator = { 
    data;
    grad = 0.;
    backward = (fun () -> ());
    op = operator; prev = [];
  }

  let add base partner =
    let resultant = create (base.data +. partner.data) "+" in

    resultant.backward <- (fun () ->
      base.grad <- base.grad +. resultant.grad;
      partner.grad <- partner.grad +. resultant.grad;
    );
    resultant

  let mul base partner =
    let resultant = create (base.data *. partner.data) "*" in

    resultant.backward <- (fun () ->
      base.grad <- base.grad +. partner.data *. resultant.grad;
      partner.grad <- partner.grad +. base.data *. resultant.grad;
    );
    resultant

  let exp base exponent =
    let resultant = create (base.data ** exponent) "**" in

    resultant.backward <- (fun () ->
      base.grad <- base.grad +. exponent *. (base.data ** (exponent -. 1.)) *. resultant.grad;
    )

  let relu base =
    let resultant = create (max 0. base.data) "relu" in

    resultant.backward <- (fun () ->
      base.grad <- base.grad +. (if base.data > 0. then resultant.grad else 0.);
    )
end
