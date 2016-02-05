import Base.+

abstract Window

type time_window <: Window
	start::AbstractFloat
	width::AbstractFloat
	step::AbstractFloat
end

type sample_window <: Window
	start::Int
	width::Int
	step::Int
end

function tosamples(w::time_window; sf::Union{AbstractFloat, Int}=1000)
	params = round(Int, [w.start, w.width, w.step] * sf)
	return sample_window(params...)
end

function +(w::Window, val::Integer)
	w.start = w.start + w.step * val
	return w
end

function win(width::AbstractFloat, step::AbstractFloat;
	sf::Union{AbstractFloat, Int}=1000)

	w = tosamples(time_window(0., width, step), sf=sf)
	w.start = 1
	return w
end

function get_data{T<:AbstractFloat}(et::Array{T,2},
		w::sample_window)
	n_subj = round(Int, size(et, 2) / 2)
	n_samples = size(et, 1)
	dat = et[w.start:w.start+w.width-1, :]
	return [dat[:,1:2:end][:] dat[:,2:2:end][:]]
end

function get_random_data{T<:AbstractFloat}(et::Array{T,2},
		w::sample_window)
	n_subj = round(Int, size(et, 2) / 2)
	n_samples = size(et, 1)
	window_range = 1:w.step:n_samples
	data = zeros(eltype(et), n_subj*w.width, 2)
	window_start = rand(window_range, n_subj)

	for (s, start) in enumerate(window_start)
		data[s*(w.width-1)+1, :] = et[start:start+w.width-1,
			s*2-1:s*2]
	end
end

function window_steps{T<:AbstractFloat}(et::Array{T,2},
		w::sample_window)
	return floor(Int, (size(et,1) - w.width) / w.step) + 1
end
