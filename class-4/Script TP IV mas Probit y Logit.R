
##### Variables Instrumentales ###
# Instalamos los paquetes necesarios
#install.packages("AER")
#install.packages("stargazer")
#install.packages("ivreg", dependencies = TRUE)
library(AER)
library(stargazer)
library(ivreg)


# cargamos datos y analizamos las base de datos
data("CigarettesSW")
summary(CigarettesSW)
?CigarettesSW # describe base de datos.
# Armado de Variables y chequeo de correlación entre instrumento y variable instrumentada

# precios "reales"  per capita p
CigarettesSW$rprecio <- with(CigarettesSW, price / cpi)

#  impuesto a las ventas imptv
CigarettesSW$imptv <- with(CigarettesSW, (taxs - tax) / cpi)

# correlación entre la variable impuesto a las ventas, "precio" y precio real
cor(CigarettesSW$imptv, CigarettesSW$price)
cor(CigarettesSW$imptv, CigarettesSW$rprecio)


# generamos la muestra para el año 1995
c1995 <- subset(CigarettesSW, year == "1995")

# Estimación con IVREG I caso
# perform TSLS using 'ivreg()'
cig_ivreg <- ivreg(log(packs) ~ log(rprecio) | imptv, data = c1995)
coeftest(cig_ivreg, vcov = vcovHC, type = "HC1")
summary(cig_ivreg)
# Estimación con IVREG II CASO con dos instrumentos

# incorporamos el ingreso real al dataset 
CigarettesSW$rincome <- with(CigarettesSW, income / population / cpi)

c1995 <- subset(CigarettesSW, year == "1995")
# estimamos el modelo con un unico instrumento
cig_ivreg2 <- ivreg(log(packs) ~ log(rprecio) + log(rincome) |  imptv+ log(rincome)
                    , data = c1995)

coeftest(cig_ivreg2, vcov = vcovHC, type = "HC1")
summary(cig_ivreg2)

# Agregamos un segundo instrumento y estimamos el modelo

# adicionamos el impuestos locales a los cigarrilos al  
CigarettesSW$cigtax <- with(CigarettesSW, tax/cpi)

c1995 <- subset(CigarettesSW, year == "1995")
# estimate the model
cig_ivreg3 <- ivreg(log(packs) ~ log(rprecio) + log(rincome) | 
                      log(rincome) + imptv + cigtax, data = c1995)

coeftest(cig_ivreg3, vcov = vcovHC, type = "HC1")
summary(cig_ivreg3)

##################################################################
################## MODELOS PROBIT, LOGIT Y OLS ################
#install.packages("MASS")
#install.packages("lmtest")
#install.packages("sandwich")
#install.packages("betareg")
#install.packages("mfx")
library(MASS) # necesario para que funcione mfx
library(betareg)  # necesario para que funcione mfx
library(mfx) # para usa el ejemplo
library(AER)
data("SwissLabor")
head(SwissLabor)

##### Modelo Probit con glm########
probit1<-glm(participation ~ income + age + education +youngkids + oldkids + foreign,
    family = binomial(link = "probit"), 
    data = SwissLabor)

coeftest(probit1, vcov. = vcovHC, type = "HC1") # existe discusión al respecto si corregir los errores
# modelo probit con mfx

probit2<-probitmfx(participation ~ income + age + education + youngkids + oldkids + foreign, data = SwissLabor)
probit2$fit
probit2 # Nos da los efectos marginales


######### Modelo LOGIT con glm#######
logit1<-glm(participation ~ income + age + education +youngkids + oldkids + foreign,
             family = binomial(link = "logit"), 
             data = SwissLabor)

coeftest(logit1, vcov. = vcovHC, type = "HC1") # existe discusión al respecto si corregir los errores
# modelo Logit con mfx

logit2<-logitmfx(participation ~ income + age + education + youngkids + oldkids + foreign, data = SwissLabor)
logit2$fit
logit2 # Nos da los efectos marginales
