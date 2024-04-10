module Neuron = struct
  type t = {
    data : float;
    mutable grad : float;
    mutable backward : unit -> unit;

    operator : string;
    dependencies : t list;
  }

  let data base = base.data
  let grad base = base.grad
  let dependencies base = base.dependencies

  let create ?(op="n/a") ?(deps=[]) dt = { 
    data = dt;
    grad = 0.;
    backward = (fun () -> ());
    operator = op;
    dependencies = deps;
  }

  let add base partner =
    let resultant = create ~op:"+" ~deps:[base; partner] (base.data +. partner.data) in

    resultant.backward <- (fun () ->
      base.grad <- base.grad +. resultant.grad;
      partner.grad <- partner.grad +. resultant.grad;
    );
    resultant

  let mul base partner =
    let resultant = create ~op:"*" ~deps:[base; partner] (base.data *. partner.data) in

    resultant.backward <- (fun () ->
      base.grad <- base.grad +. partner.data *. resultant.grad;
      partner.grad <- partner.grad +. base.data *. resultant.grad;
    );
    resultant

  let exp base exponent =
    let resultant = create ~op:"**" ~deps:[base] (base.data ** exponent) in

    resultant.backward <- (fun () ->
      base.grad <- base.grad +. exponent *. (base.data ** (exponent -. 1.)) *. resultant.grad;
    );
    resultant

(* these are all the operator overloadings we need to associate with each of the binary operators *)
  let ( + ) = add
  let ( * ) = mul
  let ( ** ) = exp

  let relu base =
    let resultant = create ~op:"relu" ~deps:[base] (max 0. base.data) in

    resultant.backward <- (fun () ->
      base.grad <- base.grad +. (if base.data > 0. then resultant.grad else 0.);
    );
    resultant

  let backpropagate base =
    (* we topologically sort all the connected nodes from the base node *)
    (* the output list is already reversed i.e. right to left *)
    let rec sort_topologically visited resultant candidate =
      if not (List.memq candidate visited) then
        let visited = candidate :: visited in
        let visited, resultant =
          List.fold_left (fun (visited, resultant) dependent ->
            sort_topologically visited resultant dependent
          ) (visited, resultant) candidate.dependencies 
        in
        (visited, candidate :: resultant)
      else
        (visited, resultant)
    in
    let _, resultant = sort_topologically [] [] base in

    (* this is the neutral gradient the base node start passing down *)
    base.grad <- 1.0;

    (* now we go backward from end-mouth of the graph to the connected start nodes *)
    (* and propagate the gradient changes *)
    List.iter (fun v -> v.backward ()) (resultant)
end
