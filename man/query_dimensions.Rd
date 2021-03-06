% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/query_dimensions.R
\name{query_dimensions}
\alias{query_dimensions}
\title{Query the Dimensions database}
\usage{
query_dimensions(query, token = NULL)
}
\arguments{
\item{query}{string}

\item{token}{string}
}
\value{
data frame
}
\description{
Query the Dimensions database
}
\examples{
\dontrun{
query_dimensions(query = 
'search grants for "lung cancer" 
where active_year=2000 
return grants')
}
}
