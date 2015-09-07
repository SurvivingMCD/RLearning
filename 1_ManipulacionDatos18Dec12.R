
###############################################################################
#                             INTRODUCCION A R                                #
#                          MANIPULACION DE DATOS                              #
#                                                                             #
#                         Paulina Preciado Lopez                              #    
#                             18 / Dic / 2012                                 #
###############################################################################

###############################################################################

#------------------------------------------------------------------------------
# 1. OBJETOS, CLASES, MODAS Y ATRIBUTOS
#------------------------------------------------------------------------------

# R opera sobre estructuras de datos conocidas como objetos 

# Para asignar un valor a una variable utilizamos "<-". Por ejemplo, si queremos
# asignar el valor 10 a la variable "x" usamos:

  (x <- 10)

# Para crear un vector "y" con entradas 1, 2, 3.4, 5, 11, 6.23, -2, -1.1

  (y <-  c(1, 2, 3.4, 5, 11, 6.23, -2, -1.1))

    # Notar el uso de la funcion c()

# Tambien podemos asignar una variable a otra o a una operacion

  z <- y + 2

# Algunos objetos usuales son

  # Vectores 
  # Matrices y Arreglos
  # Factores
  # Listas
  # Cuadros de datos
  # Funciones
  # Modelos lineales

#------------------------------------------------------------------------------
# 1.1 VECTORES
#------------------------------------------------------------------------------

# Los vectores son las estructuras mas basicas y representan colecciones ordena-
# das de datos del mismo tipo (moda)

# Pueden ser: 
  # Numeric (integer, double)
  # Complex
  # Character
  # Logic

# La moda de un vector puede obtenerse con la funcion mode(). Notar que las en-
# tradas pueden ser forzadas a ser del mismo tipo

  (a <- c(1, 2, 3))
  mode(a)

  (a <- c("hola", 2, 3))
  mode(a)

  (a <- c(1, 2, 3, 4, 5 + 3i))
  mode(a)

# Mas adelante veremos objetos que admiten distintos tipos de datos

# Ademas del tipo de datos, otra caracteristica importante de un vector es su 
# longitud, que puede obtenerse con la funcion length()

  length(x)
  length(y)
  length(a)

# Esto tambien puede observarse en la ventana del espaciode trabajo "Workspace"
# en RStudio.
# Notar que Los escalares son vectores de longitud 1

#------------------------------------------------------------------------------
# 1.1.1 Operaciones con vectores numericos
#------------------------------------------------------------------------------

# Los vectores numericos y complejos pueden usarse en operaciones aritmeticas 
# que se realizan entrada por entrada.

  y * 2 # Producto
  y + y # Suma
  y / y # Division
  y ^ 2 # Potencia
  y - 5 # Resta
  
# Si los vectores no son de la misma longitud, el resultado de la operacion ten-
# dra la longitud del vector mas largo. Los vectores mas cortos se repiten hasta
# tener la longitud del vector mas largo

  y + x      
    # Suma "x" (escalar) a cada entrada de "y"

  y * c(1, 2) 
    # Repite el vector (1,2) cuatro veces y multiplica entrada por entrada

  y * c(1, 2, 3)
    # Repite el vector (1,2,3) hasta alcanzar longitud 8: (1,2,3,1,2,3,1,2)
    # y multiplica entrada por entrada
    # Genera un warning porque la longitud de "y" no es multiplo de la longi-
    # tud del vector (1,2,3)

# Algunas otras operaciones comunes:

  # log
    log(0)
    log(10, base = 10)

  # exp
    exp(1)
    exp(log(2))

  # %%
    10 %% 8

  # % / %
    27 %/% 12
  
  # sin, cos, tan, etc.
    cos(3*pi)
  
  # sqrt
    sqrt(25)
    sqrt(-4)
    sqrt(-4 + 0i)
  
  # min, max
    min(y)
    max(y)

  # range
    range(y)
    range(x)
  
  # sum
    sum(y)
    sum(a)
  
  # mean
    mean(y)
    mean(a)
  
  # abs
    abs(y)
    abs(a)

  # round
    round(y)

  # ceiling, floor

    ceiling(y)
    floor(y)

  #sort
    sort(y)

