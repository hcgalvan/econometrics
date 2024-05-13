library(heaven)
EAWE21 <- read_dta("D:/BackUp ANTONELLA/Fce/DOCENCIA/materias dadas/Econometría 2017/2023/Clase 3 R/EAWE21.dta")
#ejercicio 4.14
#creamos las variables
LGWT04= log(EAWE21$WEIGHT04)
LGHEIGHT= log(EAWE21$HEIGHT)
LGHTSQ=log((EAWE21$HEIGHT)^2)
model = lm(LGWT04 ~ LGHEIGHT, LGHTSQ, data=EAWE21)
cor(LGHEIGHT, LGHTSQ)
summary(model)
#saco una de las variables, ya que LGHTSQ = 2 LGHEIGHT pues tenemos multicolinealdiad exacta
#tanto el R como el stata saca una de las variables q lo causa,
#en el Stata se quitó la variable LGHEIGHT 

#para comprobar resultados con el libro...
model = lm(LGWT04 ~ LGHTSQ, data=EAWE21)
summary(model)
#obtenemos las mismas estimaciones