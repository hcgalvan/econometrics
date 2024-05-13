#Ex 7.3
library(haven)
EAWE01 <- read_dta("D:/BackUp ANTONELLA/Fce/DOCENCIA/materias dadas/Econometría 2017/2023/Clase 5 R/EAWE01.dta")
View(EAWE01)
tabla1 = data.frame(EAWE01$ID, EAWE01$EARNINGS, EAWE01$S,EAWE01$EXP, EAWE01$MALE)
View(tabla1)
names(tabla1)= c ("id", "earnings", "s", "exp", "male")
View(tabla1)
R1 = lm(earnings ~ s + exp + male, data = tabla1)
summary(R1)

#graficos exploratorios, que me pueden dar indicios..
par=par(mfrow =c (2,2))#forma de distribuir los graficos, en 2 fila 2 colum
e2=(R1$residuals)^2
plot(tabla1$s,e2 , main = "e2 en funcion de s",
     xlab = "s", ylab = "resid al 2")
plot(tabla1$exp,e2 , main = "e2 en funcion de exp",
     xlab = "exp", ylab = "resid al 2")
plot(tabla1$male,e2 , main = "e2 en funcion de male",
     xlab = "male", ylab = "resid al 2")
plot(R1$fitted.values,e2 , main = "e2 en funcion de Y ajustado",
     xlab = "Y ajustado", ylab = "resid al 2")
par(par) #cierro el grafico

#grafiquen con respecto solo a los residuos tambi?n.

#test de G-Q: detecci?n de heterocedasticidad
#instalar dplyr si no lo tienen. 
library(dplyr)
ordenar = arrange(tabla1, s)
View(ordenar)

n = (3/8)*500
#dejo las primeras 187 obs y las ultimas 187
#elimino desde la 188 hasta la 312

ID = c (1:500)
length(ID)
ordenar2= data.frame(ID,ordenar)
View(ordenar2)
sub1 = ordenar2[ordenar2$ID<188,]
View(sub1)
sub2 = ordenar2[ordenar2$ID>313,]
View(sub2)

RSub1= lm (earnings ~ s + exp + male, data = sub1)
Rss1 = sum((RSub1$residuals)^2)
RSub2= lm (earnings ~ s + exp + male, data = sub2)
Rss2 = sum((RSub2$residuals)^2)
#n?= 187 n?- k = 187-4 = 183
estadistico = Rss2/Rss1
qf(0.95,183,183) #funcion para F critico: primero 1-alfa, df, df
#No rechazo H0 de Homocedasticidad.

#instalar lmtest y abrirla test de G-Q
library(lmtest)
gqtest(R1, point=0.5, fraction=126, order.by = tabla1$s, data = tabla1)
#point= cuantas partes divido el set de datos
#fraction = datos centrales



#ex. 7.4 test de white (es un caso especial del b-pagan test)
#The function bptest() in package lmtest
prueba_white<- bptest(R1, ~I(R1$model$s^2)+I(R1$model$male^2)+I(R1$model$exp^2)+R1$model$s*R1$model$male+R1$model$s*R1$model$exp+R1$model$male*R1$model$exp)
print(prueba_white) ##No se puede rechazar la H0 de homocedasticidad o no asociacion, al 5% de sigificancia 

#otra forma: 
pw2= lm(e2~tabla1$s+tabla1$exp+tabla1$male+I(tabla1$s^2)+I(tabla1$male^2)+I(tabla1$exp^2)+tabla1$s*tabla1$exp+tabla1$s*tabla1$male+tabla1$male*tabla1$exp)
summary(pw2)
#multiplicador de lagrange L=n*R^2
#500*0.01281 = 6.405 
#R^2 (chi cuadrado) con (k-1)gl k=9 --> 8gl
qchisq(0.95,8)
#no puedo rechazar h0 de homocedasticidad

#si el test me hubiera dado heterocedasticidad: que hago
#Since the presence of heteroskedasticity makes LS standard errors incorrect, 
#there is a need for another method to calculate them: White robust standard errors is such a method.
# hccm(), which is part of the car package. El que no tiene debe bajar el car

library(car)
summary(R1)
cov1 <- hccm(R1, type="hc1") #hc1 es el tipo de error estandar por defecto que es constante obvio
coeftest(R1, vcov.=cov1)
##Aca miro los errores, y comparo con la regresion original, los robustos deberian ser mas pequeños y podra hacer el test t y F
#pero como en este caso no hay heterocedasticidad, esto no se cumple.