#------------------------------------------------------------------------------
# 1.1.2 Crear secuencias regulares
#------------------------------------------------------------------------------

# "n : m" genera una secuencia (vector numerico) con separaciones de 1 si m > n
# y de -1 si m < n

  1 : 10
  0 : -10
  1.55 : 3.40

# m se incluye si m - n es un entero

-1.35 : 2.65
6.8:-5.2

# El operador : tiene jerarquia alta, solamente ^ es mas
# importante

  1:10 - 1
  1:(10-1)
  3*1:5
  (3*1):5
  3^2:4
  3^(2:4)

# La funcion seq() da mas facilidades

  ?seq

# Los argumentos posibles son from, to, by, length.out (abre-
# viado length o len) y along.with (abreviado along)

# Ejemplos de los usos tipicos

  seq(1, 5) #Equivalente a 1:5
  seq(1, 5, by = 0.2)
  seq(1, 5, length = 21) # Equivalente a la anterior
  seq(from =  10, along = y)
  seq(50)
  seq(-10)
  seq(length = 11)

# Para replicar valores podemos usar la funcion rep
  rep(10,5)
  rep(y, 2)

#------------------------------------------------------------------------------
# 1.1.3 Vectores logicos
#------------------------------------------------------------------------------

# R tambien puede manipular vectores logicos con elementos
# TRUE, FALSE que se generan por expresiones logicas

  y > 3
  y

# Los operadores logicos son
  #* < , <= ,  > , >=
    y > 5
    y >= 5
    y
  #* ==, !=
    y == 5
    y != 5
  #* &&, |
    (i <- sample(1:15 , 1))
    (y < i) | (y > 2*i)

#* !
    !(y > 5) #Equivalente a (y <= 5)

# Se pueden usar vectores logicos en operaciones aritmeticas. R tratara de for-
# zarlo a ser un vector numerico donde FALSE es 0 y TRUE es 1

  (a <- c(1:5, FALSE))
  (b <- rep(c(FALSE, TRUE), 3))
  a +  b

#------------------------------------------------------------------------------
# 1.1.4 Valores especiales NA, Inf, -Inf, NaN
#------------------------------------------------------------------------------

# NA
  # Logico: Valor faltante, no disponible (not available,
  # missing)

  (a <- c(1:5, NA))

  # La funcion is.na(vec) da como resultado un vector logico de la longitud de 
  # vec indicando que entradas son valores faltantes

  (b <- is.na(a))

  # Cualquier operacion con NA da NA como resultado

  (a + NA)
  (a == NA)

# Inf, - Inf
  # Numerico (double) para denotar infinito y -infinito

  1000 / 0
  2 * Inf

# NaN
  # Numerico (double) y valor faltante. Significa "Not a number" y surge si el 
  # resultado de una operacion numerica no esta definido

  0 / 0
  Inf - Inf

  is.na(NaN)
  is.nan(NaN)
  is.nan(NA)

#------------------------------------------------------------------------------
# 1.1.5 Vectores de caracteres
#------------------------------------------------------------------------------

# Las cadenas de caracteres en R se ingresan usando " " o ' '

  (p <- "palabra")

# Podemos crer un vector de caracteres usando c()

  (carVec <- c("hola", "bueno", p, "si"))
  
# Si concatenamos un vector numerico o logico a un vector de caracteres, todos
# los elementos se obligan a ser caracteres

  c(carVec, TRUE, 2, Inf, NaN)

# Con excepcion de NA

  c(carVec, NA)

