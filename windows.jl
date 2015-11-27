abstract Window end

type time_window <: Window
	start::AbstractFloat
	width::AbstractFloat
	step::AbstractFloat
end

type sample_window <: Window
	start::Int64
	width::Int64
	step::Int64
end

function tosamples(w::time_window,
	sf=1000::Union(AbstractFloat, Int))

	return sample_window(round(Int, w.start * sf),
		round(Int, w.width * sf), round(Int, w.step * sf))
end

function +(w::Window, val::Integer)
	w.start = w.start + w.step * val
	return w
end

function win(width::AbstractFloat, step::AbstractFloat,
	sf=1000::Union(AbstractFloat, Int))

	w = tosamples(time_window(0., width, step), sf)
	w.start = 1
	return w
end

function get_data(et::Array{Float64,2}, w::sample_window)
	n_subj = round(Int, size(et, 2) / 2)
	n_samples = size(et, 1)
	return reshape(et[w.start:w.start+w.step-1, :],
		[n_subj*n_samples, 2])
end

function window_steps(et::Array{Float64,2}, w::sample_window)
	return round(Int, (size(et,1) - w.width) / w.step) + 1
end
