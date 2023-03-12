using DynamicBinding
using Test

a = Binding(1)
b = Binding(2.0)

@testset "bindings" begin
    @test a[] == 1
    @test b[] == 2.0

    binding(a => 2) do
        @test a[] == 2
        @test b[] == 2.0
        binding(b => 3.0) do 
            @test a[] == 2
            @test b[] == 3.0
        end
    end

    @test_throws MethodError push!(a, 2.0)

    try
        binding(a => 5) do
            throw(ErrorException())
        end
    catch
    end
    @test a[] == 1
    @test b[] == 2.0
end