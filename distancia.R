library(dummies)
library(magrittr)
library(dplyr)

# agrupamento de audiencias

# site 10^5
# forum 10^4
# vara 10^1
# complexidade 10^1
# (horario_x + duracao_x) - horario_y 10^3
# (horario_y + duracao_y) - horario_x 10^3 

# distancia entre início e fim
dist_ini_fim <- function(data, x, y) {
  resp <- data[x %>% unlist, "inicio"] - data[y %>% unlist, "inicio"]
  return(resp$inicio)
}

d <- combn(nrow(df), 2) %>% 
  t %>% 
  as.data.frame %>% 
  rename(x = V1, y = V2) %>%
  mutate(distancia_inicio_fim = df %>% dist_ini_fim(x, y))

d_ini_fim <- structure(d$distancia_inicio_fim,
                           Size = nrow(df),
                           Labels = df$id,
                           Diag = FALSE,
                           Upper = FALSE,
                           method = "user",
                           class = "dist") %>% as.matrix

horario_incompativel <- as.dist((d_ini_fim <= -as.numeric(df$duracao) | d_ini_fim >= c(as.numeric(df$duracao)[-1],0)) %>% not)

distancia <- dist(dummy(df$site), method = "binary")*10^5 + 
  dist(dummy(df$forum), method = "binary")*20^4 + 
  dist(dummy(df$vara), method = "binary")*10^1 + 
  dist(dummy(df$complexidade), method = "binary")*20^1 +
  horario_incompativel*10^8 +
  dist(df$duracao)/60*10^0
  

