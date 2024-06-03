## ------------------------------------------------------------------------------------------------------------
# Establecer la semilla para reproducibilidad
set.seed(123)

# Definir la media y el desvío estándar deseados
X <- 50
Z <- 10

# Generar una muestra de 100 datos con distribución normal
muestra <- rnorm(n = 100, mean = X, sd = Z)

# Imprimir los primeros 10 elementos de la muestra
head(muestra, 10)
plot(muestra)


## ------------------------------------------------------------------------------------------------------------
# Paso 1: Generar una muestra con 100 datos
set.seed(123) #
X <- 75
Z <- 15
muestra <- rnorm(100, mean = X, sd = Z) #rnorm genera muestras aleatorias con distribución normal, y nos permite establecer la media y el error estandar manualmente. Lo guardamos en "muestra"

# Paso 2: Obtener 20 muestras bootstrap
n_bootstrap <- 20
muestras_bootstrap <- lapply(1:n_bootstrap, function(i) sample(muestra, replace = TRUE)) # lapply genera una lista cuyos elementos son vectores del tamaño/largo 20 (obtenidos de n_boostrap), generados en "function" que contiene muestras generadas con "sample" con reemplazo "replace=True" a partir de datos originales llamada "muestra". Esta lista es guardada en "muestras_bootstrap"
 
# Paso 3: Calcular la mediana para cada muestra bootstrap
medianas_bootstrap <- sapply(muestras_bootstrap, median) # sapply es función vectorizada que permite iterar sobre una lista o vector sin la necesidad de usar el bucle for. Entonces, itera sobre la lista "muestras_bootstrap" que contiene vectores y devuelve la mediana en una lista que son guardadas en "medianas_bootstrap".

# Paso 4: Calcular los errores estándar de la distribución de medianas y graficar
error_estandar <- sd(medianas_bootstrap) #sd nos devuelve el error estandar de los valores guardados en "medianas_bootstrap"
hist(medianas_bootstrap, main = "Distribución de medianas bootstrap", xlab = "Mediana") 
abline(v = median(muestra), col = "red", lwd = 2)
legend("topright", legend = paste("Error estándar =", round(error_estandar, 2)), bty = "n")

# Se observa que las medianas de las muestras bootstrap se distribuyen alrededor de la mediana de la muestra original. # El error estándar proporciona una estimación de la variabilidad de la mediana.

# Paso 5: Generar una función para calcular los errores estándar por bootstrap
# La función "calcular_error_estandar_bootstrap" devuelve el error estandar a partir de la entrada de una "muestra" que son capturadas con nombre "datos" y el tamaño del boostrap con nombre "n_bootstrap", se utilizan las funciones lapply y sapply para generar bootstraping y obtener el error estandar de "la mediana"
calcular_error_estandar_bootstrap <- function(datos, n_bootstrap) {
 muestras_bootstrap <- lapply(1:n_bootstrap, function(i) sample(datos, replace = TRUE))
 medianas_bootstrap <- sapply(muestras_bootstrap, median)
 error_estandar <- sd(medianas_bootstrap)
 return(error_estandar)
}

# Calcular el error estándar con la función
error_estandar_bootstrap <- calcular_error_estandar_bootstrap(muestra, n_bootstrap)
print(error_estandar_bootstrap) #imprime el error estandard del boostrap

