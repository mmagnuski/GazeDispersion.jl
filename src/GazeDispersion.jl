# GazeDispersion - computes gaze dispersion for eye-tracking data
# eye-tracking data is assumed to be in format:
# (x, y) * subjects x timeframes


module GazeDispersion

export dispersion_within, dispersion_across, win

# include
include("windows.jl")

# euclidean distance:
# v, w - two x,y x time vectors:
function all_euclidist{T<:AbstractFloat}(v::Array{T,2},
		w::Array{T,2})
	res = 0.
	N = size(v, 1)
	for i = 1:N, j = 1:N
		res += sqrt(sum((v[i,:] - w[j,:]).^2))
	end
	res /= N^2
	return res
end


# dispersion within viewings
function dispersion_within{T<:AbstractFloat}(et::Array{T,2},
		win::sample_window)
	win_steps = window_steps(et, win)
	dispersion = zeros(eltype(et), win_steps)
	for s = 1:win_steps
		dat = get_data(et, win)
		dispersion[s] = all_euclidist(dat, dat)
		win += 1
	end
	return dispersion
end


# dispersion across viewings
function dispersion_across{T<:AbstractFloat}(V::Array{T,2},
		W::Array{T,2}, win::sample_window)

	win_steps = window_steps(V, win)
	dispersion = zeros(eltype(V), win_steps)
	for s = 1:win_steps
		v = get_data(V, win)
		w = get_data(W, win)
		dispersion[s] = all_euclidist(v, w)
		win += 1
	end
	return dispersion
end


end