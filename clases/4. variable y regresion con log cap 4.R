#abrir paquete stata
library(haven)
EAWE07 <- read_dta("D:/BackUp ANTONELLA/Fce/DOCENCIA/materias dadas/Econometr?a 2017/2021/R/cap 1 al 3/EAWE07.dta")
EAWE07 <- read_dta("EAWE07.dta")
View(EAWE07)

### Formas de acceder a informacion de las columnas ##
EAWE07$AGE #Muestra los valores de la columna age 
EAWE07[, "AGE"]# se deja vacio el lugar correspondiente a las filas (accedemos como vector.)
EAWE07[1, "AGE"] ## que obtengo? 1er obs 1 fila columna age
EAWE07[]

### Saber el promedio, varianza y desvio estandar de una variable en particular ##
mean(EAWE07$AGE)
mean(EAWE07$MALE) # que indica la media de esta variable? ( q es va. dummy)
var(EAWE07$AGE)
sd(EAWE07$AGE)
summary(EAWE07$AGE) 

#### Generamos un data frame con hombres mayores de 39 y mayores a 11 anios.
h39<- data.frame(subset(EAWE07,MALE&AGE>39 )) #que sucede? toma male=1 cuando pongo male, 0 obs xq no hay mayores a 39 a?os summary dice eso
summary(h39)
h11<- data.frame(subset(EAWE07,MALE&AGE>11 )) 
h12<- data.frame(subset(EAWE07,MALE==0&AGE>11 )) #mujeres mayores a 11 a?os
#crea un submuestra que cumplen con 2 condiciones pero arroja todas las variables para las obs que cumplen con esas 2 condiciones
head(h11)
head(h12)

#### grafico de un diagrama de dispersion ##
plot(x = h11$AGE , y = h11$S, type = 'p')  # 'p'= grafico de puntos # que graficamos solo la sub muestra de hombres>11 a?os
plot(x = EAWE07$S , y = EAWE07$EARNINGS, type = 'p') #grafico S de toda la muestra entera con a?os de educ, pero toda la muestra.

#### generar variables en logaritmo
logS<-log(EAWE07$S) #toda la muestra
logS #muestra los valores para cada obs.
logsEar<-log(EAWE07$EARNINGS)


### regresion - Modelo Log-log, lineal-log, log-lineal (regresion multiple)
model1<-logsEar~logS #para que no generar error tuve que crear variables primero
loglog<-lm(model1, data=EAWE07)
summary(loglog)

model2<-EAWE07$EARNINGS~logS #primero escribo el modelo y guardo
linlog<-lm(model2, data=EAWE07) #luego ejecuto el modelo y calcula los valores de la regresion
summary(linlog)

loglin<-lm(log(EAWE07$EARNINGS)~log(EAWE07$S)+EAWE07$MALE+EAWE07$ASVABC, data=EAWE07)
summary(loglin) ## otra manera de hacer la regresion
#combinacion y: log Xs: lin y logs

#variable dicotomica con dependiente en log. 
#Log de earning de hombres es 0,15 x100 superior al de mujer
#cuando es male, el salario es un 15% superior al de la mujer


