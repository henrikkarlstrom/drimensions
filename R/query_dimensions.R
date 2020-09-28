#' Query the Dimensions database
#'
#' @param query string
#' @param token string
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
query_dimensions <- function(query, token = NULL){
  
  if(is.null(token)){
    token <- get_dimensions_token()
  }
  
  post_query <- httr::POST(
    url = "https://app.dimensions.ai/api/dsl.json",
    config = httr::add_headers(
      Authorization = token
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
  
  return(post_query)

}
