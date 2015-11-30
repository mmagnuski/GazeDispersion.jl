using Base.Test
using GazeDispersion

et_small = [0.1 0.1; 0.2 0.2]
@test GazeDispersion.all_euclidist(et_small, et_small) == (2 * 0.1414213562373095)/4

# window tests
@test win(0.25, 0.05, sf=1000) == GazeDispersion.sample_window(1, 250, 50)