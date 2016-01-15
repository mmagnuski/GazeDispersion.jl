using Base.Test
using GazeDispersion

et_small = [0.1 0.1; 0.2 0.2]
@test_approx_eq GazeDispersion.all_euclidist(et_small, et_small) (2 * 0.1414213562373095)/4

# window tests
w1 = win(0.25, 0.05, sf=1000)
w2 = GazeDispersion.sample_window(1, 250, 50)
@test all([w1.start, w1.step, w1.width] .== [w2.start, w2.step, w2.width])

@test (w2 + 1).start == 51

w1 = GazeDispersion.sample_window(1, 2, 1)
mat = map(Float64, repmat(collect(1:4)', 3, 1))
dat = GazeDispersion.get_data(mat, w1)
@test all(dat .== map(Float64, [1 2; 1 2; 3 4; 3 4]))

@test GazeDispersion.window_steps(mat, w1) == 2