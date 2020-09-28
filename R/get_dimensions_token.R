#' Get Dimensions db authorisation token
#'
#' @param username string
#' @param password string
#'
#' @return string
#' @export
#'
#' @examples
#' \dontrun{
#' get_dimensions_token()
#' }
#' 
get_dimensions_token <- function(
  username = NULL, 
  password = NULL
  ){
  
  #establish login credentials
  credentials <- list(
    username = ifelse(
      !is.null(username), 
      username, 
      Sys.getenv("DIMENSIONS_USERNAME")
    ), 
    password = ifelse(
      !is.null(password),
      password,
      Sys.getenv("DIMENSIONS_PASSWORD")
    )
  )
  
  #retrieve authorisation
  credentials <- httr::POST(
    url = "https://app.dimensions.ai/api/auth.json",
    body = credentials,
    encode = "json"
    )
  
  if(httr::http_error(credentials)){
    stop("Error fetching credentials")
  }
  
  #reutn the token
  return(
    paste(
      "JWT", 
      httr::content(
        x = credentials,
        as = "parsed"
        )[["token"]]
      )
    )
}
