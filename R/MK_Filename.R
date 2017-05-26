#'Make Filenames for FARS data
#'
#'This is a simple function that creates a name for compressed files of the
#'FARS data.
#'
#'@param year A numerical value representing the year of the desired data.
#'
#'@details The function coerces the argument 'year' to an integer value,
#'posteriorly builds an string for the default name of the compressed data using
#'sprintf.
#'Using other imputs will result in coercion to NA's and therefore, filenames containing
#'NA's.
#'
#'@return The function returns an string with the filename of the FARS data of the
#'corresponding year.
#'
#'@examples
#'\dontrun{make_filename(1994)}
#'\dontrun{make_filename(2013)}
#'
#'@export
make_filename <- function(year) {
        year <- as.integer(year)
        sprintf("accident_%d.csv.bz2", year)
}
