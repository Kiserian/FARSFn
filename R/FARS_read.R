#'Read FARS data
#'
#'This is a function that reads and loads data in a csv format given a
#'filename. First, the function checks if the filename
#'exists on the working directory. If the filename exists,
#'proceeds to read the data and to format it as a tibble with tbl_df
#'
#'@param filename A character string that corresponds to the
#'filename to be loaded.
#'
#'@return This function returns a tibble dataframe containing the data
#'readed from the file. In case the file name is not found, the
#'function will print an error message to the console.
#'
#'@examples
#'\dontrun{fars_read("fars_accident.csv")}
#'\dontrun{fars_read("accident_2012.csv")}
#'
#'@details This function depends on the following functions:
#'    -read_csv: reads the data on the wd, to the environment.
#'    -tbl_df: transforms readed data into a tbl.
#'
#'@export
fars_read <- function(filename) {
        if(!file.exists(filename))
                stop("file '", filename, "' does not exist")
        data <- suppressMessages({
                readr::read_csv(filename, progress = FALSE)
        })
        dplyr::tbl_df(data)
}
