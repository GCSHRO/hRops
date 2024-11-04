#' Valid tables and their corresponding schemas
#' @export
valid_tables <- c(
  EMPIDUIDF = "HRMSGCS",
  ASSIGNMENT_VIEW = "HRMSGCS",
  POSTL4 = "HRMSGCS",
  POSITION_BUDGET_VW = "HRMSLEA",
  ASSIGNMENTS_ALL_V = "HRMSLEA",
  SEPARATION = "HRMSLEA",
  POSITIONASSIGN_ALL_V = "HRMSLEA",
  SITE = "HRMSSHR",
  LICENSE_AREA = "HRMSSHR",
  LICENSE_AREA_DOM = "HRMSSHR"
)

#' Get data from AS400 table
#' @export
#' @param Table_Name Name of the table to query (use tab completion to see valid options)
#' @return A dataframe containing the requested table data
#' @examples
#' assignment_data <- getTable(ASSIGNMENT_VIEW)
#' site_data <- getTable(SITE)
getTable <- function(Table_Name) {
  if (!exists("hr_domino")) {
    hr_domino_connect()
  }
  
  schema_name <- valid_tables[Table_Name]
  
  tbl <- dplyr::tbl(hr_domino, 
                    dbplyr::in_schema(schema = schema_name, 
                                      table = Table_Name))
  
  output <- as.data.frame(tbl)
  return(output)
}