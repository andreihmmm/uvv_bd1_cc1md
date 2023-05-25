# INTRODUÇÃO
Esta pasta é destinada a assuntos relativos ao PSET1, no qual um banco de dados em PostgreSQL foi produzido numa máquina virtual em Linux.
> Dentre as ferramentas utilizadas estão o SQL Power Architect, DBeaver e o terminal do Linux.
### Resumo do trabalho:
Nesta pasta estão inseridos os arquivos pedidos pelo professor para que seja avaliada minha habilidade na criação de bancos de dados em PostgreSQL, bem como desenvolver capacidades de solução de problemas e autodidatismo.
# Arquivos presentes na pasta:
### uvv_bd1_cc1md.architect
Este arquivo .architect contém o projeto lógico do esquema "lojas". Este projeto esteve presente na prova do 1º bimestre e não é de minha autoria, cabendo à mim apenas replicá-lo no SQL Power Architect.
### uvv_bd1_cc1md.pdf
Imagem salva em arquivo .pdf do resultado do projeto lógico produzido no SQL Power Architect.
### uvv_bd1_cc1md.sql
Script do projeto pronto para ser executado no terminal. Esta versão contém erros como atributos compostos e multivalorados por exemplo. O apontamento de possíveis soluções para esses problemas foi escrito em papel almaço e entregue ao professor junto a questões referentes ao funcionamento do Git e do GitHub, erros no projeto lógico e sobre a implementação do projeto no PostgreSQL.

#### COMO EXECUTAR O SCRIPT NO TERMINAL
É necessário usar o comando : <br>
PGPASSWORD='computacao@raiz' psql -U postgres < *_~/Desktop/script/script.sql_* (AQUI DEVE ESTAR O CAMINHO PARA O ARQUIVO)

