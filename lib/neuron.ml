module Neuron = struct
  type t = {
    data : float;
    mutable grad : float;
    mutable backward : unit -> unit;

    operator : string;
    dependents : t list;
  }

  let create dt op deps = { 
    data = dt;
    grad = 0.;
    backward = (fun () -> ());
    operator = op;
    dependents = deps;
  }

  let add base partner =
    let resultant = create (base.data +. partner.data) "+" [base; partner] in

    resultant.backward <- (fun () ->
      base.grad <- base.grad +. resultant.grad;
      partner.grad <- partner.grad +. resultant.grad;
    );
    resultant

  let mul base partner =
    let resultant = create (base.data *. partner.data) "*" [base; partner] in

    resultant.backward <- (fun () ->
      base.grad <- base.grad +. partner.data *. resultant.grad;
      partner.grad <- partner.grad +. base.data *. resultant.grad;
    );
    resultant

  let exp base exponent =
    let resultant = create (base.data ** exponent) "**" [base] in

    resultant.backward <- (fun () ->
      base.grad <- base.grad +. exponent *. (base.data ** (exponent -. 1.)) *. resultant.grad;
    );
    resultant

  let relu base =
    let resultant = create (max 0. base.data) "relu" [base] in

    resultant.backward <- (fun () ->
      base.grad <- base.grad +. (if base.data > 0. then resultant.grad else 0.);
    );
    resultant

  let backpropagate base =
    (* we topologically sort all the connected nodes from the base node *)
    let rec sort_topologically visited resultant candidate =
      if not (List.mem candidate visited) then
        let visited = candidate :: visited in
        let visited, resultant =
          List.fold_left (fun (visited, resultant) dependent ->
            sort_topologically visited resultant dependent
          ) (visited, resultant) candidate.dependents 
        in
        (visited, candidate :: resultant)
      else
        (visited, resultant)
    in
    let _, resultant = sort_topologically [] [] base in

    base.grad <- 1.0;

    (* now we go backward from end-mouth of the graph to the connected start nodes *)
    (* and propagate the gradient changes *)
    List.iter (fun v -> v.backward ()) (List.rev resultant)
end
