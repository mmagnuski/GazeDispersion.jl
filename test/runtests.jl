using Base.Test
using GazeDispersion

et_small = [0.1 0.1; 0.2 0.2]
@test_approx_eq GazeDispersion.all_euclidist(et_small, et_small) (2 * 0.1414213562373095)/4

# window tests
w1 = win(0.25, 0.05, sf=1000)
w2 = GazeDispersion.sample_window(1, 250, 50)
@test all([w1.start, w1.step, w1.width] .== [w2.start, w2.step, w2.width])

w2 + 1
@test w2.start == 51