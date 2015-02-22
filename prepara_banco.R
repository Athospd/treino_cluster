library(lubridate)
library(dplyr)

# prepara banco fake
set.seed(123)
n = 40
id <- 1:n
site <- rep("SP", n)
forum <- rep(paste0("Forum", 1:5), each = n/5)
vara <- rep(paste0("Vara", 1:10), each = n/10)
complexidade <- sample(1:3, n, replace = TRUE)
inicio <- sample(c("08:00:00", "08:30:00",
                    "09:00:00", "09:30:00",
                    "10:00:00", "10:30:00",
                    "11:00:00", "11:30:00",
                    "12:00:00", "12:30:00",
                    "13:00:00", "13:30:00",
                    "14:00:00", "14:30:00",
                    "15:00:00", "15:30:00",
                    "16:00:00", "16:30:00",
                    "17:00:00", "17:30:00",
                    "18:00:00", "18:30:00"), n, replace = TRUE) %>% hms %>% as.duration %>% as.numeric
duracao <- sample(c(40, 60, 90), n, replace = TRUE) %>% duration("minutes") %>% as.numeric
# fim <- inicio + duracao
df <- data_frame(id, site, forum, vara, complexidade, inicio, duracao)
