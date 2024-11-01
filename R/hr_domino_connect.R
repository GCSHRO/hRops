#' Connect to HR Domino using environment variables
#' Username and password will be requested if they are not found
#' @return A connection to the AS400 called 'hr_domino'
#' @export
hr_domino_connect <- function() {
  username <- Sys.getenv("as400_username")
password <- Sys.getenv("as400_password")
if (username=="") {
  print("To prevent future prompts, create an environment variable named 'as400_username'")
  username <- readline(prompt="Please type your AS400 Username:")
}

if (username=="") {
  print("To prevent future prompts, create an environment variable named 'as400_password'")
  username <- readline(prompt="Please type your AS400 Password:")
}

assign("hr_domino",DBI::dbConnect(odbc::odbc(), "hr_domino", uid = username,
                       pwd = password),envir= .GlobalEnv)
}
