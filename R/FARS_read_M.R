#'Read data from multiple years
#'
#'This function reads the FARS data of multiple years, and proceses the
#'number of incidents per month and year.
#'
#'@param years A numeric vector or a list containing the years of the
#'data desired.
#'
#'@details This function uses the elements on the vector or list \code{years}
#'to create filenames through \code{\link{make_filename}} and read each file with
#'\code{\link{fars_read_years}}. Then selects the month and year columns of the data.
#'A mechanism to detect invalid years is implemented to display
#'warnings when invalid values are used as input.
#'
#'@return The function returns a list of data frames containing the loaded data.
#'In case invalid outputs are used, the returned value is NULL, prior printing a
#'warning on the console.
#'
#'@examples
#'\dontrun{a <- c(1998, 2001, 2005)}
#'\dontrun{data <- fars_read_years(a)}
#'\dontrun{a <- list(1998, 2001, 2005)}
#'\dontrun{data <- fars_read_years(a)}
#'
#'@import magrittr
#'
#'@export
fars_read_years <- function(years) {
        lapply(years, function(year) {
                file <- make_filename(year)
                tryCatch({
                        dat <- fars_read(file)
                        dplyr::mutate(dat, year = year) %>%
                                dplyr::select('MONTH', year)
                }, error = function(e) {
                        warning("invalid year: ", year)
                        return(NULL)
                })
        })
}
