#' Corrects zero.
#'
#' @param TDR_trip is a data frame with a column with depth data. Escribe el nombre de tu data frame aqui, debe contener una columna con datos de profundidad.
#' @param depth_column is the name of the column that contains the depth data. Escribe aqui entre comillas el nombre de la columna con datos de profundidad.
#' @param extra_correction write 0 if no extra correction is needer, otherwise add a number here. Escribe 0 si no es necesario corregir, de otra manera pon un numero aqui.
#'
#' @return returns a data frame with a column corrected_depth, with the corrected data.
#' @export
#'
#' @examples TDR_corrected<-correct_zero(TDR_trip = TDR_trip, depth_column='Pressure',extra_correction=-0.65)
correct_zero<-function(TDR_trip=TDR_trip,
                       depth_column=depth_column,
                       extra_correction=extra_correction){

  extra_correction<-0+as.numeric(extra_correction)

  TDR_trip$depth<-as.numeric(as.character(TDR_trip[,depth_column]))

  TDR_trip$corrected_depth<-TDR_trip$dept-extra_correction
  return(TDR_trip)}
