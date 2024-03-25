
# Que es R?
# Es un lenguaje de programacion interpretado,
# de distribucion libre, bajo Licencia GNU, y se mantiene en un ambiente
# para el computo estadistico y grafico.
#R es un entorno y lenguaje de programación con un enfoque al análisis estadístico.

#R nació como una reimplementación de software libre del lenguaje S, 
#Se trata de uno de los lenguajes de programación más utilizados en investigación científica, 
#siendo además muy popular en los campos de aprendizaje automático (machine learning), minería de datos, investigación biomédica, bioinformática y matemáticas financieras.

################################Crear un proyecto o Directorio ############################
#Es una carpeta donde estaran todos nuestros datos, nuestras bases, etc, de ahi R sabra que tiene que tomar la informacion
#cuando carguemos la sesion del proyecto
#proyecto o directorio

#File > New Proyect

############################### Formato del codigo en el texto ######################################

# En seguida asignaremos mediante codigo de R el valor 2014 a una variable llamada 'x':
a <- 2014 #puedo asignar con un = tambien 
# Ahora vamos a imprimir el valor de la variable
print(a)
a
2*a

# Algunas caracter?sticas importantes de R
# R esta dividido en dos partes conceptuales: 1) El sistema base
# de R, que es el que puedes bajar de CRAN; y, 2) en todo lo demas (librerias).
# Su pagina Web es: http://cran.rproject.org/
# ventaja -> comunidad muy activa 


##################################### Ayuda en R ####################################################
help(lm)
?lm

#Para preguntar por caracteres especiales
help("if")

##################################### Tipo de datos ####################################################
# numerico
nota <- 9.5
class(nota)

# integer
nota <- as.integer(nota)
class(nota)

#complex
x <- 21+2i
class(x)

#NaN  (Not a Number)
x1<- 0/0
x1

# character
apellido <- "GARCIA"
class(apellido)

# logico/booleano
compu<-"TRUE"
class(compu)
compu<-T
class(compu)

########################################## Vectores ####################################################

#En los objetos anteriores, R crea un vector de longitud=1
a <- 2014
a
#[1] 2014  [1] nos muestra elemento del vector, en este caso el elemento 1

#Crear vectores mas largos con funcion concatenar
x2 <- c(4,5,8)
#se crea una variable x2 con tres elementos(mirar en el enviroment)
assign("x3", c(5,8,9))
#usando el operador =
x4=c(7,6,3)

#tamb podemos crear vectores con dstintos tpos de datos
vector1 <- c(1, 2, "tres")
class(vector1)

#Acceso a los elementos individuales de un vector
v1 <- c(8, 7, -3, 2, 182)
v1[5] # El quinto elemento
print(v1[1]); print(v1[3])

v1[4]+v1[2] # La suma del cuarto y segundo elementos de v

#modificar algun elemento de un vector

v1[1] <- 3
v1 
v1[4] <- v1[2] - v1[5]
v1 # Note que el resultado de la operacion se ha guardado en v[4]


#Si se asigna un valor al elemento 8, el elemento 6 y 7 = NA
v1[8] <-20
v1

#suponagamos que tenemos un vector con cantidades de dstintas frutas
frutas <- c(45,8,25,99)
#ahora queremos que asocie esas cantidades con los nombres de las frutas,
#podemos usar la funcion names()
names(frutas)<- c("sandia", "manzana", "pera", "kiwi")
frutas

#otra forma
frutas2 <- c(sandia=8, manzana=20, pera=65, kiwi=5)
frutas2

frutas["sandia"]

####################################Operaciones con Vectores #########################################


v <- c(2, 3) - c(5, 1) # Resulta en un vector de longitud 2
v

#para ver una prueba logica
frutas <= 10 # Prueba elementos menores o iguales a 10

#para conocer la longitud de una vector. La funci?n
length(frutas)


#################################### Matrices #######################################################

#vector entero de dos elementos: el numero de filas y el numero de columnas

#Construccion de matrices

(m1 <- 11:30) # Un vector con 20 numeros
# Para convertirla en matriz simplemente se especifica el atributo dim (dimension)
dim(m1) <- c(4, 5) # 4 filas y 5 columnas
m1
#prestar atencion que ordena por columna

