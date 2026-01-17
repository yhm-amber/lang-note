
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





#: import & write (i.e., export)

nier2b.path = 'NieR Automata - 2B - Kneeling - V-Neck Swimsuit Blindfold.stl'
fs::file_size(nier2b.path) #: 130,916,884 Bytes
nier2b = nier2b.path |> 
	Rvcg::vcgImport(
		updateNormals = F, 
		readcolor = T, 
		clean = T, 
		silent = F)

nier2b |> Rvcg::vcgWrlWrite(filename = 'nier2b', writeCol = T, writeNormals = T) #: nier2b.wrl saved - 104,901,894 Bytes
nier2b |> Rvcg::vcgObjWrite(filename = 'nier2b', writeNormals = T) #: nier2b.obj saved - 108,505,333 Bytes
nier2b |> Rvcg::vcgOffWrite(filename = 'nier2b') #: nier2b.off saved - 97,802,332 Bytes
nier2b |> Rvcg::vcgPlyWrite(filename = 'nier2b', binary = T, addNormals = F, writeCol = T, writeNormals = T) #: nier2b.ply saved - 49,745,230 Bytes
nier2b |> Rvcg::vcgStlWrite(filename = 'nier2b', binary = T) #: nier2b.stl saved - 130,916,884 Bytes

#: Verify the results of these vcg-write
base::c('Wrl', 'Obj', 'Off', 'Ply', 'Stl') |> 
	#: pasting file name
	purrr::map_chr(~ 'nier2b' |> fs::path_ext_set(base::tolower(.x))) |> 
	#: getting file size from fs
	fs::file_size() |> 
	#: format as Bytes
	purrr::map_chr(~ .x |> base::prettyNum(big.mark = ',') |> base::paste('Bytes')) |> 
	#: Mark Dlist for disply
	magrittr::'%T>%'({ base::class(.) <- 'Dlist' }) |> 
	#: Show in Dlist style
	base::print()
#| nier2b.wrl                  104,901,894 Bytes
#| nier2b.obj                  108,505,333 Bytes
#| nier2b.off                  97,802,332 Bytes
#| nier2b.ply                  49,745,230 Bytes
#| nier2b.stl                  130,916,884 Bytes

#: read again ...
#{: unsupported :}# nier2b.wrl <- 'nier2b.wrl' |> Rvcg::vcgImport(updateNormals = F, readcolor = T, clean = T, silent = F) #: will error, not support wrl.
nier2b.obj <- 'nier2b.obj' |> Rvcg::vcgImport(updateNormals = F, readcolor = T, clean = T, silent = F) #: > utils::object.size(nier2b.obj) #> 73305600 bytes
nier2b.off <- 'nier2b.off' |> Rvcg::vcgImport(updateNormals = F, readcolor = T, clean = T, silent = F) #: > utils::object.size(nier2b.off) #> 73305600 bytes
nier2b.ply <- 'nier2b.ply' |> Rvcg::vcgImport(updateNormals = F, readcolor = T, clean = T, silent = F) #: > utils::object.size(nier2b.ply) #> 73305600 bytes
nier2b.stl <- 'nier2b.stl' |> Rvcg::vcgImport(updateNormals = F, readcolor = T, clean = T, silent = F) #: > utils::object.size(nier2b.stl) #> 73305600 bytes

#' @title Compare vcg mesh using {diffdf} under {data.table} engine.
#' @name vcg_dtdiff
#' @description 
#' Compare vcg mesh using {diffdf} under {data.table} engine. Maybe quicker than normal way.
#' @param mesh_a a vcg mesh to join a comparison
#' @param mesh_b another vcg mesh to join this comparison
#' @return a list that contains the result(s) of {diffdf}.
#' 
vcg_dtdiff = function (
		mesh_a, 
		mesh_b) 
{
	#: class verify & warn
	{
		if (!isTRUE(mesh_a |> inherits('mesh3d'))) usethis::ui_oops("Class error in mesh a: {usethis::ui_value(class(mesh_a))} - {usethis::ui_field('mesh3d')} requires.")
		if (!isTRUE(mesh_b |> inherits('mesh3d'))) usethis::ui_oops("Class error in mesh b: {usethis::ui_value(class(mesh_b))} - {usethis::ui_field('mesh3d')} requires.")
	}
	
	#: transpose for a quicker diff
	{
		.a = mesh_a |> purrr::map(~ data.table::as.data.table(base::t(.x)))
		.b = mesh_b |> purrr::map(~ data.table::as.data.table(base::t(.x)))
	}
	
	#: analysis
	{
		entrys_a.more = names(.a) |> base::setdiff(names(.b))
		entrys_b.more = names(.b) |> base::setdiff(names(.a))
		entrys_intersect = names(.a) |> base::intersect(names(.b)) |> magrittr::'%T>%'({ names(.) <- . })
		if (length(entrys_a.more) > 0) usethis::ui_warn("More entrys in mesh a: {usethis::ui_value(entrys_a.more)}")
		if (length(entrys_b.more) > 0) usethis::ui_warn("More entrys in mesh b: {usethis::ui_value(entrys_b.more)}")
		entrys_ab.diff = if (length(entrys_intersect) > 0) {
			usethis::ui_info("Comparing entrys in mesh a & b: {usethis::ui_field(entrys_intersect)}")
			entrys_intersect |> purrr::map(~ .a[[.x]] |> diffdf::diffdf(.b[[.x]]))
		}
	}
	
	#: res return
	{
		rm(.a,.b)
		list(
			a_more = glue::as_glue(entrys_a.more), 
			b_more = glue::as_glue(entrys_b.more), 
			ab_diff = entrys_ab.diff)
	}
}

