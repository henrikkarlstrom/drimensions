#' Query the Dimensions database
#'
#' @param query string
#' @param username string 
#' @param password string
#'
#' @return data frame
#' @export
#'
#' @examples
#' \dontrun{
#' query_dimensions(query = 
#' 'search grants for "lung cancer" 
#' where active_year=2000 
#' return grants')
#' }
query_dimensions <- function(
  query,
  username = NULL,
  password = NULL
  ){
  
  #establish login credentials
  login_credentials <- list(
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
  post_credentials <- httr::POST(
    url = "https://app.dimensions.ai/api/auth.json",
    body = login_credentials,
    encode = "json"
  )
  
  if(httr::http_error(post_credentials)){
    stop("Error fetching credentials")
  }
  
  #parse the authorisation query response
  parsed_authorisation <- httr::content(
    x = post_credentials, 
    as = "parsed"
    )
  
  post_query <- httr::POST(
    url = "https://app.dimensions.ai/api/dsl.json",
    config = httr::add_headers(
      Authorization = paste("JWT", parsed_authorisation[["token"]])
      ),
    body = query,
    httr::content_type_json(),
    encode = "raw"
  )
  
  if(httr::http_error(post_query)){
    stop(
      paste(
        "Query failed with status",
        httr::http_status(post_query)[["message"]]
      )
      )
  }
  
  parse_response <- jsonlite::fromJSON(
    httr::content(
      x = post_query, 
      as = "text", 
      encoding = "UTF-8"
      )
    )
  
  content_frame <- data.frame()
  content_frame <- dplyr::bind_rows(
    content_frame, 
    parse_response[[2]]
    )
  
  return(content_frame)
}