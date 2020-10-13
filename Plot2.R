#Configuro el escritorio donde estarán los resultados
setwd("C:/Users/USUARIO/Desktop/HelloYu/Exploratory Data/Work1")

#Creo un directorio si "Work1" no existe
if ( ! dir.exists ( "Work1" )) {dir.create ( "Work1" )}

#Se descarga el archivo .zip y se extraen los elementos 
url   <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
path  <- "Work1/household_power_consumption.zip"
unzip <- "Work1/household_power_consumption.txt"

if(!file.exists(path) & !file.exists(unzip)) {
  download.file(url, destfile = path)
  unzip(path, exdir = "Work1")
}

# En este bloque de código se declara un vector que contienes las clases para cada columna, se carga la base de datos, se cambian los formatos de la variable Date & Time, se mezclan, se reconstruye una nueva base de datos con 8 columnas y se imprime la gráfica 1
c <- c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric')
my_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c)
my_data$Date <- as.Date(my_data$Date, "%d/%m/%Y")
my_data <- subset(my_data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
my_data <- my_data[complete.cases(my_data),]
dT <- paste(my_data$Date, my_data$Time)
names (dT)[1] = "Date_Time"
my_data <- my_data[ ,!(names(my_data) %in% c("Date","Time"))]
my_data <- cbind(dT, my_data)
my_data$dT <- as.POSIXct(dT)
plot(my_data$Global_active_power ~ my_data$dT, my_data, type="l", ylab="Global Active Power (kilowatts)", xlab=NA)

## Guardar imagen y cerrar el "device"
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

rm(list = ls())