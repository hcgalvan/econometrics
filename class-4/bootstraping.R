
#### Ejercicio de Bootstrap
#Creamos un proyecto y cargamos toda la base de datos y script allí-
### Instalar el paquete boot
library(boot)

#Bootstrapping es un método que se puede utilizar para estimar el error estándar 
#de cualquier estadístico y producir un intervalo de confianza 
#para ese estadístico.

#El proceso básico para el bootstrapping es el siguiente:
  
# Se toman k muestras repetidas con reemplazo de un conjunto de datos dado.
#Para cada muestra, se calcula la estadística que sea de interés.
#Esto da como resultado k estimaciones diferentes para un estadístico dado, 
#que luego se puede usar para calcular el error estándar de dicho estadístico
#y crear un intervalo de confianza también.

#### Cargamos la base de datos
EAWE08 <- read_dta("EAWE08.dta")
 View(EAWE08)
 ### el modelo que vamos a estudiar es EARNINGS = bo + b1 FEMALE + b2 S + U, U= error
 
 ### Ejemplo 1: Boostrap para un sólo estadístico
 
 #El siguiente código muestra cómo calcular el error estándar para el R-cuadrado 
 #del  modelo de regresión lineal anterior:
 
 set.seed(0)

 
 #define function to calculate R-squared
funcionr2<- function(formula, data, indices) {
   d <- data[indices,] #permite "bostreapear" la muestra
   modelo <- lm(formula, data=d) #ajusta o estima el modelo de regresión
   return(summary(modelo)$r.square) #muestra o devuelve el R2 del modelo
 }
 #hacemos un bootstrapping con 2000 replicaciones
 reps <- boot(data=EAWE08, statistic=funcionr2, R=2000, formula=EARNINGS~FEMALE+S)
 
 #Observamos los resultados del boostrapping
 reps
# El R2 estimado es 0.109 y el error estándar es 0.03

 #Graficamos 
 plot(reps) # ¿ qué observa?
 
##Calculamos los intervalos de percentil de boostrap ajustado (BCa)
 ## Colocar en el Help boot.ci
 boot.ci(reps, type="bca")
# A partir de la salida, podemos ver que el intervalo de confianza del Bootstrap al 95% 
 #para los verdaderos valores de R-cuadrado es (0.048, 0.1750)
 
 
 ### Bootstrap para varios estadísticos (por ejemplo para los coeficientes)
 
 set.seed(0)
 
 #definimos la función para calcular los coeficientes de regresión estimados 
funcioncoef <- function(formula, data, indices) {
   d <- data[indices,] # permite "bostreapear" la muestra
   modelo <- lm(formula, data=d) #ajusta el modelo de regresión
   return(coef(modelo)) #devuele los coeficientes de regresión estimados
 }
 
#hacemos un bootstrapping con 2000 replicaciones
reps1 <- boot(data=EAWE08, statistic=funcioncoef, R=2000,formula=EARNINGS~FEMALE+S)

#Observamos los resultados del boostrapping
reps1
# La estimación de la constante es 1.11 (3.13), de b1 es -4,53 (0.98) y de b2 1.36 (0.199)

#Graficamos cada uno de las distribuciones de los coeficiones 


plot(reps1, index = 1)
plot(reps1, index = 2)
plot(reps1, index = 3) # ¿qué observa?

#Intervalos de confianza
boot.ci(reps1, type="bca", index=1) #bo
boot.ci(reps1, type="bca", index=2) #b1
boot.ci(reps1, type="bca", index=3) #b2

