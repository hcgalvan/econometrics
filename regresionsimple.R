
library(ggplot2)

# Generar datos
set.seed(123)
x <- rnorm(100, mean = 50, sd = 10) # variable independiente
y <- 2 * x + rnorm(100, mean=0, sd=5) #variable dependiente

#crear un dataframe
datos <- data.frame(Consumo=x, PBI=y)

# Visualizar
head(datos)

# realizar regresion simple
rgln<- lm(PBI~Consumo,data=datos)
summary(rgln)
# graficar
grafico <- ggplot(datos, aes(x=Consumo, y=PBI)) +
  geom_point() +# grafico de dispersion de puntos
  geom_smooth(method = "lm", se = FALSE)+
  labs(title = " Regresion simple: Consumo vs PBI",
       x = "consumo",
       y= "PBI")
print(grafico)  