# La funcion paste() concatena vectores despues de convertirlos en caracteres.
# Los argumentos son los vectores a concatenar y una cadena separadora "sep" 
# cuyo default es " ", un espacio

  paste("alumno", 1:5, sep = " ")
  paste("alumno", 1:5, sep = "***")

  paste("El resultado de", a, "fue", b)

#------------------------------------------------------------------------------
# 1.2 OTROS OBJETOS
#------------------------------------------------------------------------------

# Los vectores son los objetos mas elementales. Se llaman objetos atomicos porque
# sus elementos son de un solo tipo o moda (exceptuando NA).

# Las matrices y los arreglos tambien son objetos atomicos.

# Otros objetos, como las listas, permiten varios tipos de datos (inclusive otras
# listas). Estos objetos se llaman no atomicos. Ademas de las listas, las tablas
# de datos y las funciones son objetos no atomicos.

# Las funciones mode() y class() nos dan el tipo de valores u objetos que admite
# un objeto y la clase a la que el objeto pertenece

# Para vectores simples la moda y la clase son iguales

  mode(y); class(y)
  mode(carVec); class(carVec)

# Para una matriz de valores numericos, la moda es "numeric" y la clase es 
# "matrix"

  (mat <- matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3, dimnames = list(c("r1","r2")
  ,c("c1","c2", "c3")),byrow = TRUE))

  mode(mat); class(mat)

# Otras clases posibles son "array", "data.frame", "factor", etc.

# La clase determina como R trata al objeto para algunas funciones generales 
# (como imprimir, graficar, resumir, etc.). Esto se conoce como programacion 
# orientada a objetos

# Por ejemplo

  summary(y)
  summary(mat)

# Ademas de la moda y la clase, otros atributos basicos son la longitud y/o 
# dimension de un objeto

  length(y)
  dim(y)
  length(mat)
  dim(mat)

# Otros atributos pueden obtenerse con la funcion attributes()
  
  attributes(mat)

# Los atributos tambien pueden asignarse con la funcion attr()

  attr(mat, "nombre") <- "Mi Matriz"

#------------------------------------------------------------------------------
# 1.2.1 Matrices y arreglos
#------------------------------------------------------------------------------

# Los arreglos son conjuntos de elementos multi-indexados. Por ejemplo, un
# vector simple es un arreglo de una dimension y una matrix es un arreglo de
# dos dimensiones.Un arreglo de tres dimensiones puede pensarse como matrices
# en capas

# Podemos crear un arreglo con la funcion array()

  ?array

# Generamos datos

  (sec <- 1:50)
    
# Formamos un arreglo de 5 x 5 x 2 con los datos generados

  (arreglo <- array(data = sec, dim = c(5,5,2), dimnames = list(paste("d1", 1:5,
              sep = ""),paste("d2", 1:5, sep = ""),paste("d3",1:2, sep=""))))

# Notar el orden en que se acomodan los datos. El primer indice es el que cambia
# mas rapido y el ultimo es el que cambia mas lento.

# Los elemntos de un arreglo pueden obtenerse con el nombre del objeto y ponien-
# do los indices entre corchetes separados por comas: [i,j,k,...]

  arreglo[1,1,1]

# Secciones de los arreglos tambien pueden obtenerse con secuencias de indices
# [i1:i10, j3:j7,...]

  arreglo[1:3,1:3,1:2]

# Si la posicion de un indice se deja vacia, regresa el rango completo de ese
# indice

  arreglo[,,1]

# Con esto podemos cambiar uno o varios valores

  arreglo[1,1,1] <- 0
  arreglo

# La dimension de un arreglo puede obtenerse con la funcion dim() y mas atributos
# con attributes()

  dim(arreglo)
  attributes(arreglo)

# Se pueden utilizar arreglos en operaciones aritmeticas. Cuando involucran es-
# calares y/o arreglos de la misma dimension, el resultado es un arreglo de la 
# misma dimension. Las operaciones con vectores o arreglos de distintas dimen-
# siones son un poco mas intrincadas y no seran cubiertas en este tutorial.

