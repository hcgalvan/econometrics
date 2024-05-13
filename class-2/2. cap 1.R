#cap.1


library(haven)
EAWE21 <- read_dta("D:/BackUp ANTONELLA/Fce/DOCENCIA/materias dadas/Econometría 2017/2023/Clase 3 R/EAWE21.dta")
View(EAWE21)

#Grafico de dispersion
scatter.smooth(EAWE21$S, y = EAWE21$EARNINGS,
               xlab = "years of schooling",
               ylab = "hourly earnings")

data.class(EAWE21)
#es un data frame

pairs(EAWE21)

#regresion simple pag. 98
regresion1 = lm (EAWE21$EARNINGS ~ EAWE21$S)
summary(regresion1)

#Residual standard error (R) = root mse (stata), 

RSS = sum(resid(regresion1)^2)
RSS #residual sum squares
MSS = (sum ((regresion1$fitted.values - (mean(EAWE21$EARNINGS)))^2))
MSS #model sum squares o ESS 

ModelMS = MSS/1 #divide por los gl
ModelMS
ResidualMS = RSS/498 #divide por los gl, es la estimacion de la varianza de u
ResidualMS
rootmse = (ResidualMS)^(1/2) #raiz de la varianza de u

# table 1.3 page 101
summary (EAWE21$S)
meanS= mean(EAWE21$S)
SDEV = EAWE21$S - 14.87 #demeaned S
SDEV2 = EAWE21$S - meanS
regresion2 = lm (EAWE21$EARNINGS ~ SDEV)
summary (regresion2)
