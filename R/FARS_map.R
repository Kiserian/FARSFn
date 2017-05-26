#'Plot map based on FARS data
#'
#'This is a complex function that plots the accidents per state in a map.
#'
#'@param state.num A list or numeric vector containing the numeric code of
#'the desired states to plot.
#'@param year A numeric value to indicate the year of the data to plot.
#'
#'@details The function first builds the name of the data file to be read
#'via \link{make_filename()}, and then reads the data with \link{fars_read()}.
#'The state code is converted to an integer, and then is compared to the states
#'present in the data. A mechanism for errors is implemented, the first
#'detects invalid state numbers. Then the function filters the data by the states,
#'and evaluates if there are enough data to plot (>0L). After it, the function plots
#'the map with the desired data.
#'
#'@return In case of success the function returns a map with the desired data.
#'
#'@examples
#'\dontrun{fars_map_state(c(01, 10, 25), 2012)}
#'
#'@export
fars_map_state <- function(state.num, year) {
        filename <- make_filename(year)
        data <- fars_read(filename)
        state.num <- as.integer(state.num)

        if(!(state.num %in% unique(data$STATE)))
                stop("invalid STATE number: ", state.num)
        data.sub <- dplyr::filter(data, STATE == state.num)
        if(nrow(data.sub) == 0L) {
                message("no accidents to plot")
                return(invisible(NULL))
        }
        is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
        is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
        with(data.sub, {
                maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
                          xlim = range(LONGITUD, na.rm = TRUE))
                graphics::points(LONGITUD, LATITUDE, pch = 46)
        })
}