# Las matrices son arreglos de dos dimensiones. R tiene muchas funciones especia-
# les para trabajar con matrices.

# Se crean de forma muy similar a los arreglos. Un ejemplo que ya vimos
  
  (mat <- matrix(0, nrow = 2, ncol = 3, dimnames = list(c("r1","r2"),
          c("c1","c2", "c3"))))

# Crea una matriz nula de 2 x 3. En el siguiente ejemplo

  (mat <- matrix(1:4, nrow = 2, ncol = 3, dimnames = list(c("r1","r2"),
          c("c1","c2", "c3")), byrow = TRUE))

# La matriz es de 2 x 3 y los datos son la secuencia 1,...,4 que R repite hasta
# llenar todas las entradas (notar el warning). 
# El argumento byrow indica si se desea llenar la matriz por renglones o por
# columnas (el default es por columnas, i.e. byrow = FALSE)

# Algunas operaciones basicas con matrices son

  # Transponer

    t(mat)

  # Obtener el numero de renglones o columnas

    nrow(mat); ncol(mat)

  # Extraer o remplazar la diagonal de una matriz, o construir una matriz diago-
  # nal
    
    diag(mat)
    diag(1:5)
    diag(mat) <- c(6,6); mat

  # Multiplicacion matricial %*%

    t(mat) %*% mat

    mat * mat #Elemento por elemento

    crossprod(mat) #equivalente al primero

      #ver ?crosprod y ?tcrosprod para productos matriciales

# Otras funciones utiles son

  # eigen para obtener eigenvalores y eigen vectores
  # svd y qr para calcular, respectivamente, la descomposicion de valores singu-
  # lares y qr de una matriz

# Las funciones cbind y rbind sirven para combinar objetos por columnas o por
# renglones y pueden ser usadas para crear matrices

  cbind(1:5, 6:10)
  rbind(1:3, 1:3, 1:3)

#------------------------------------------------------------------------------
# 1.2.2 Factores
#------------------------------------------------------------------------------

# Los factores son vectores que se usan para especificar clasificaciones o agru-
# pamientos de los componentes de otros vectores. Sirve para datos categoricos

# Por ejemplo: el vector tiene el genero (M o H) de 20 individuos

  genero <- sample(c("M","H"),20, replace = TRUE)
  (genero_fac <- factor(genero))

# Veamos sus atributos

  attributes(genero_fac)

# Si no lo convirtieramos en factor, seria simplemente un vector de caracteres.
# Veamos que pasa si pedimos el resumen de los dos vectores

  summary(genero)
  summary(genero_fac)

# La funcion levels() nos regresa los niveles del factor

  levels(genero_fac)

# Supongamos que queremos calcular el ingreso medio de los hombres y las muje-
# res de este grupo. Podemos explotar la estructura del factor genero_fac para
# facilitarnos el proceso

# Primero construimos un vector de ingresos (inventado)

  (ingreso <- sample(15000:300000,20, replace = TRUE))

# Ahora usamos tapply (ver ?tapply para mas informacion)

  tapply(ingreso, genero_fac, mean)

# Y obtenemos el ingreso medio por genero

# R provee la facilidad de trabajar con factores ordenados y no ordenados
# Para crear un factor ordenado se utiliza la funcion ordered()

  ordered(genero, levels = c("M", "H"))

# La funcion table() permite crear tablas de frecuencias para factores
# Creemos un vector logico dicotomizando el ingreso. Con FALSe si el ingreso
# es menor la media y TRUE si es mayor o igual a la media.

  (ingreso_fac <- ingreso >= mean(ingreso))

# Ahora creamos la tabla de frecuencias

  table(genero_fac, ingreso_fac)

#------------------------------------------------------------------------------
# 1.2.3 Listas
#------------------------------------------------------------------------------

# Las listas son objetos flexibles que permiten guardar varios tipos de datos,
# los elementos pueden tener un nombre o no

  (lista <- list(nombre = "Juan", puesto = "Gerente", salario = 35000, c(3,6,8)))

