# GazeDispersion.jl
[![Build status](https://ci.appveyor.com/api/projects/status/i9mxv6ao6wm1ydm4?svg=true)](https://ci.appveyor.com/project/mmagnuski/gazedispersion-jl)  [![Build Status](https://travis-ci.org/mmagnuski/GazeDispersion.jl.svg?branch=master)](https://travis-ci.org/mmagnuski/GazeDispersion.jl)  [![codecov.io](https://codecov.io/github/mmagnuski/GazeDispersion.jl/coverage.svg?branch=master)](https://codecov.io/github/mmagnuski/GazeDispersion.jl?branch=master)  
computes gaze dispersion according to `Christoforou, Christou-Champi, Constantinidou, Theodorou, 2015`

## Installation
```julia
Pkg.clone("https://github.com/mmagnuski/GazeDispersion.jl.git")
```

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
