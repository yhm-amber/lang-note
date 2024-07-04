#' RDS format (extension name usually: `.rds`) data's load (by function `base::readRDS`) have no side effect for the environment, it gives the saved (by function `base::saveRDS`) object as a load function's return.
#' 
#' But RData format (extension name usually: `.rda` `.RData`) don't, no matter comes from value save (by function `base::save`) or whole environment save (by function `base::save.image`), its load (by function `base::load`) will change your current environment inevitably, and the load function's return is just a character vector and the names of value just loaded is in it, these are the value which just be added or changed.
#' 

#' see: https://stackoverflow.com/questions/21370132/what-are-the-main-differences-between-r-data-files
#' 
