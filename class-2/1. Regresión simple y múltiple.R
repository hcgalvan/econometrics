#REGRESION SIMPLE Y MULTIPLE
library(haven)#instalo o activo el paquete heaven para leer archivos de stata
#importo la base de datos
EAWE07 <- read_dta("C:\Users\Estudiante\Documents\hcgalvan\Repositorios\econometrics\class-2\EAWE07.dta")
EAWE07 <- read_dta("EAWE07.dta")
View(EAWE07)
head (EAWE07) # muestra las primeras 6 obs.
summary(EAWE07) # resumen de las estadisticas descriptivas

### Armamos el dataframe para replicar la tabla 1.2 (pag.98) y 3.12 (pag. 183)
tabla312<-data.frame(EAWE07$EARNINGS, EAWE07$S,EAWE07$SM,EAWE07$SF,EAWE07$ASVABC,EAWE07$FEMALE,EAWE07$MALE)
class(tabla312) ## chequear que es data frame.
View(tabla312)
head(tabla312) #Podemos usar el comando head para volver a chequear que est? todo bien.
tail(EAWE07)  #tail muestra las 6 ultimas observaciones

#Regresion Simple. Analisis grafico y estimacion Tabla 1.2
#Para graficar debemos instalar ggplot2 install.packages("ggplot2")
###Graficar diagrama de dispersion figura 1.7 - pag. 99##
install.packages("ggplot2")
library(ggplot2)
ggplot(tabla312,aes(x=EAWE07$S, y = EAWE07$EARNINGS ))+geom_point()


### Estimacion de la regresion Simple y Multiple ####
## existen varias formas de estimar los modelos, explicare una facil y que luego da mas detalles
#Tabla 1.2
modelo <- tabla312$EAWE07.EARNINGS~tabla312$EAWE07.S #guardamos el modelo para estimar
fit1 <- lm(modelo ,data=tabla312) # estimamos el modelo con el data frame tabla312
summary(fit1) # los valores difieren a los del libro. No preocuparse. Resumen del modelo.

fitted.values(fit1) 
fit1$fitted.values #toma los valores ajustados de ese modelo solo muestra
#ambos muestran lo mismo
valorajustado=data.frame(fit1$fitted.values) #los guarda y genera variable

### Regresion Multiple ##
modelo2 <- tabla312$EAWE07.S~tabla312$EAWE07.ASVABC+tabla312$EAWE07.SM+tabla312$EAWE07.SF #guardamos el modelo para estimar
fit2 <- lm(modelo2 ,data=tabla312)# estimamos el modelo con el data frame tabla312
summary(fit2)

#dibujar los residuos
#Usamos la funci?n plot() para que nos muestres 4 gr?ficos
#Residuos vs valores estimados, QQplot: cuartiles te?ricos vs residuos estandarizados, valores estiamdos
# y residuos vs leverage. Antes de plot(), usaremos
#la funci?n par(mfrow=c(a,b)) para distribuir los gr?ficos, "a" representa la cantidad de filas y "b" de columnas
#Colocar zoom para ver bien los gr?ficos, y/o modificar el margen de la pantalla plot


par1=par(mfrow =c (2,2))
plot(fit1)
par(par1)

## Regresi?n por el origen SIN INTERCEPTO: le agrego un 0+ 
fit3<- lm(tabla312$EAWE07.S~0+tabla312$EAWE07.ASVABC+tabla312$EAWE07.SM+tabla312$EAWE07.SF, data=tabla312)
summary(fit3)
