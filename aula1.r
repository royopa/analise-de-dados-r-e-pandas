library(readxl)
aulas <- read_excel("/home/rodrigo/projects/analise-dados-introducao-r/datasets/aulas.xlsx")
View(aulas)

# para reconhecer as variáveis do arquivo excel attach()
# attach(aulas).
attach(aulas)

section_id

# altera o padrão para exibição
options(max.print = 40000)

# head para listar os primeiros registros da lista
head(section_id)

# ordená-los do menor para o maior, utilizaremos a função sort no Script:
sort(section_id)

