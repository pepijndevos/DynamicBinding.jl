module DynamicBinding

struct Binding{T}
    root::T
end

function Base.getindex(b::Binding{T}) where {T}
    try
        task_local_storage(b)[end]
    catch
        b.root
    end
end

function Base.push!(b::Binding{T}, val::T) where {T}
    tls = task_local_storage()
    if haskey(tls, b)
        push!(tls[b], val)
    else
        tls[b] = T[val]
    end
end

function Base.pop!(b::Binding{T}) where {T}
    pop!(task_local_storage(b))
end

function binding(f, kwargs...)
    for (k,v) in kwargs
        push!(k, v)
    end
    try
        return f()
    finally
        for (k, _) in kwargs
            pop!(k)
        end
    end
end

export Binding, binding

end # module DynamicBinding
