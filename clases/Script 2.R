# Cargar el paquete ggplot2
library(ggplot2)

# Generar datos de ejemplo
set.seed(123)
x <- rnorm(100, mean = 50, sd = 10)  # Variable independiente (por ejemplo, consumo)
y <- 2 * x + rnorm(100, mean = 0, sd = 5)  # Variable dependiente (por ejemplo, PBI

# Crear un data frame con los datos
datos <- data.frame(Consumo = x, PBI = y)

# Visualizar los primeros registros del data frame
head(datos)

# Realizar la regresión simple
modelo <- lm(PBI ~ Consumo, data = datos)

# Resumen del modelo
summary(modelo)

# Graficar los datos y la línea de regresión
grafico <- ggplot(datos, aes(x = Consumo, y = PBI)) +
  geom_point() +  # Gráfico de dispersión de puntos
  geom_smooth(method = "lm", se = FALSE) +  # Línea de regresión
  labs(title = "Regresión simple: Consumo vs PIB",
       x = "Consumo",
       y = "PBI")

# Mostrar el gráfico
print(grafico)
