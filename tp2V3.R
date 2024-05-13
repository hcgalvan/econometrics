## ----------------------------------------------------------------------------------------------------------------------
# Generar variables y datos de muestra
# set.seed(123)
set.seed(sample(1:10000, 1))
salario_semanal <-300000 
# experiencia(0 = Falso, 1 = Verdadero)
experiencia <- sample(0:10, 1000, replace = TRUE)
# Género (0 = Femenino, 1 = Masculino)
genero <- sample(c(0, 1), 1000, replace = TRUE)
# Universidad (0 = Pública, 1 =  Privada)
universidad <- sample(c(0, 1), 1000, replace = TRUE)

#valores
μ_gen <- (0.18 * salario_semanal)
μ_exp <- (0.05 * salario_semanal) # 35% en 5 años entonces 35/5 = 5% por año
μ_univ <- (0.17 * salario_semanal)
error_std_dev <- 50000 #tomando la mitad del valor salarial lo divido en 3 partes

# Salario semanal en pesos
salario <- salario_semanal + μ_gen * genero + μ_exp * experiencia + μ_univ * universidad + rnorm(1000, 0, error_std_dev)

dat <- data.frame(salario, genero, experiencia, universidad)
plot(salario)


## ----------------------------------------------------------------------------------------------------------------------
# Ajustar el modelo de regresión lineal
# Salario semanal en pesos
#set.seed(123)
modelo <- lm(salario ~ genero + experiencia + genero * universidad)
summary(modelo)



## ----------------------------------------------------------------------------------------------------------------------
e2=(modelo$residuals)^2
plot(modelo$fitted.values,e2 , main = "e2 en funcion de Y ajustado",
     xlab = "Y ajustado", ylab = "resid al 2")


## ----------------------------------------------------------------------------------------------------------------------
# Gráfico de residuos vs. valores ajustados
plot(modelo, which = 1)


## ----------------------------------------------------------------------------------------------------------------------
# Prueba de Goldfeld-Quandt
library(lmtest)
gqtest(modelo)


## ----------------------------------------------------------------------------------------------------------------------
# Errores estándar robustos a heterocedasticidad
library(sandwich)
coeftest(modelo, vcov = vcovHC(modelo, type = "HC1"))



## ----------------------------------------------------------------------------------------------------------------------
# Función para realizar una regresión y guardar la recta de regresión
realizar_regresion_y_guardar_recta <- function(...) {
  # Generar datos de muestra
  set.seed(sample(1:10000, 1))  # Semilla aleatoria
  salario_semanal <-300000 
  # Género (0 = Femenino, 1 = Masculino)
  genero <- sample(c(0, 1), 1000, replace = TRUE)
  # Universidad (0 = Pública, 1 =  Privada)
  universidad <- sample(c(0, 1), 1000, replace = TRUE)
  #valores
  μ_gen <- (0.18 * salario_semanal)
  μ_univ <- (0.17 * salario_semanal)
  error_std_dev <- 50000 #tomando la mitad del valor salarial lo divido en 3 partes

  salario <- salario_semanal + μ_gen * genero + μ_univ * universidad + rnorm(1000, 0, error_std_dev)
    
  # Ajustar el modelo de regresión lineal
  modelo <- lm(salario ~ genero + genero * universidad)

    # Guardar la recta de regresión
  recta <- data.frame(
    genero = 0:1,
    salario = coef(modelo)[1] + coef(modelo)[2] * (0:1) # Ecuación para genero = 0, universidad = 1
  )
  return(recta)
}

# Realizar la simulación de Monte Carlo
resultados <- lapply(1:10, realizar_regresion_y_guardar_recta)

# Graficar todas las rectas de regresión en un solo gráfico
plot(NULL, xlim = c(0, 1), ylim = c(290000, 360000), xlab = "Genero", ylab = "Salario", main = "Rectas de Regresión")
for (i in 1:10) {
  lines(resultados[[i]]$genero, resultados[[i]]$salario, col = i)
}
#legend("topright", legend = paste("Regresión", 1:10), col = 1:10, lty = 1)



## ----------------------------------------------------------------------------------------------------------------------
# Función para realizar una regresión y guardar la recta de regresión
realizar_regresion_y_guardar_recta_2 <- function(...) {
  # Generar datos de muestra
  set.seed(sample(1:10000, 1))  # Semilla aleatoria
  salario_semanal <-300000 
  # Género (0 = Femenino, 1 = Masculino)
  genero <- sample(c(0, 1), 1000, replace = TRUE)
  # Universidad (0 = Pública, 1 =  Privada)
  universidad <- sample(c(0, 1), 1000, replace = TRUE)
  #valores
  μ_gen <- (0.18 * salario_semanal)
  μ_univ <- (0.17 * salario_semanal)
  error_std_dev <- 50000 #tomando la mitad del valor salarial lo divido en 3 partes

  salario <- salario_semanal + μ_gen * genero + μ_univ * universidad + rnorm(1000, 0, error_std_dev)
    
  # Ajustar el modelo de regresión lineal
  modelo <- lm(salario ~ genero + genero * universidad)

 # Guardar la recta de regresión
  recta <- data.frame(
    interaccion = c(0, 1), # 0 = mujer y universidad privada, 1 = hombre y universidad pública
    salario = c(coef(modelo)[1], coef(modelo)[1] + coef(modelo)[2] + coef(modelo)[3])
  )
  return(recta)
}

# Realizar la simulación de Monte Carlo
resultados <- lapply(1:10, realizar_regresion_y_guardar_recta_2)

# Graficar todas las rectas de regresión en un solo gráfico
plot(NULL, xlim = c(0, 1), ylim = c(290000, 400000), xlab = "Interacción Género-Universidad", ylab = "Salario", main = "Rectas de Regresión")
for (i in 1:10) {
  lines(resultados[[i]]$interaccion, resultados[[i]]$salario, col = i)
}
#legend("topright", legend = paste("Regresión", 1:10), col = 1:10, lty = 1)

