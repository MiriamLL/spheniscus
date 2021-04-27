#' This functions identify dives according to a parameter. Esta funcion identifica buceos a partir de cierta profundidad/
#'
#' @param TDR_corrected is the dataframe with depth already zero-corrected. Es el data frame con la profundidad corregida.
#' @param depth_column is a numeric column where the depth information is. Es el nombre de la columna donde esta la informacion de profundidad.
#' @param real_dives a number when dives are considered as real dives. Un numero de los cuando los buceos son considerados buceos reales.
#'
#' @return returns a data frame with each dive duration, maximum depth, mean and standard deviation depth
#' @export
#'
#' @examples TDR_dives<-identify_dives(TDR_corrected=TDR_corrected,real_dives=3,depth_column='corrected_depth')
#' @importFrom rlang .data
identify_dives<-function(TDR_corrected=TDR_corrected,
                         depth_column=depth_column,
                         real_dives=real_dives){

  TDR_corrected$dives<-as.numeric(as.character(TDR_corrected[,depth_column]))

  all_dives<-subset(TDR_corrected,TDR_corrected$dives >= real_dives)

  all_dives$numeric_sequence<-as.integer(all_dives$numeric_sequence)

  all_dives$dives<-(cumsum(c(1L, diff(all_dives$numeric_sequence)) != 1L))

  data<-all_dives
  var1<-"dives"
  var2<-"corrected_depth"

  TDR_dives<-data%>%
    dplyr::group_by(.data[[var1]])%>%
    dplyr::summarise(max_depth=max(.data[[var2]]),
                     mean_depth=mean(.data[[var2]]),
                     sd_depth=stats::sd(.data[[var2]]),
                     dive_duration=length(.data[[var1]]))


  return(TDR_dives)
  cat(paste0('A total of ',length(unique(TDR_dives$dives)),' were detected. Real dives were considered when the animal was deeper than ', real_dives,'m'))
}
