#' Get the assignment table from HRMS
#' @return dataframe
#' @export

getAssignment <- function() {
  if (!exists("hr_domino")) {
    hr_domino_connect()
  }
  assignment_tbl <- dplyr::tbl(hr_domino, dbplyr::in_schema("HRMSGCS", "ASSIGNMENT_VIEW"))
  assignment_view <- as.data.frame(assignment_tbl)
  return(assignment_view)
}