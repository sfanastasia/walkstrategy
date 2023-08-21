using WalkingSim
using Test

@testset "Basic simulation" begin
    Nxtest = 3
    Wtest = 3
    Ltest = rand(Bool, Nxtest) |> BitVector
    @test WalkingSim.coordstep(9, 0, Nxtest, Wtest, Ltest, 1) == (10, 0)
    @test WalkingSim.coordstep(9, 1, Nxtest, Wtest, Ltest, 1) == (10, 1)
    Ltest[2] = true
    @test WalkingSim.coordstep(7, 0, Nxtest, Wtest, Ltest, 2) == (8, 0)
    Ltest[2] = false
    @test WalkingSim.coordstep(7, 0, Nxtest, Wtest, Ltest, 2) == (7, 1)
    @test WalkingSim.coordstep(8, 0, Nxtest, Wtest, Ltest, 2) == (8, 1)
    @test WalkingSim.coordstep(8, 0, Nxtest, Wtest, Ltest, 1) == (9, 0)
    Ltest[2] = true
    @test WalkingSim.coordstep(7, 0, Nxtest, Wtest, Ltest, 1) == (8, 0)

    # has to cross along y if last block reached
    @test WalkingSim.coordstep(40, 0, 10, 3, rand(Bool, 10) |> BitVector, 1) == (40, 1)
end
