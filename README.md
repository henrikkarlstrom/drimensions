
<!-- README.md is generated from README.Rmd. Please edit that file -->

# drimensions

drimensions provides a wrapper to the Dimensions API. Dimensions is a
citation database provided by Digital Science.

drimensions only provides a wrapper that handles authentication and
pagination for you in a convenience function, but does not help you with
formatting the API query according to the Dimensions query language,
DSL. You can find examples and API specification at the [official DSL
documentation](https://docs.dimensions.ai/dsl/index.html).

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("henrikkarlstrom/drimensions")
```
