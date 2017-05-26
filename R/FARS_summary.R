#'Summarize Number of Accidents per month and year
#'
#'This function summarizes the number of accident per month and year in the fars data.
#'
#'@inheritParams fars_read_years
#'
#'@details The function compiles the data asked with the param \code{years} using
#'\link{fars_read_years()} and binds each element of the resulting list by rows.
#'Then the function groups the data per month and year and summarizes the number of observations
#'(accidents), per year. Finally, the function makes a contingency table by month and year.
#'
#'@return The function returns a dataframe with n columns (years) and 12 rows (months).
#'The value of each cell corresponds to the number of accidents.
#'
#'@examples
#'\dontrun{fars_summarize_years(2013)}
#'#'\dontrun{ a <- list(1998, 2001, 2005)
#'data <- fars_read_years(a)}
#'
#'
#'@export
fars_summarize_years <- function(years) {
        dat_list <- fars_read_years(years)
        dplyr::bind_rows(dat_list) %>%
                dplyr::group_by(year, MONTH) %>%
                dplyr::summarize(n = n()) %>%
                tidyr::spread(year, n)
}
