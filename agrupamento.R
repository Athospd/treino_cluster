# agrupamento de audiencias

n_rls <- ceiling(length(unique(df$forum))*1.8)

agr <- hclust(distancia)
plot(agr)

df$rl <- cutree(agr, n_rls)
df %>%
  group_by(rl) %>%
  summarise(s = sum(duracao)/3600,
            n = n()) %>%
  arrange(n, s)

df %>% 
  filter(rl %in% 6) %>% 
  mutate(inicio = inicio/3600, 
         duracao = duracao/60)
