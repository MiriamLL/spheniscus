#' EN: Extracts pressure data from raw time and depth data. ES: Extrae data de presion desde dispositivos TDR
#'
#' @param data EN: is the raw data as imported from your device. ES:son los datos crudos descargados de tu dispositivo
#' @param row_start EN: is the name of the row where the pressure data starts to be recorded. ES: es la nombre de la fila donde empieza a tomar los datos de presion
#' @param row_end EN: is the name of the row where the pressure data finishes to be recorded. ES: es la nombre de la fila donde termina de tomar los datos de presion
#'
#' @return EN: it will return a object named TDR_pressure. ES: agrega un objeto llamado TDR_pressure al environment
#' @export
#'
#' @examples
#' TDR_raw<-TDR_raw
#' TDR_pressure<-extract_pressure(data=TDR_raw, row_start='Data Block 1', row_end = 'Data Block 2')
extract_pressure<-function(data=data,
                      row_start=row_start,
                      row_end=row_end){

  start_pressure<-which(data[,1] == row_start)
  start_pressure<-(as.numeric(as.character(start_pressure))+6)

  start_temperature<-which(data[,1] == row_end)
  start_temperature<-(as.numeric(as.character(start_temperature))-1)

  cut_first_rows <- data[-c(1:start_pressure),]
  cut_first_rows <-as.data.frame(cut_first_rows)

  start_temperature<-which(cut_first_rows[,1] == row_end)
  start_temperature<-(as.numeric(as.character(start_temperature))-1)

  pressure_recordings<-cut_first_rows[c(1:start_temperature),]
  pressure_recordings<-as.data.frame(pressure_recordings)

  TDR_pressure<-pressure_recordings %>%
    tidyr::separate(pressure_recordings, c("time", "pressure"),sep=',')

  names(TDR_pressure)[1]<-"tStamp"
  names(TDR_pressure)[2]<-"Pressure"

  numeric_sequence<-nrow(TDR_pressure)
  numeric_sequence<-as.numeric(numeric_sequence)
  TDR_pressure$numeric_sequence<-paste(seq(1:numeric_sequence))

  #assign("TDR_pressure",TDR_pressure,envir = .GlobalEnv)
  return(TDR_pressure)
}
