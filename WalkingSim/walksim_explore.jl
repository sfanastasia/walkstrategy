using DataFrames, Statistics, CairoMakie, Latexify
using WalkingSim

Nruns = 100_000

# block length effect (vary W) keeping total distance constant:
# Nx(W + 1) = D = const
np = [WalkingSim.intnxw(D) for D in 1:128]
findmax(np) # D = 120
#np[120]

# Table for block length effect
df = DataFrame(W = [2, 3, 4, 5, 7], Nx = [40, 30, 24, 20, 15])
df[:, :D] = (1 .+ df[:, :W]) .* df[:, :Nx]
df[!,:R1av] = missings(Float64, nrow(df))
df[!,:R1std] = missings(Float64, nrow(df))
df[!,:R2av] = missings(Float64, nrow(df))
df[!,:R2std] = missings(Float64, nrow(df))
for j in 1:nrow(df)
    # strategy 1
    vt = repeatwalksim(Nruns, df[j, :Nx], df[j, :W], 1)
    df[j, :R1av] = mean(vt)
    df[j, :R1std] = std(vt)
    # strategy 2
    vt = repeatwalksim(Nruns, df[j, :Nx], df[j, :W], 2)
    df[j, :R2av] = mean(vt)
    df[j, :R2std] = std(vt)
end
show(df)
println("")
#latexify(df, env=:table, fmt = x -> isinteger(x) ? x : round(x, sigdigits=3))
latexify(df, env=:table) |> display
println("")

CairoMakie.activate!(type = "pdf")

fig_block_length = Figure()
Axis(fig_block_length[1, 1], xlabel = "W", ylabel = "Relative Delay")
sca1 = scatterlines!(df[:, :W], df[:, :R1av], color = :red)
sca2 = scatterlines!(df[:, :W], df[:, :R2av], color = :blue)
xlims!(1, 8)
Legend(fig_block_length[1, 2], [sca1, sca2], ["Strategy 1", "Strategy 2"])
save("output/fig_block_length.pdf", fig_block_length, pt_per_unit = 2)


# number of blocks effect with strategy comparison
function fRav(Nx::Int64, W::Int64, strat::Int64)
    vt = repeatwalksim(Nruns, Nx, W, strat)
    return mean(vt)
end
function plot_nblocks(W::Int64)
    fig_nblocks = Figure()
    vNx = 2:50
    Axis(fig_nblocks[1, 1], xlabel = "Number of Blocks", ylabel = "Relative Delay", title = "W = $(W)")
    sc1 = scatterlines!(vNx, [fRav(Nxi, W, 1) for Nxi in vNx], color = :red)
    sc2 = scatterlines!(vNx, [fRav(Nxi, W, 2) for Nxi in vNx], color = :blue)
    xlims!(0, 52)
    ylims!(1.05, 1.27)
    Legend(fig_nblocks[1,2], [sc1, sc2], ["Strategy 1", "Strategy 2"])
    save("output/fig_nblocks_$(W).pdf", fig_nblocks, pt_per_unit = 2)
end
plot_nblocks(2)
plot_nblocks(3)
plot_nblocks(4)
plot_nblocks(5)
plot_nblocks(6)
plot_nblocks(7)
