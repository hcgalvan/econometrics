library(readxl)
escuelas <- read_excel("D:/BackUp ANTONELLA/Fce/DOCENCIA/materias dadas/Econometr?a 2017/2021/R/cap 1 al 5/schools.xls")
escuelas <- read_excel("schools.xls")
View(escuelas)

### Tabla 5.1(pag.231) , Tabla 5.3(pag.233), Tabla 5.5(pag.238)
tabla51<-lm(COST~N, data=escuelas) #observar como estan escritas las variables en la base de datos
summary(tabla51)
#modelo sin intercepto 0+N

tabla53<-lm(COST~N+OCC, data=escuelas)
summary(tabla53)

tabla55<-lm(COST~N+TECH+WORKER+VOC, data=escuelas)
summary(tabla55)

#### REALIZAR la tabla5.8 (pag.243)
tabla58<-lm(COST~0+N+TECH+WORKER+VOC+GEN, data=escuelas)
summary(tabla58)


#### Trabajar con dummies##
# tabla 5.13 y 5.14 - pag.257 ###
tabla513<-lm(COST~N, data=subset(escuelas,OCC==0))
tabla514<-lm(COST~N, data=subset(escuelas,OCC==1))
#subset()  permite  colocar una  serie de condiciones para retener observaciones de un objeto
summary(tabla513)
summary(tabla514)

### Creacion de la suma cuadrada de desvios###

#####Grupo1######
# Extraemos los valores estimados 
estimados_1 <- fitted(tabla513)

# la desviacion cuadrada de los valores observados menos los estimados
desviacion_1 <- (tabla513$model$COST - estimados_1)^2
#se pone tabla luego model (significa valor observado, el ajustado+residuo)
#y luego la va. dependiente (es solo para OCC=0)
# Suma cuadrada de desvios del grupo 1 #residual sum sq
SSR_1 <- sum(desviacion_1)

#####Grupo2######
tabla514<-lm(COST~N, data=subset(escuelas,OCC==1))
summary(tabla514)
# Extraemos los valores estimados 
estimados_2 <- fitted(tabla514)
# la desviacion cuadrada de los valores observados menos los estimados
desviacion_2 <- (tabla514$model$COST - estimados_2)^2
# Suma cuadrada de desvios del grupo 2
SSR_2 <- sum(desviacion_2)

#####Regresion Total######
# Extraemos los valores estimados 
estimados_T <- fitted(tabla51)
# la desviacion cuadrada de los valores observados menos los estimados
desviacion_T <- (tabla51$model$COST- estimados_T)^2
# Suma cuadrada de desvios del grupo 2
SSR_T <- sum(desviacion_T)


#¿hay una mejora significativa en el ajuste medido como RSS
#cuando la muestra es dividida en 2 sub-muestras?

###Test F y F critico
### test de chow
F1<-{((SSR_T-SSR_1-SSR_2)/2)/((SSR_1+SSR_2)/70)}
F1
#qf(p (vector of probabilities), df1, df2) -- distribucion F
qf(0.999,2,70) #valor critico nivel de significancia 0,1% = 0,001 entonces 0,999 de confianza, k, n-2k
qf(0.99,2,70) #es distinto el f critico, 0,01 --1% de significancia
#rechazo 𝐻_0:𝑚𝑒𝑗𝑜𝑟𝑎 𝑛𝑜 𝑠𝑖𝑔𝑛𝑖𝑓𝑖𝑐𝑎𝑡𝑖𝑣𝑎 𝑒𝑛 𝑒𝑙 𝑎𝑗𝑢𝑠𝑡𝑒
#como hay una mejora significativa en el ajuste, cuando divido la muestra, no debo usar la regresion pooled


