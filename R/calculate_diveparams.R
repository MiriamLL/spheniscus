#' Calculates diving parameters for the complete trip
#'
#' @param TDR_dives is a data frame with all the dives that ocurred during the trip
#'
#' @return dataframe with dive parameters
#' @export
#'
#' @examples dive_parameters<-calculate_diveparams(TDR_dives)
#' @importFrom rlang .data
calculate_diveparams<-function(TDR_dives=TDR_dives){

  data<-TDR_dives

  var1<-"max_depth"
  var2<-"dive_duration"

  dive_params<- data %>%
    dplyr::summarise(max_depth_mean=mean(.data[[var1]]),
                     max_depth_sd=stats::sd(.data[[var1]]),
                     max_depth_max=max(.data[[var1]]),

                     dive_duration_mean=mean(.data[[var2]]),
                     dive_duration_sd=stats::sd(.data[[var2]]),
                     dive_duration_max=max(.data[[var2]]),

                     n_dives=length(.data[[var2]])
    )

  return(dive_params)
}
