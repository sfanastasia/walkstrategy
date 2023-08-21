module WalkingSim

function repeatwalksim(Nruns::Int64, Nx::Int64, W::Int64 = 3, strategy::Int64 = 1)
    vt = [walksim(Nx, W, strategy) for n in 1:Nruns]
    return vt
end

"""
`W` is the ratio of block walking time to light switch time.
Basic time unit is the light switch time.
Basic distance unit is crosswalk length. Full block requires
`W` distance units + 1 for after-block crosswalk.

`L` represents lights states; `true` is green.

`strategy` options:
(1) crossing only when encountering red light in x direction
(2) crossing as soon as there is green light in y direction
"""
function walksim(Nx::Int64, W::Int64 = 3, strategy::Int64 = 1)
    x = 0
    y = 0
    t = 0
    L = rand(Bool, Nx) |> BitVector

    doshli = false
    while !doshli
        t = t + 1
        # all lights switched along x
        L = .!L

        x, y = coordstep(x, y, Nx, W, L, strategy)

        # check if reached destination
        doshli = (x > 0.999*Nx*(W + 1)) && (y > 0.999)

        ### temp
        #println("Timestep $(t) x = $(x) y = $(y) doshli $(doshli)")
        #println(L)
    end

    return t/(Nx*(W + 1))
end

"""
Determine new coordinates for a time step.
"""
function coordstep(x::Int64, y::Int64, Nx::Int64, W::Int64, L::BitVector, strategy::Int64)
    xnew = x
    ynew = y

    # determine portion of the block for the current x
    blockpart = x % (W + 1)
    if (x < 1) || (0 < blockpart < W)
        xnew = x + 1
    else
        if (x == Nx*(1 + W)) && (y < 1)
            # reached the last x-block: need to cross y
            return x, y + 1
        end
        
        # possibly y-movement: light state index
        iL = fld(x, W + 1)
        if blockpart == 0
            if (strategy == 2) && (y < 1) && (!L[iL])
                # crossing along y
                ynew = y + 1
            else
                xnew = x + 1
            end
        end
        if blockpart == W
            # end of block x-wise before crosswalk
            if L[iL+1]
                xnew = x + 1
            elseif y < 1
                # crossing along y regardless of strategy
                ynew = y + 1
            end
        end
    end
    
    return xnew, ynew
end

export walksim, repeatwalksim

end # module WalkingSim