#' Function to cut periods of the TDR that correspond to time at sea
#'
#' @param data your TDR data with at least these two columns: tStamp and Pressure
#' @param timeformat the format of your data in your TDR data tStamp
#' @param trip_start The period of time when the trip started. This data can be deduced from field observations or obtained from GPS.
#' @param trip_end The period of time when the trip finished. This data can be deduced from field observations or obtained from GPS.
#'
#' @return Returns a object with less observations than in the original data. Only the periods between the data provided are returned.
#' @export
#'
#' @examples
#' timeformat<-"%d-%m-%Y %H:%M:%S"
#' trip_start<-"30-11-2018 20:43:24"
#' trip_end<-"01-12-2018 20:16:19"
#' TDR_trip<-cut_trip(data=TDR_pressure,timeformat=timeformat,trip_start=trip_start,trip_end=trip_end)
cut_trip<-function(data=data,
                   timeformat=timeformat,
                   trip_start=trip_start,
                   trip_end=trip_end){


  data$daytime<- as.POSIXct(strptime(as.character(data$tStamp),
                                     timeformat), "GMT")

  trip_start<-as.POSIXct(strptime(trip_start, timeformat), 'GMT')
  trip_end<-as.POSIXct(strptime(trip_end, timeformat), 'GMT')


  TDR_no_start<-subset(data, data$daytime>=trip_start)
  TDR_no_end <- subset(TDR_no_start, TDR_no_start$daytime<= trip_end)

  TDR_trip<-TDR_no_end

  return(TDR_trip)
}
