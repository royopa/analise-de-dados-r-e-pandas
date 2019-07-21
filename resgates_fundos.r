install.packages("curl")
install.packages("data.table")
install.packages("mafs")
install.packages("prophet")
install.packages("cranlogs")
install.packages("tidyverse")
install.packages("lubridate")


library(jsonlite)
library(data.table)
library(mafs)
library(prophet)
library(cranlogs)
library(tidyverse)
library(lubridate)


# Keep this key secret!
morph_api_key <- "O3C08GbWY2DaZ2U2Ec22"

# O CNPJ do fundo
cnpj <- '04150666000187'

# We're always asking for json because it's the easiest to deal with
morph_api_url <- "https://api.morph.io/royopa/morph-cvm-informe-diario/data.json"

# Query sql
sql <- sprintf("SELECT CO_PRD, DT_REF, RESG_DIA, VL_PATRIM_LIQ FROM swdata WHERE CO_PRD = '%s' ORDER BY DT_REF", cnpj)

url = sprintf("%s?key=%s&query=%s", morph_api_url, morph_api_key, URLencode(sql))

df <- fromJSON(url)

# mostra os primeiros registros
head(df)

tail(df)

# converte a coluna RESG_DIA e VL_PATRIM_LIQ
df$RESG_DIA <- as.numeric(as.character(df$RESG_DIA))
df$VL_PATRIM_LIQ <- as.numeric(as.character(df$VL_PATRIM_LIQ))

# sumário
summary(df)

# faz o shift com as colunas de resgates e patrimônio líquido
df$RESG_D1 <- shift(df$RESG_DIA, n=1, fill=NA, type="lag")
df$VL_PATRIM_LIQ_D1 <- shift(df$VL_PATRIM_LIQ, n=1, fill=NA, type="lag")
df$VL_PATRIM_LIQ_D2 <- shift(df$VL_PATRIM_LIQ, n=2, fill=NA, type="lag")

# insere as colunas com os percentuais de resgates d-1 e d-2
df$PC_RESG_D0 <- df$RESG_DIA / df$VL_PATRIM_LIQ
df$PC_RESG_D1 <- df$RESG_DIA / df$VL_PATRIM_LIQ_D1
df$PC_RESG_D2 <- df$RESG_DIA / df$VL_PATRIM_LIQ_D2

head(df)
