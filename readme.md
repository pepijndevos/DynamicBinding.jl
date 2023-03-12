# DynamicBinding.jl

Basically Clojure's [binding](https://clojuredocs.org/clojure.core/binding).

```
julia> using DynamicBinding

julia> a = Binding(1)
Binding{Int64}(1)

julia> test() = a[]
test (generic function with 1 method)

julia> binding(a => 2) do
           test()
       end
2

julia> test()
1
```