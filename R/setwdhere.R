#' Running this function (eventually) will set your working directory to the location of the currently open file
#' Do not use this function in scripts that will be pasted into PowerBI
#' Right now, it just reminds you of the function
#' @export
setwdhere <- function() {
  print("setwd(dirname(rstudioapi::getActiveDocumentContext()$path))")
}