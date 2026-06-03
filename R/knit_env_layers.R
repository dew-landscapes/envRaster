#' Insert the environmental variables descriptions
#'
#' Describes
#'
#' @param ids Character. Vector of ids (usually from env_df$blah_id) over which
#' to expand the environmental data sources and layers.
#'
#' @returns Expanded markdown child document.
#' @export
#'
knit_env_layers <- function(ids) {

  text <- NULL

  for (i in ids) {

    env_source <- i

    text = c(text
             , knitr::knit_expand(system.file("rmd/sources.Rmd"
                                              , package = "envRaster"
                                              )
                                  )
             )

  }

  text <- knitr::knit_child(text = text)

  cat(paste(text, collapse = '\n'))

}
