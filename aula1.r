library(readxl)
aulas <- read_excel("/home/rodrigo/projects/analise-dados-introducao-r/datasets/aulas.xlsx")
View(aulas)

# para reconhecer as variáveis do arquivo excel attach()
# copia o excel para a memória.
attach(aulas)

section_id

# altera o padrão par-a exibição
options(max.print = 40000)

# head para listar os primeiros registros da lista
head(section_id)

# ordená-los do menor para o maior, utilizaremos a função sort no Script:
sort(section_id)

# substituir o valor section_id de 999999 para 3255
# dado inserido incorretamente na linha 33137 e coluna 3
aulas[33137, 3] <- 3255

sort(aulas$section_id)

# localiza o valor alterado, para confirmar se foi mesmo alterado
aulas[33137, 3]

# a quantidade de cursos únicos, função unique(), que fornecerá uma exibição por curso.
unique(aulas$section_id)

# length conta a quantidade de registros
length(unique(aulas$section_id))
