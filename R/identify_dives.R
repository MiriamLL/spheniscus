#' This functions identify dives according to a parameter. Esta funcion identifica buceos a partir de cierta profundidad/
#'
#' @param TDR_corrected is the dataframe with depth already zero-corrected. Es el data frame con la profundidad corregida.
#' @param depth_column is a numeric column where the depth information is. Es el nombre de la columna donde esta la informacion de profundidad.
#' @param real_dives a number when dives are considered as real dives. Un numero de los cuando los buceos son considerados buceos reales.
#'
#' @return returns a data frame with each dive duration, maximum depth, mean and standard deviation depth
#' @export
#'
#' @examples table_dives<-identify_dives(TDR_corrected=TDR_corrected,real_dives=3,depth_column='corrected_depth')
identify_dives<-function(TDR_corrected=TDR_corrected,
                         depth_column=depth_column,
                         real_dives=real_dives){

  TDR_corrected$dives<-as.numeric(as.character(TDR_corrected[,depth_column]))

  TDR_dives<-subset(TDR_corrected,TDR_corrected$dives >= real_dives)

  TDR_dives$numeric_sequence<-as.integer(TDR_dives$numeric_sequence)

  TDR_dives$dives<-(cumsum(c(1L, diff(TDR_dives$numeric_sequence)) != 1L))

  var1<-"dives"
  var2<-"corrected depth"

  table_dives<-TDR_dives%>%
    dplyr::group_by(.data[[var1]])%>%
    dplyr::summarise(max_depth=max(.data[[var2]]),
                     mean_depth=mean(.data[[var2]]),
                     sd_depth=stats::sd(.data[[var2]]),
                     dive_duration=length(.data[[var1]]))


  return(table_dives)
  cat(paste0('A total of ',length(unique(TDR_dives$dives)),' were detected. Real dives were considered when the animal was deeper than ', real_dives,'m'))
}
