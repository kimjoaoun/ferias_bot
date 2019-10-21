library(stringr) #pacote para manipulação de strings
library(rtweet) # pacote que faz o tweet

#---- Corrige um bug do rtweet que o impede de tuitar ----
is_tweet_length <- function(.x, n = 280) {
  .x <- gsub("https?://[[:graph:]]+\\s?", "", .x)
  while (grepl("^@\\S+\\s+", .x)) {
    .x <- sub("^@\\S+\\s+", "", .x)
  }
  !(nchar(.x) <= n)   
}


assignInNamespace("is_tweet_length", is_tweet_length, ns = "rtweet")

#---- Twitter API Auth ----

consumer_key ="CONSUMER KEY AQUI"
consumer_secret= "CONSUMER SECRET AQUI"
token_1 = "ACCESS TOKEN AQUI"
token_2 = "ACCESS SECRET AQUI"

token <- create_token(
  app = "feriasbot", # coloque aqui o nome do app criado no developers.twitter.com
  consumer_key = consumer_key,
  consumer_secret = consumer_secret,
  access_token = token_1,
  access_secret = token_2)

get_token()

# O REPEAT cria um loop que é infinito caso não encontre um 'break' no meio do código, a nossa ideia é que realmente fique infinitamente

repeat{
  #---- Bot Things ----
  
  # Calcular o tempo faltante para o fim dos periodos letivos
  fim_aulas_puc = as.Date("2019/12/17", format= "%Y/%m/%d")
  dias_faltantes_puc = fim_aulas_puc - Sys.Date() 
  fim_aulas_ufrj = as.Date("2019/12/14", format="%Y/%m/%d")
  dias_faltantes_ufrj= fim_aulas_ufrj- Sys.Date()
  fim_aulas_uerj = as.Date("2019/12/07", format="%Y/%m/%d")
  dias_faltantes_uerj = fim_aulas_uerj - Sys.Date()
  fim_aulas_uff = as.Date("2019/12/20", format="%Y/%m/%d")
  dias_faltantes_uff = fim_aulas_uff - Sys.Date()
  
  #---- Escreve o tweet ----
  tweets = str_c("O ano letivo na PUC-Rio acaba em: ", format(fim_aulas_puc, "%d/%m/%Y"), ". Faltam: ", dias_faltantes_puc, " dias. ", "| Na UFRJ o ano letivo acaba em: ", format(fim_aulas_ufrj, "%d/%m/%Y"), ". Faltam só ", dias_faltantes_ufrj, " dias. ", "VAMO LÁ PORRA, JÁ TA ACABANDO!!!")
  tweets_2 = str_c("O ano letivo na UERJ acaba em: ", format(fim_aulas_uerj, "%d/%m/%Y"), ". Faltam: ", dias_faltantes_uerj, " dias. ", "| Na UFF o ano letivo acaba em: ", format(fim_aulas_uff, "%d/%m/%Y"), ". Faltam só ", dias_faltantes_uff, " dias.", " VAMO LÁ PORRA, JÁ TA ACABANDO!!!")
  
  #---- Caso você queira um tweet para cada universidade  ----
  
  # tweet_puc = str_c("O ano letivo na PUC acaba em: ", format(fim_aulas_puc, "%d/%m/%Y"), ". Faltam só ", dias_faltantes_puc ," dias, vamos lá porra, já ta acabando!!!")
  # tweet_ufrj = str_c("O ano letivo na UFRJ acaba em: ", format(fim_aulas_ufrj, "%d/%m/%Y"), ". Faltam só ", dias_faltantes_ufrj ," dias, vamos lá porra, já ta acabando!!!")
  
  #---- Tuita! ----
  post_tweet(tweets)
  
  Sys.sleep('120')
  
  post_tweet(tweets_2)

  #---- Aguarda por 86400 segundos == 1 dia ----
  Sys.sleep("86400")
  
}
