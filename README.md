# Walking strategy analysis

## San Francisco Science Fair 2023

**First Place** in 7th grade Physical Science

**Walking through the City: Which strategy is faster?** by Anastasia Paramonova

When selecting a route to walk from point A to point B in the city, multiple options are typically available. One can choose city streets with longer or shorter blocks and decide
when to cross the street depending on the traffic light pattern. I was arguing with my
father about whether strategy details affected travel time. To clarify this issue, I tested a
hypothesis stating that the choice of longer versus shorter blocks combined with the choice
of when to cross to the other side of the street has a noticeable influence on the overall
travel time. I used computer simulations to investigate how walking time is affected
by strategy choices. I developed a computer program to simulate potential routes with
random traffic light switching, which accounts for realistic traffic light scenarios along
the route chosen. In the model, I assumed that there was a traffic light at every block.
Repeated runs of computer simulations enabled me to identify the noticeable travel time
difference between strategies and indicate the most effective city walking strategy from a
travel time perspective, providing insights valuable in everyday life.

## Simulation program

Structured as a Julia package. Analysis performed in [walksim_explore.jl](./WalkingSim/walksim_explore.jl) script.

## Running tests

    using WalkingSim
    import Pkg
    Pkg.test()

## Science Fair submission

Submitted [report](./SF_Science_Fair_2023_Report.pdf) and presented [poster](./SF_Science_Fair_2023_Poster_pages.pdf).

