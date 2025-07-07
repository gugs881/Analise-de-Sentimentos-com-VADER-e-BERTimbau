---
title: "Análise de Sentimentos com VADER e BERTimbau"
author: "Gustavo do Vale Ferreira"
date: "2024-03-19"
output: html_document
---
  
  ## Configuração do Ambiente
  
  
{r setup, message=FALSE, warning=FALSE}
# Verifica se o pacote reticulate está instalado, se não, instala
if (!requireNamespace("reticulate", quietly = TRUE)) install.packages("reticulate")
library(reticulate)

# Configurar Python no R antigo
if (!py_available(initialize = FALSE)) {
  stop("Python não está disponível no ambiente atual. Configure um ambiente compatível.")
}

# Carregar bibliotecas do Python
py_run_string("import nltk; nltk.download('vader_lexicon')")
nltk <- import("nltk.sentiment")
transformers <- import("transformers")


## Coleta e Organização dos Textos

{r data_preparation}
textos <- data.frame(
  idioma = c("português", "português", "português", "inglês", "inglês", "inglês"),
  sentimento = c("positivo", "negativo", "neutro", "positivo", "negativo", "neutro"),
  texto = c(
    "Eu adorei este filme, foi incrível!",
    "O serviço foi péssimo, nunca mais volto.",
    "O evento foi ok, nada de especial.",
    "I loved this movie, it was amazing!",
    "The service was terrible, never coming back.",
    "The event was okay, nothing special."
  )
)
print(textos)


## Análise de Sentimentos com VADER

{r vader_analysis}
# Criar o analisador VADER
if (!exists("nltk$SentimentIntensityAnalyzer")) {
  stop("VADER não pôde ser carregado corretamente. Certifique-se de que o ambiente está configurado.")
}
sia <- nltk$SentimentIntensityAnalyzer()

# Aplicar VADER aos textos
textos$vader_score <- sapply(textos$texto, function(x) sia$polarity_scores(x)$compound)
print(textos)


## Análise de Sentimentos com BERTimbau

{r bertimbau_analysis}
# Carregar o modelo BERTimbau
if (!exists("transformers$pipeline")) {
  stop("Transformers não pôde ser carregado corretamente. Verifique a instalação.")
}
bert_model <- transformers$pipeline("text-classification", model="neuralmind/bert-base-portuguese-cased")

#Aplicar BERTimbau nos textos em português
textos$bert_score <- ifelse(textos$idioma == "português", 
                            sapply(textos$texto, function(x) bert_model(x)[[1]]$score), 
                            NA)
print(textos)


#Comparação e Reflexão

{r comparison}
print("Comparação entre VADER e BERTimbau")
comparacao <- data.frame(
  Texto = textos$texto,
  VADER_Score = textos$vader_score,
  BERTimbau_Score = textos$bert_score
)
print(comparacao)


## Observações sobre a Comparação

{r observations}
print("O VADER gera um score compound baseado na polaridade das palavras e ignora o contexto.")
print("O BERTimbau, por ser um modelo treinado com deep learning, entende melhor a estrutura da frase e o significado das palavras no contexto.")