#' Gen/Up desc and docs
devtools::document("package_dir")

#' Make checks and fix problems by its hint
devtools::check("package_dir")

#' Build tarball into a dest path such as the parent dir
devtools::build("package_dir", path = "..")

#' knows by: https://devtools.r-lib.org/reference/check.html
