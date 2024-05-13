library(haven)
EAWE21 <- read_dta("D:/2024/econometria/ClasesPracticas/EAWE21.dta")
View(EAWE21)

# Para tener presente: ejemplo
tabla1=data.frame(EAWE21$S, EAWE21$EXP, EAWE21$EARNINGS, EAWE21$ASVABC, EAWE21$SF, EAWE21$SM, EAWE21$MALE)
View(tabla1)
#cambiar de nombres
names(tabla1)= c("s","exp","earnings", "asvabc", "sf", "sm", "male")
View(tabla1)

#Multicolinealidad
#queremos realizar el siguiente modelo tabla1$s ~ tabla1$asvabc + tabla1$sm + tabla1$sf
#matriz de correlacion
cor(tabla1, use="na.or.complete")#use se usa para tratar los missing
cor(tabla1, use="complete.obs") #se ingnoran los missings
matrizcorr = cor(tabla1, use="na.or.complete")
install.packages("corrplot")
library(corrplot)

#si el modelo que quiero ajustar es: s ~ asvabc + sm + sf

corrplot(matrizcorr, method = "circle")
#miramos los coef entre asvabc, sf y sm
#0.53 es el coef de corr entre sf y sm, si bien no es mayor a 0,70 vamos a observarlo y a calcular el vif)
#calculamos el vif
vif1 = lm (tabla1$sf ~ tabla1$sm + tabla1$asvabc, data= tabla1)
summary(vif1)
1/(1-0.3198)
#1.470156
vif2 = lm (tabla1$sm ~ tabla1$sf + tabla1$asvabc, data = tabla1)
summary(vif2)
1/(1-0.3126)
#1.454757
#ningun vif es mayor 10, no hay indicios de multicolinealidad

fit1 = lm(tabla1$s ~ tabla1$asvabc + tabla1$sm + tabla1$sf)
summary(fit1)
# otra forma de calcular el vif
install.packages("car")
library(car)
vif(fit1)
#ningun vif es mayor a 10, no saco ninguna variable del modelo.