#: case of same (just for a test.)
nier2b.obj |> vcg_dtdiff(nier2b.obj)
#| ℹ Comparing entrys in mesh a & b: vb, it, material
#| $a_more
#| 
#| $b_more
#| 
#| $ab_diff
#| $ab_diff$vb
#| No issues were found!
#| 
#| $ab_diff$it
#| No issues were found!
#| 
#| $ab_diff$material
#| No issues were found!
#| 

#: real compare
diff.stl_obj = nier2b.stl |> vcg_dtdiff(nier2b.obj)
diff.stl_off = nier2b.stl |> vcg_dtdiff(nier2b.off)
diff.stl_ply = nier2b.stl |> vcg_dtdiff(nier2b.ply)
diff.ply_obj = nier2b.ply |> vcg_dtdiff(nier2b.obj)
diff.ply_off = nier2b.ply |> vcg_dtdiff(nier2b.off)
diff.off_obj = nier2b.off |> vcg_dtdiff(nier2b.obj)
diff.0_obj = nier2b |> vcg_dtdiff(nier2b.obj)
diff.0_off = nier2b |> vcg_dtdiff(nier2b.off)
diff.0_ply = nier2b |> vcg_dtdiff(nier2b.ply)
diff.0_stl = nier2b |> vcg_dtdiff(nier2b.stl)

#: logs
#| > diff.stl_obj = nier2b.stl |> vcg_dtdiff(nier2b.obj)
#| ℹ Comparing entrys in mesh a & b: vb, it, material
#| Warning message:
#| In diffdf::diffdf(.a[[.x]], .b[[.x]]) : 
#| Not all Values Compared Equal
#| > diff.stl_off = nier2b.stl |> vcg_dtdiff(nier2b.off)
#| ℹ Comparing entrys in mesh a & b: vb, it, material
#| Warning message:
#| In diffdf::diffdf(.a[[.x]], .b[[.x]]) : 
#| Not all Values Compared Equal
#| > diff.stl_ply = nier2b.stl |> vcg_dtdiff(nier2b.ply)
#| ℹ Comparing entrys in mesh a & b: vb, it, material
#| > diff.ply_obj = nier2b.ply |> vcg_dtdiff(nier2b.obj)
#| ℹ Comparing entrys in mesh a & b: vb, it, material
#| Warning message:
#| In diffdf::diffdf(.a[[.x]], .b[[.x]]) : 
#| Not all Values Compared Equal
#| > diff.ply_off = nier2b.ply |> vcg_dtdiff(nier2b.off)
#| ℹ Comparing entrys in mesh a & b: vb, it, material
#| Warning message:
#| In diffdf::diffdf(.a[[.x]], .b[[.x]]) : 
#| Not all Values Compared Equal
#| > diff.off_obj = nier2b.off |> vcg_dtdiff(nier2b.obj)
#| ℹ Comparing entrys in mesh a & b: vb, it, material
#| Warning message:
#| In diffdf::diffdf(.a[[.x]], .b[[.x]]) : 
#| Not all Values Compared Equal
#| > diff.0_obj = nier2b |> vcg_dtdiff(nier2b.obj)
#| ℹ Comparing entrys in mesh a & b: vb, it, material
#| Warning message:
#| In diffdf::diffdf(.a[[.x]], .b[[.x]]) : 
#| Not all Values Compared Equal
#| > diff.0_off = nier2b |> vcg_dtdiff(nier2b.off)
#| ℹ Comparing entrys in mesh a & b: vb, it, material
#| Warning message:
#| In diffdf::diffdf(.a[[.x]], .b[[.x]]) : 
#| Not all Values Compared Equal
#| > diff.0_ply = nier2b |> vcg_dtdiff(nier2b.ply)
#| ℹ Comparing entrys in mesh a & b: vb, it, material
#| > diff.0_stl = nier2b |> vcg_dtdiff(nier2b.stl)
#| ℹ Comparing entrys in mesh a & b: vb, it, material

#: i.e., original stl could totally same as vcg-write of stl & ply.
#:  wrl cannot import again, obj & off would not totally same
#:  during vcg-write then import again.
#: The .ply file have a most small size here. :D

