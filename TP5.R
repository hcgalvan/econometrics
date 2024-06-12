## --------------------------------------------------------------------------------
library(haven)
library(plm)
library(dplyr)

data <- read_dta("D:/2024/econometria/pwt1001.dta")


## --------------------------------------------------------------------------------
# la inversión está representada por la variable csh_i, que corresponde a la participación de la inversión en el PIB a precios constantes. Por lo tanto, no necesitamos realizar cálculos adicionales. Renombrar la variable:

data <- data %>%
  dplyr::rename(inv_share = csh_i)

#la apertura comercial "openk" se puede calcular como la suma de las exportaciones e importaciones como porcentaje del PIB
data <- data %>%
  mutate(openk = csh_x + csh_m) 


## --------------------------------------------------------------------------------
# Estimar el modelo de efectos fijos
model <- plm(log(rgdpna) ~ openk + inv_share + hc, data = data, 
             index = c("country", "year"), model = "within")

summary(model)

