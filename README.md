## smolgrad.ml
Smolgrad is a very simple and educational project around the constructs of a neural network. It implements algorithmic (or automatic) differentiation for some common binary operators, can dynamically build out the graph out of an algebraic expression and then apply backpropagation on that graph. Additionally, it also abstracts the concept of a neuron, stacks up those neurons into layers and propagates input through the network. It is written in OCaml, for the fun (and pun) of it.

Needless to say, it is very rudimentary at the moment and doesn't implement training of the weights and biases. However that is in plan, along with exploration of some other architectures! Of course, it is an inspiration from legendary projects like [micrograd](https://github.com/karpathy/micrograd), [tinygrad](https://github.com/tinygrad/tinygrad) and such.

### Experiment
This is built as a library, but not yet published. To experiment, you can tweak the tests, or try importing the modules directly (into say a utop REPL).

- The project is packaged using Nix, so you're in luck if you happen to have the setup. `nix develop` is all you need.
- Otherwise, you need to setup the OCaml tooling on your system. The project uses Dune as the build system and Opam for package management.

### TODO

- [ ] Implement training.
- [ ] Use a plotting library like [oplot](https://github.com/sanette/oplot) to visualize training and output for simple classification scenarios.
- [ ] Use a graph library like [ocamlgraph](https://anwarmamat.github.io/ocaml/ocamlgraph) to visualize the DAG generated out of variable operations.