# Para acceder a los elementos hay tres formas. La primera es poniendo el numero
# de elemento en doble corchete [[]]. La segunda es con el simbolo $ y el nombre
# de la entrada. La tercera es con doble corchete y el nombre del elemento en 
# comillas

  lista[[1]]
  lista$puesto
  lista[["salario"]]

# Usando $ no es necesario poner el nombre completo del elemento sino solamente
# un minimo numero de letras para identificarlo

  lista$pues
  lista$p

# Esto tambien sirve para asignar nuevos elementos

  lista$edad <- 29

# Veamos los atributos

  class(lista)
  attributes(lista)
  length(lista)

# Podemos concaternar listas con la funcion c()

  c(lista,lista)

# Y podemos convertir objetos en listas con as.list

  as.list(y)

# La funcion "as" tambien existe matrices, vectores, factores, etc.

#------------------------------------------------------------------------------
# 1.2.4 Tablas de datos
#------------------------------------------------------------------------------

# Los cuadros de datos son estructuras muy comunes en el analisis estadistico.
# Una tabla de datos es como una matriz donde las columnas son variables y los 
# renglones observaciones. 

# En R, los cuadros de datos son listas de una clase especial "data.frame". Cada
# columna puede tener una moda y atributos distintos.

# Pueden crearse con la funcion data.frame().

# Los vectores numericos, logicos y factores se incluyen tal cual y los vectores
# de caracteres se convierten en factores. 

  tabla1 <- data.frame(Genero = genero, Ingreso = ingreso, Ing_dic = ingreso_fac)
  head(tabla1)
  tail(tabla1)
  summary(tabla1)

# Notar lo que hacen las funciones head() y tail()

# Las tablas de datos tambien pueden incluir matrices, listas y tablas de datos.
# Estas proveen a la tabla tantas columnas, elementos o variables como tengan.

  data.frame(lista)
  data.frame(mat, palabra)

# Las vectores deben tener la misma longitud y las matrices el mismo numero de 
# renglones. Si es posible R forzara esto, como en el caso anterior.

# Se puede acceder a las variables o columnas de una tabla de la misma forma 
# que se hace en las listas

  tabla1$Genero
  tabla1[[1]]
  tabla1[,1]

# Son expresiones equivalentes 

# La funcion attach() permite que las columnas de una tabla sean accesibles
# por nombre directamente

  attach(tabla1)
  Genero; Ingreso

# Esto puede revertirse usando la funcion detach()
  
  detach(tabla1)
  Genero

# Usualmente las tablas de datos son demasiado grandes para escribir cada entra-
# da en R. Podemos leer las tablas de archivos con la funcion read.table()

  naranjos <- read.table( file = "Orange.txt", header = TRUE, sep = " ")
  head(naranjos)

# El unico argumento necesario es el nombre del archivo "file". Si este no se en-
# cuentra en el directorio de trabajo debe darse la direccion completa. 

# El argumento "header" es un valor logico. TRUE significa que el primer renglon
# del archivo contiene el nombre de las variables. Si se deja vacio y el primer
# renglon del archivo contiene una columna menos que el resto de los renglones,
# R asume que este renglon contiene los nombres de las variables. 

# El argumento "sep" denota con que simbolo estan separados los valores. El de-
# fault es un espacio " "

# Ver ?read.table para mas argumentos como nombres de los renglones u observa-
# ciones, nombres de las variables cuando no vienen en la tabla, etc.

# Podemos ver una tabla de datos (tambien sirve para otros objetos) con la fun-
# cion fix()

  fix(naranjos)

# Y en RStudio haciendo click en la tabla de datos en la ventana "Workspace"

# En la instalacion de R se incluyen cerca de 100 tablas de datos. Para obte-
# ner una lista de estos:

  data()

