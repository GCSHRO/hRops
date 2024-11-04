#' Connect to HR Domino using environment variables
#' Username and password will be requested if they are not found
#' @return A connection to the AS400 called 'hr_domino'
#' @export
hr_domino_connect <- function() {
  # Function to get valid y/n response
  get_yn_response <- function(prompt_text) {
    repeat {
      response <- tolower(readline(prompt = prompt_text))
      if (response %in% c("y", "n")) {
        return(response)
      }
      message("Please enter 'y' for yes or 'n' for no")
    }
  }
  
  # Track if credentials came from user input
  credentials_from_input <- FALSE
  
  repeat {
    # Get credentials from environment variables
    username <- Sys.getenv("as400_username")
    password <- Sys.getenv("as400_password")
    
    # Handle username input with while loop
    while (username == "") {
      message("To prevent future prompts, create an environment variable named 'as400_username'")
      username <- readline(prompt = "Please type your AS400 Username: ")
      credentials_from_input <- TRUE
      
      if (username == "") {
        message("Username cannot be empty. Please try again.")
      }
    }
    
    # Handle password input
    if (password == "") {
      message("To prevent future prompts, create an environment variable named 'as400_password'")
      password <- readline(prompt = "Please type your AS400 Password: ")
      credentials_from_input <- TRUE
      
      # Validate password input
      if (password == "") {
        stop("Password cannot be empty")
      }
    }
    
    # Try to establish connection
    connection_result <- tryCatch({
      conn <- DBI::dbConnect(odbc::odbc(), 
                             "hr_domino", 
                             uid = username,
                             pwd = password)
      
      # Assign to global environment only if connection succeeds
      assign("hr_domino", conn, envir = .GlobalEnv)
      
      # Return TRUE to indicate success
      TRUE
      
    }, error = function(e) {
      message("Failed to connect to HR Domino: ", e$message)
      FALSE
    })
    
    # If connection succeeded
    if (connection_result) {
      # If credentials were manually entered, offer to save them
      if (credentials_from_input) {
        save_response <- get_yn_response("Would you like to save these credentials as environment variables? (y/n): ")
        if (save_response == "y") {
          Sys.setenv(as400_username = username)
          Sys.setenv(as400_password = password)
          message("Credentials saved to environment variables")
        }
      }
      return(invisible(get("hr_domino", envir = .GlobalEnv)))
    }
    
    # Ask if user wants to retry
    retry_response <- get_yn_response("Would you like to try again with different credentials? (y/n): ")
    if (retry_response == "n") {
      stop("Connection attempt cancelled by user")
    }
  }
}