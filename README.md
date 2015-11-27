# GazeDispersion.jl
computes gaze dispersion according to `Christoforou, Christou-Champi, Constantinidou, Theodorou, 2015`

## Using GazeDispersion

```julia
using GazeDispersion

# create a window of 250 ms long, with 50 ms step 
window = win(0.25, 0.05, sf=250)

# compute GazeDispersion for your data
# (the data should be nsamples by (x,y) * nsubjects)
gaze_dispersion = dispersion_within(et_data, window)

# if you have data for first and second viewings you can
# use dispersion_across:
gaze_dispersion = dispersion_across(et_data1, et_data2, window)
```
