-- 1. CRIAÇÃO DAS TABELAS (DDL - Data Definition Language)

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_cadastro DATE NOT NULL
);

CREATE TABLE Produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(150) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL
);

CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_pedido DATETIME NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabela associativa (N:M) que liga os Pedidos aos Produtos
CREATE TABLE Itens_Pedido (
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

-- 2. INSERÇÃO DE DADOS (DML - Data Manipulation Language)

INSERT INTO Clientes (nome, email, data_cadastro) VALUES
('Carlos Silva', 'carlos@email.com', '2026-10-15'),
('Ana Souza', 'ana@email.com', '2026-10-20');

-- Cadastrando o catálogo de peças
INSERT INTO Produtos (nome_produto, categoria, preco, quantidade_estoque) VALUES
('Processador AMD Ryzen 7 5700X3D', 'Processador', 1450.00, 15),
('Placa de Vídeo AMD Radeon RX 6750 XT', 'Placa de Vídeo', 2100.00, 8),
('Placa Mãe Gigabyte B550M Aorus Elite', 'Placa Mãe', 850.00, 20),
('Water Cooler 240mm Rise Mode', 'Refrigeração', 280.00, 30),
('Fonte Sharkoon 600W', 'Fonte', 350.00, 25);

-- Simulando a criação de um pedido
INSERT INTO Pedidos (id_cliente, data_pedido) VALUES
(1, '2026-11-09 10:30:00');

-- Adicionando os itens ao pedido do Carlos (Montando um PC completo)
INSERT INTO Itens_Pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 1450.00), -- 1x Ryzen 7
(1, 2, 1, 2100.00), -- 1x RX 6750 XT
(1, 3, 1, 850.00);  -- 1x B550M

-- 3. CONSULTAS E RELATÓRIOS (DQL - Data Query Language)

-- Relatório 1: Detalhamento do Pedido (Demonstra domínio de JOINs)
-- Traz o nome do cliente, os produtos comprados, a quantidade e o subtotal
SELECT 
    c.nome AS Cliente,
    pd.id_pedido AS Numero_Pedido,
    pr.nome_produto AS Produto,
    ip.quantidade AS Qtd,
    (ip.quantidade * ip.preco_unitario) AS Subtotal
FROM Clientes c
INNER JOIN Pedidos pd ON c.id_cliente = pd.id_cliente
INNER JOIN Itens_Pedido ip ON pd.id_pedido = ip.id_pedido
INNER JOIN Produtos pr ON ip.id_produto = pr.id_produto;

-- Relatório 2: Total gasto por cliente (Demonstra funções matemáticas SUM e GROUP BY)
SELECT 
    c.nome AS Cliente,
    SUM(ip.quantidade * ip.preco_unitario) AS Valor_Total_Gasto
FROM Clientes c
INNER JOIN Pedidos pd ON c.id_cliente = pd.id_cliente
INNER JOIN Itens_Pedido ip ON pd.id_pedido = ip.id_pedido
GROUP BY c.id_cliente, c.nome;

-- Relatório 3: Alerta de Estoque Baixo (Demonstra filtros com WHERE)
SELECT 
    nome_produto, 
    quantidade_estoque 
FROM Produtos 
WHERE quantidade_estoque < 10;