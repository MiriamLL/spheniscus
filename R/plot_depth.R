#' plot_depth: Creates a plot with the diving profile. Adds a red line for the zero. Crea un grafico con el perfil de buceos. Marca el cero con una linea roja.

#'
#' @param TDR_trip is a data frame with a colum including depth and a column including time (in POSIXct format)
#' @param depth_column must be a numeric value
#' @param time_column must be a date and time (in POSIXct format) (%Y-%m-d %H:%M:%S)
#'
#' @return returns a ggplot which stetics can be change using the ggplot2 sintaxis
#' @export
#'
#' @examples plot_depth(TDR_trip = TDR_trip,depth_column='Pressure',time_column='daytime')
plot_depth<-function(TDR_trip=TDR_trip,
                     depth_column=depth_column,
                     time_column=time_column){

  data<-TDR_trip
  var1<-time_column
  var2<-depth_column

  depth_profile<-ggplot2::ggplot(data=data,
                                 ggplot2::aes(x=.data[[var1]],
                                              y=as.numeric(.data[[var2]])))+
    ggplot2::geom_line()+
    ggplot2::ylab("Diving depth (m)")+
    ggplot2::xlab("Month.Day Hour:Minute")+
    ggplot2::scale_y_reverse()+
    ggplot2::theme_bw()+
    ggplot2::theme(panel.border = ggplot2::element_rect(linetype = "solid",
                                                        colour = "black", size=1.5),
                   axis.line =  ggplot2::element_line(size=1.5, colour = "black"),
                   axis.text.x =   ggplot2::element_text(size=12),
                   axis.text.y =   ggplot2::element_text(size=12),
                   axis.title.y =  ggplot2::element_text(size=14),
                   panel.grid.major =  ggplot2::element_blank(),
                   panel.grid.minor =  ggplot2::element_blank(),
                   panel.background =  ggplot2::element_blank(),
                   legend.position = "none")+
    ggplot2::geom_hline(yintercept=0, color = "red")+
    NULL

  depth_profile
  return(depth_profile)
}