# Asi por ejemplo podemos llamar directamente a una tabla por su nombre

  sleep

# Y obtener una descripcion

  ?sleep

# Usualmente los paquetes que instalamos tambien tienen tablas de datos para
# ejemplificar su funcionalidad. Podemos obtener los nombres y descripciones con
# data(package = "nombre del paquete")
# Si los paquetes se han cargado en la sesion usando library() las tablas de datos
# que incluyan seran incluidas en la lista generada por data()

-------------------------------------------------------------------------------
# 1.2.5 Funciones
#------------------------------------------------------------------------------

# Los usuarios pueden programar sus propias funciones y esta es una de las fa-
# ciliades de R que resultan mas utiles. Aqui damos una descripcion basica

# De forma general la sintaxis de una funcion es 
# nom_fun <- function (arg_1, arg_2,..., arg_n) {expr_1; expr_2;...;expr_m}

# Ejemplo: Raiz enesima de un numero

  raizn <- function (x, n) { x^(1/n) }

  raizn (8,3)
  raizn (-1,5)

# Graficar un histograma de una muestra aleatoria normal de tamano "n", media "m"
# y desviacion estandar "de" 

  grafnorm <- function (n, m = 0, de = 1){
    muestra <- rnorm(n, m, de)
    hist (muestra)
  }

  grafnorm( 100, 8, 10)

# Es equivalente a 

  grafnorm (100, m = 8, 10); grafnorm(100, m = 8, de = 10) #etc.

# Para los valores "m" y "de" se dan defaults (de 0 y 1 respectivamente) por si 
# el usuario los omite. Guardemos el resultado de la funcion

  (res <- grafnorm(100))

# Es un histograma. Esto sucede porque la ultima expresion en la funcion es la
# llamada a la funcion hist(). Si queremos que la funcion nos regrese la muestra 
# simulada en lugar del histograma

  grafnorm <- function (n, m = 0, de = 1){
    muestra <- rnorm(n, m, de)
    hist (muestra)
    muestra
  }

  (res <- grafnorm(100))

# Notar que la asignacion de la variable "muestra" es interna a la funcion y tem-
# poral

  muestra

# Tambien podemos regresar la muestra y el histograma usando list()

  grafnorm <- function (n, m = 0, de = 1){
    muestra <- rnorm(n, m, de)
    (histo <- hist (muestra))
    list(muestra, histo)
  }

  res <- grafnorm(100)

# A veces es necesario que la ejecucion de comandos este controlada. Por ejemplo,
# que solamente se ejecute si se cumplen ciertas condiciones o que se repitan
# expresiones cierto numero de veces.

# Para esto usamos funciones de ejecucion condicional y repetitiva como "if", "for",
# "while", etc.

# La funcion "if" es para ejecutar una expresion si una condicion se cumple. La
# sintaxis es "if(cond) expr" o "if (cond) expr else expr"donde "cond" y "expr" 
# pueden representar varias condiciones y expresiones agrupadas respectivamente.
# "else" indica que ejecutar si la condicion es falsa

  if(3 > 2) "hola" #ejemplo tonto

  if(2 > 2) "hola" else "adios" #otro ejemplo tonto

# Las funciones "for", "while", "repeat" sirven para ejecutar expresiones hasta
# que cierta condicion se cumpla

# "for (i in sec) expr" ejecuta la expresion "expr" (posiblemente agrupada) para
# todos los valores en la secuencia sec. Por ejemplo

  for(i in 1:10) print(paste("El resultado de", i, "al cuadrado es", i^2))

# "while (cond) expr" ejecuta "expr" hasta que la condicion "cond" sea falsa. Por
# ejemplo

  i <- 1
  while ( i < 10) {
    print(paste("El resultado de", i, "al cuadrado es", i^2))
    i <- i + 2
  }

# Para mas detalles ver ?Control

# Estas funciones para controlar las ejecuciones de comandos pueden ser utiles
# al programar nuestras propias funciones