# Y el elemento en el renglon 3 y columna 2 es:
m1[3, 2]


#tamb podemos usar una funcion
m2 <- matrix(1:20, nrow = 5, ncol = 4)

m2 <- matrix(1:20, nrow = 5, ncol = 4, byrow = TRUE)

#filas y las columnas de una matriz se les pueden asignar nombres

rownames(m2) <- c("uno", "dos", "tres", "cuatro", "cinco")
colnames(m2) <- c("col1", "col2", "col3", "col4")

# Consulta de los nombres de las columnas
colnames(m2)

#Las funciones rbind() y cbind()

m3 <- rbind(c(1.5, 3.2, -5.5), c(0, -1.1,5)) #agrega filas
m3
m3 <- cbind(c(1.5, 3.2, -5.5), c(0, -1.1,5)) #agrega columnas

#tambien podemos trasponer
t(m3)

####################################### Factores########################################################
###################################### Listas #####################################################

#es una clase de datos que puede contener cero o mas elementos,
#uno de los cuales puede ser de una clase distinta
familia <- list("Maria", "Juan", 10, c("Hugo", "Petra"), c(8, 6), T)

familia <- list(madre="Maria", padre="Juan", casados=10,
                hijos=c("Hugo", "Petra"), edades=c(8, 6))
# Acceso de lectura
familia$madre
familia[["madre"]]

#modificar valor
familia[["madre"]] <- "Marta"

###################################### Data frames #################################################

#es una lista, cuyos componentes pueden ser vectores, matrices
#o factores, con la unica salvedad de que las longitudes, o numero de
#renglones, en el caso de matrices, deben coincidir en todos los componentes.



vec <- cbind(ord=1:3, edad=c(30, 26, 9))
vec
vec2 <- c(1.80, 1.72, 1.05)
df1 <- data.frame(familia=c("Padre", "Madre", "Hijo"),
                 vec, estatura=vec2)
class(df1)
str(df1)




######################################## conversion #######################################################
x <- 1.03
x
class(x)

y <- as.integer(x) # conversion a entero
y
class(y)

z <- as.complex(y) # conversion a complejo
class(z)

a <- c("1000", "2013.1", "0")
class(a)

b <- as.numeric(a) # conversion de character a otro tipo
b
class(b)

c <- as.logical(b) # conversion a logico
c

mtx <- matrix(1:20, nrow = 5, ncol = 4)
df_m <- as.data.frame(mtx)


################################Operadores logicos#######################
edad1 <- c(12,21,20,19)
edad2 <- c(50,29,6,52)
edad1>edad2
edad2>=20 & edad2<30
edad1>=20 | edad1<15
!(edad1>=20 | edad1<15) #negar, invertir resultado

edad1>20 & edad2<30

#operador %in %

#Esta funcion utiliza el operador %in %, que identifica si un 
#cierto elemento esta dentro de un conjunto representado por un vector

c(2,3,4) %in% c(2,4,6,8,10)
#cada uno de los elementos de un vector, estan contenidos en el conjunto representado por otro vector

#################################Las construcciones IF-ELSE#################################
aa <- 20
if (aa > 14) {print ("MAYOR")}
if (aa < 14) {print ("Menor")}

#IF admite una sola expresion, pero esta puede ser una expresion compuesta, 
#que se construye mediante los parentesis de llave { }
#y las expresiones en su interior, separadas ya sea por el cambio de renglon o por ;

if (aa< 10) { # 1er. bloque
  print("Menor")
} else if ( 10 <= aa && aa <= 20) { # 2o. bloque
  print("Medio")
} else { # 3er. bloque
  print("Mayor")
}

#podemos usar varios else if
if (aa< 10) { 
  print("Menor")
} else if ( 10 <= aa && aa <= 20) { 
  print("Medio1")
} else if ( 20 <= aa && aa <= 30) { 
  print("Medio2")
} else { 
  print("Mayor")
}

