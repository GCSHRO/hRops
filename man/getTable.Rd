% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getTable.R
\name{getTable}
\alias{getTable}
\title{Get data from AS400 table}
\usage{
getTable(Table_Name)
}
\arguments{
\item{Table_Name}{Name of the table to query (use tab completion to see valid options)}
}
\value{
A dataframe containing the requested table data
}
\description{
Get data from AS400 table
}
\examples{
assignment_data <- getTable(ASSIGNMENT_VIEW)
site_data <- getTable(SITE)
}
