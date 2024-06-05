### Practica N 1####
#### https://nwfsc-timeseries.github.io/atsa-labs/sec-tslab-autoregressive-ar-models.html####
### Generación  PROCESOS AR(P) MA(Q) Y ARMA(P,Q)#####
# install.packages("devtools") ## paquetes github
# install.packages("MARSS")
# install.packages("forecast")
library(MARSS)
library(forecast)
library(datasets)
library(stats)
#####################################################
#### CREACION DE UNA SERIE DE RUIDO BLANCO ####
set.seed(123)
## SERIE ALEATORIA distribución normal y de Possion 
NRB <- rnorm(n=400, mean=5, sd=0.2)
## random Poisson variates
PRB <- rpois(n=100, lambda=20)
############# gráficos de tipo plot para observar distribuciones########
## preparamos el lugar donde se ubicaran los gráficos
par(mfrow=c(1,2))
## plot  distribucion normal con linea en la media 5
plot.ts(NRB)
abline(h=5, col="blue", lty="dashed")
## plot Distribución  Poisson con linea en la  media 20
plot.ts(PRB)
abline(h=20, col="blue", lty="dashed")
########## Función de autocorrelación para NRB y PRB ##########
## preparamos el lugar donde se ubicaran los gráficos
par(mfrow=c(1,2))
## plot ACF para distribucion normal con linea en la media 5
acf(NRB, main="", lag.max=20)
## plot  ACF Distribución  Poisson con linea en la  media 20
acf(PRB, main="", lag.max=20)
########################################################
###### PROCESO DE CAMINO ALEATORIO O RANDOM WALK#####
## x[t] = x[t-1] + wt], WT ES RUIDO BLANCO
set.seed(123)
## Tamaño de la serie de tiempo
TT <- 100
## initializamos {x_t} y {w_t}
xx <- ww <- rnorm(n=TT, mean=0, sd=1)
## computamos valores de 2 hasta TT
for(t in 2:TT) { xx[t] <- xx[t-1] + ww[t] }
## Definimos el lugar del gráfico plot
par(mfrow=c(1,2))
## linea del tiempo
plot.ts(xx, ylab=expression(italic(x[t])))
## plot ACF
plot(acf(xx, plot=FALSE))
###################################################
##### PROCESOS AUTOREGRESIVOS AR(P)##########
set.seed(456)
## Proceso AR(1). Damos forma recordar coeficiente en valores absoluto menor a 1 implica proceso estacionario
AR1 <- list(order=c(1,0,0), ar=0.1, sd=0.1)
## simulación AR(1)
AR1S <- arima.sim(n=50, model=AR1)
## linea del tiempo
plot.ts(AR1S, ylab=expression(italic(AR[1])))
## plot ACF
plot(acf(AR1S, plot=FALSE))
##### comparación de 4 procesos AR(p)###

set.seed(123)
## Seleccionamos los 4 coeficientes de los modelos AR
ARp <- c(0.7, 0.2, -0.1, -0.3)
## usamos la función  list para guardar los modelos generados
AR.mods <- list()
## hacemos los calculos  en forma recursiva para todos los  ordenes de p. Simulación
for(p in 1:4) {
  ## assumimos SD=1, por lo tanto no lo especificamos
  AR.mods[[p]] <- arima.sim(n=10000, list(ar=ARp[1:p]))
}
##Formulamos los ACF y PACF para cada uno de los 4 modelos anteriores

## decidimos como distribuimos los gráficos

par1 <- par(mfrow=c(4,3))
##  hacemos los gráficos ACF y PACF en forma recursiva para todos los  ordenes de p
## sin titulo de serie, se coloca  main =NA 
for(p in 1:4) {
  plot.ts(AR.mods[[p]][1:50],
          ylab=paste("AR(",p,")",sep=""))
  acf(AR.mods[[p]], lag.max=12,main =NA)
  pacf(AR.mods[[p]], lag.max=12, ylab="PACF",main =NA)
}
par(par1)

#################################################################
#### PROCESOS DE MEDIA MOVIL - MA(Q) ##############
set.seed(1023)
## Description para MA(1). Creamos el modo lista
MA1 <- list(order=c(0,0,1), ma=0.2, sd=0.1)
## simulación MA(1)
MA1S <- arima.sim(n=50, model=MA1)
## linea del tiempo
plot.ts(MA1S, ylab=expression(italic(MA[1])))
## plot ACF
plot(acf(MA1S, plot=FALSE))

set.seed(123)
## the 4 MA coefficients
MAq <- c(0.7, 0.2, -0.1, -0.3)
##  list vacia para alojar los modelos MA
MA.mods <- list()
## generamos las series simuladas con los coeficientes q
for(q in 1:4) {
  ## se asume un SD=1
  MA.mods[[q]] <- arima.sim(n=1000, list(ma=MAq[1:q]))
}
###Graficamos ACF y PACF para los modelos MA

##elegimos la distribución de los gráficos
par(mfrow=c(4,3))
## graficamos los plot para cada q
for(q in 1:4) {
  plot.ts(MA.mods[[q]][1:50],
          ylab=paste("MA(",q,")",sep=""))
  acf(MA.mods[[q]], lag.max=12, main=NA)
  pacf(MA.mods[[q]], lag.max=12, ylab="PACF", main=NA)
}

##############################################################
########## ARMA(P,Q)##############################x 
devtools::install_github("KevinKotze/tsm") 
devtools::install_github("cran/fArma")
library("tsm")
x1<- arima.sim(model = list(ar = 0.4), n = 200) # AR(1) 
ac(x1, max.lag = 20)
x2 <- arima.sim(model = list(ma = 0.5), n = 200) # MA(1) 
ac(x2, max.lag = 20)
x3 <- arima.sim(model = list(ar = 0.4, ma = 0.5), n = 200) ## ARMA(1,1) 
ac(x3, max.lag = 20)
z <- arima.sim(model = list(ar = c(0.6, -0.2), ma = c(0.4)), n = 200) ### ARMA(2,1)
ac(z, max.lag = 18) ####




