
a<- 2014
print(a)
a
2*a
#################
help(lm)
?lm
################ Tipo de Datos ##################
nota <- 9.5
class(nota)

# integer
nota <- as.integer(nota)
class(nota)

#complex
x<-21+2i
class(x)

#NaN (Not a Number)

x1<- 0/0

# Character
apellido <- "GALVAN"
class(apellido)

# Logical
compu <- TRUE
class(compu)

# crear vectores mas largos
x2 <- c(4,5,8)

# crea una variable x2 con tres elementos 
assign("x3", c(5,8,9))

# usando el operador =
x4=c(7,6,3)

# tambien podemos crear vectores de distintos datos
vector1 <- c(1,2,"tres")
class(vector1)

#Acceso a los elementos individuales de un vector
v1<- c(8,7,-3,2,182)
v1[5]
print(v1[1]); print(v1[3])
c(v1[1], v1[5])

v1[4]+v1[2]

# Modificar un vector
v1[1]<- 3
v1[4]<- v1[2]-v1[5]

# si se asigna un valor al elemento 8, el elemento 6 y 7 = NA
v1[8]<-20
v1

#supongamos que tenemos un vector con cantidades de distintas frutas
frutas <- c(45,8,25,99)
# quiero que se asocie a nombres
names(frutas)<- c("sandia", "manzana", "pera", "kiwi")
frutas

# otra forma
frutas2 <- c(sandia=8)
frutas2
frutas["sandia"]

### pruebas logicas
frutas <- 10
# para conocer la longitud
length(frutas)

# construccion de matrices
(m1 <- 11:30)
# otra forma

dim(m1)<- c(4,5)
m1
diag(m1) # diagonal de la matriz
# renglon 3 y columna 2
m1[3,2]

# lista
famila <- list("maria", "juan",10, c("hugo", "Petra"), c(1,5))

#### Data frames####################
vec <- cbind(ord=1:3, edad=c(30,26,9))
vec2<- c(1.80, 1.72, 1.05)
df1 <- data.frame(familia=c("Padre", "Madre", "Hijo"), vec, estatura=vec2)
str(df1)
class(df1)

########### operadores logicos
edad <- c(12,21,20,19)
edad2 <-c(50,29,6,52)
edad>edad2
edad2>=20 & edad2<30
edad2>=20 | edad < 15
!(edad>=20 | edad<15)

########### 
aa<- 20
if (aa<10){
  print("menor")
} else if(10 <=aa && aa<=20) {
    print("nosse")
} else {
  "ver que pasa"
}

########## ciclos, 
letras <- c("c", "l","M", "T", "A")
for (i in 1:6){
  print(letras[i])
}

for (letra in letras){
  print(letra)
}
while i < 20 {
  
}
############### Funciones
hipotenusa <- function(x,y){
  sqrt(x^2 + y^2)
}
# la ejecucion
hipotenusa (y=4, x=3)
hipotenusa(3,5)

########## cargar datos



########## graficar

