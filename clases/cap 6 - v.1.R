library(haven)
EAWE21 <- read_dta("D:/BackUp ANTONELLA/Fce/DOCENCIA/materias dadas/Econometría 2017/2023/Clase 3 R/EAWE21.dta")
View(EAWE21)

#EX6.1 
R1 = lm(EAWE21$S ~ EAWE21$ASVABC + EAWE21$SM)
summary(R1)

R2 = lm(EAWE21$S ~ EAWE21$ASVABC)
summary(R2)

R3 = lm(EAWE21$S ~ EAWE21$SM)
summary(R3)

cor(EAWE21$ASVABC, EAWE21$SM)


#El coef de ASVABC resulta mayor en la regresion 2, y esto resulta en un sesgo positivo
#debido a la variable omitida SM. El coef de corr es +0,36 entonces el numerador 
#del segundo factor de sesgo es +, su denominador es siempre +, el beta de SM es +
# y significativo, por lo que el sesgo es +.  El sesgo total es + por variable omitida. 

#Cuando se omite ASVABC, el coef de SM es mucho mayor en la reg 2 que en la 1. 
#ya vimos que la corr es +, entonces el numerador del 2do factor de sesgo es +
#el denominador tmabien, y el beta de ASVABC (vista en la 1er reg) es +. 
#El sesgo total es +.

#Ex. 6.3
LGEARN = log(EAWE21$EARNINGS)
R4 = lm (LGEARN ~ EAWE21$S +EAWE21$EXP + EAWE21$MALE + EAWE21$ETHBLACK + EAWE21$ETHHISP)
summary(R4)
R5 = lm(LGEARN ~ EAWE21$S +EAWE21$EXP + EAWE21$MALE + EAWE21$ETHBLACK + EAWE21$ETHHISP + EAWE21$ASVABC)
summary(R5)

tabla63 = data.frame(EAWE21$S, EAWE21$EXP, EAWE21$MALE, EAWE21$ETHBLACK, EAWE21$ETHHISP, EAWE21$ASVABC)
cor(tabla63)

#Cuando tenemos mas variables, no es posible determinar el valor del sesgo pero si su signo.
#Suponiendo que en la reg4 se omitio ASVABC y esta es relevante, y en la 5 no:
#todos los coef de la reg5 son mas peque?os que en la 4, lo que nos da indicios
#de que se estaria sobreestimando, o con sesgo positivo. 

#omitida
#LGEARN =  1.07334+ 0.09541 S+0.04086 exp+ 0.18572male -0.08594 ethblack -0.09780 ethhisp
#verdadera
#LGEARN =  1.19380+ 0.08620 S+0.04017 exp+ 0.18362male -0.05000 ethblack -0.07706 ethhisp +0.05320 asvabc