#podemos poner varias expresiones en un bloque
if (aa< 10) { 
  print("Menor")
} else if ( 10 <= aa && aa <= 20) { 
  print("Medio1");print("Rango de interes")
} else if ( 20 <= aa && aa <= 30) { 
  print("Medio2")
} else { 
  print("Mayor")
}


#forma mas sencilla
ifelse(aa>10, "mayor","Menor") #al 1er -->true al 2do -->false


#ciclos
letras <- c("c", "l", "i", "M", "T", "A")
for (i in 1:6) {
  print(letras[i])
}

for (letra in letras) { 
  print(letra)}
 #va tomando uno a uno los elementos del objeto. OJO: "letra" es como el "i" del objeto letras 
  
###Repeticiones mientras se cumple una condicion
#while: hara un procedimiento hasta que se deje de cumplir un crterio establecido,
#por eso es un ciclo
autos <- 1
#creamos un while y le decimos que corra esa funcion hasta que autos=10
while(autos<10) {
  print(paste("el numero de autos al momento es", autos))
  autos <- autos+1
}
#autos <- autos+1 esa parte es importante porq sino correra infinitamente

#for loop
poblacion <- c(1000,1500,1600,2000)
for(pob in poblacion) {
  print(pob*2)
}
#pob le llama a los elementos individuales de poblacion, es como el "i"

########################apply y lapply###############################
#apply: aplica una funcion a una lista
#primero craemos una lista con dos elementos
culebra <- list(pop=1868,
                barrios=c("Barrio Pueblo","Fleamenco", "Fraile","Playa Sardinas I",
                          "Playa Sardinas II", "San Isidro"))
lapply(culebra,class)
#ponemos la funcion lappl, en el primer argumento nuestra lista o vector, etc
#la funcon que queremos correr para cada elemento de la lista

estudiantes <- c("Maria", "Jose","Pablo")

lapply(estudiantes, nchar)

#nchar es una funcion que devuelve la cantidad de letras qe tiene cada elemento

#podemos pedirle que no nos presente como una lista, sino como un vector
unlist(lapply(estudiantes, nchar))

#con apply podemos aplicar y usar funciones

gasto <- list(1000,1502,1236,2506)
#aca estoy por crear una funcion con sus argumentos y la operacion
propina <- function(consumo, prop=0.10){
  return(consumo*prop)
}
unlist(lapply(gasto, propina))

###sapply
estudiantes <- c("Maria", "Jose","Pablo")
lapply(estudiantes, nchar)

sapply(estudiantes, nchar)

cuenta <- function(consumo, prop=0.10, tax=0.2){
  c(propina=consumo*prop,
    impuesto=consumo*tax)
}

sapply(gasto, cuenta)


################################## Funciones ##########################################################
  #La sintaxis para la creacin de una funcion es como sigue:
  #variable <- function(arg_1, arg_2, ..., arg_n) expresion
 #las funciones tienes dos momentos
  #1 la definicion
hipotenusa <- function(x, y) {
    sqrt(x^2 + y^2)
  }
  
 #la ejecucion
  #si queres usar esa funcion, debemos asignarle valores a x e y
  hipotenusa(y = 4, x = 3)
  hipotenusa(3,5)
  
  
funcion1 <- function(x, y, z, t){
    f1 <- x^2 + y^2+z
    f1}
  
funcion1(2,5,1,6)



#################################IMPORTAR BASES###############################################################
#Para importar bases debo considerar el el formato del archivo

#si es iun archivo de STATA=> .dta 
library(haven)
dataset <- read_stata(NULL)
View(dataset)
#si es iun archivo de texto o csv => .csv
library(readr)
dataset <- read_csv(NULL)
View(dataset)
#si es formato excel => .xls o .xslx
library(readxl)
dataset <- read_excel(NULL)
View(dataset)


############################## graficos #######################

# Datos
x <- c(1, 2, 3, 4, 5)
y <- c(200, 300, 600, 700, 500)

# Vectores
plot(x, y, type = "l")

# Fórmula
plot(y ~ x, type = "l",
     col = "lightblue", # Color
     lwd = 5)           # Ancho de línea) 

#Link: https://r-coder.com/grafico-puntos-r/
