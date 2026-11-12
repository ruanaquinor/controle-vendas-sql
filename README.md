
# Modelagem de Banco de Dados: E-commerce de Hardware

## Sobre o Projeto
Projeto 100% SQL focado na criação e manipulação de um banco de dados relacional para uma loja fictícia de peças de informática. 

## Estrutura e Scripts
O script principal `script_loja_hardware.sql` aborda:
*DDL (Data Definition Language): Criação das tabelas `Clientes`, `Produtos`, `Pedidos` e a tabela associativa (N:M) `Itens_Pedido`, definindo Chaves Primárias (PK) e Chaves Estrangeiras (FK).
*DML (Data Manipulation Language): Inserção de um catálogo de peças (processadores, placas de vídeo) e simulação de compras.
*DQL (Data Query Language): Relatórios avançados utilizando `INNER JOIN`, agrupamentos (`GROUP BY`) e funções matemáticas (`SUM`) para calcular o ticket médio dos clientes e emitir alertas de estoque baixo.

## Tecnologias Utilizadas
* SQL (Compatível com MySQL / PostgreSQL)
