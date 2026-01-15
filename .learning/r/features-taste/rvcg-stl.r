
#: prepare an .stl file ...
stl_path = './NieR Automata - 2B - Swimsuit Blindfold.stl' # 130,916,884 Bytes

#: read
mesh = stl_path |> Rvcg::vcgImport()
mesh = stl_path |> Rvcg::vcgImport(clean = T) # ..same
#> Removed 6546120 duplicate 0 unreferenced vertices and 0 duplicate faces

#: read params ref
stl_path |> 
	Rvcg::vcgImport(
		updateNormals = F, 
		readcolor = T, 
		clean = T, 
		silent = F)

#: save
mesh |> Rvcg::vcgStlWrite('./new-ascii.stl')
mesh |> Rvcg::vcgStlWrite('./new-bin.stl', binary = T)

#: show ref
mesh |> 
  rgl::wire3d(
		col = 'skyblue', 
		override = rgl::open3d() |> 
			rgl::set3d(silent = F) |> 
			magrittr::'%>%'((\ (a, b) b) (T)))

#: read, write, show - ref
rvcg.stl_rws = function (stl_path) stl_path |> 
	Rvcg::vcgImport(
		updateNormals = F, 
		readcolor = T, 
		clean = T, 
		silent = F) |> 
	magrittr::'%T>%'(Rvcg::vcgStlWrite(
		filename = paste('(rvcg)', stl_path), 
		binary = T)) |> 
	magrittr::'%T>%'(rgl::wire3d(
		col = 'skyblue', 
		override = rgl::open3d() |> 
			rgl::set3d(silent = F) |> 
			magrittr::'%>%'((\ (a, b) b) (T)))) |> 
	base::identity()

#: for this demo file stl_path, the saved file
#:  has same Bytes large with the original file, and
#:  it's able to show on rgl wire render.
#:  You can just try on another .stl model. :D
