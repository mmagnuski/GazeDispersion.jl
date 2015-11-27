# GazeDispersion - computes gaze dispersion for eye-tracking data
# eye-tracking data is assumed to be in format:
# (x, y) * subjects x timeframes

module GazeDispersion

export compute_dispersion, win

# euclidean distance:
# v, w - two x,y x time vectors:
function all_euclidist(v::Array{Float64,2}, w::Array{Float64,2})
	res = 0.
	N = length(v)
	for i = 1:N, j = 1:N
		res += sqrt(sum((v[i,:] - w[j,:])^2))
	end
	res /= N^2
	return res
end

include('windows.jl')

compute_dispersion(et::Array{Float64,2}, win::sample_window)
	win_steps = window_steps(et, win)
	dispersion = zeros(Float64, win_steps)
	for w = 1:win_steps
		dat = get_data(et, win)
		dispersion[w] = all_euclidist(dat, dat)
	end
	return dispersion
end

end