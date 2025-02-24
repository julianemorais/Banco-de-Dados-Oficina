CREATE DATABASE Oficina;
USE Oficina;

-- Criando Tabelas

CREATE TABLE Cliente (
IDCliente INT AUTO_INCREMENT PRIMARY KEY,
Nome VARCHAR(40),
CPF VARCHAR(11),
Telefone VARCHAR(20),
Email VARCHAR(40)
);

DESC Cliente;

CREATE TABLE Veiculo (
IDVeiculo INT AUTO_INCREMENT PRIMARY KEY,
Marca VARCHAR(20),
Modelo VARCHAR(20),
Placa VARCHAR(10),
IDCliente INT,
FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente)
);

DESC Veiculo;

CREATE TABLE EquipeMecanica (
IDEquipe INT AUTO_INCREMENT PRIMARY KEY,
Nome VARCHAR(15),
Especialidade VARCHAR(20)
);

DESC EquipeMecanica;

CREATE TABLE Mecanico (
IDMecanico INT AUTO_INCREMENT PRIMARY KEY,
Nome VARCHAR (30),
Endereço VARCHAR (70),
Telefone VARCHAR(20),
Email VARCHAR(30),
Especialidade VARCHAR(20),
IDEquipe INT,
FOREIGN KEY (IDEquipe) REFERENCES EquipeMecanica(IDEquipe)
);

Desc Mecanico;

CREATE TABLE OrdemDeServico (
    IDOS INT AUTO_INCREMENT PRIMARY KEY,
    DataEmissao DATE,
    ValorPeca DECIMAL(10, 2),
    ValorServico DECIMAL(10, 2),
    StatusOS VARCHAR(20),
    DataConclusao DATE,
    IDCliente INT,
    IDVeiculo INT,
    IDEquipe INT,
    FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente),
    FOREIGN KEY (IDVeiculo) REFERENCES Veiculo(IDVeiculo),
    FOREIGN KEY (IDEquipe) REFERENCES EquipeMecanica(IDEquipe)
);

DESC OrdemDeServico;

CREATE TABLE Peca (
    IDPeca INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(30),
    Descricao VARCHAR(200),
    Preco DECIMAL(10, 2)
);

DESC Peca;

CREATE TABLE Servico (
    IDServico INT PRIMARY KEY,
    Descricao VARCHAR(200),
    Preco DECIMAL(10, 2)
);

Desc Servico;

CREATE TABLE OrdemDeServico_Peca (
    IDOS INT,
    IDPeca INT,
    PRIMARY KEY (IDOS, IDPeca),
    FOREIGN KEY (IDOS) REFERENCES OrdemDeServico(IDOS),
    FOREIGN KEY (IDPeca) REFERENCES Peca(IDPeca)
);

DESC OrdemDeServico_Peca;

CREATE TABLE OrdemDeServiço_Servico (
    IDOS INT,
    IDServico INT,
    PRIMARY KEY (IDOS, IDServico),
    FOREIGN KEY (IDOS) REFERENCES OrdemDeServico(IDOS),
    FOREIGN KEY (IDServico) REFERENCES Servico(IDServico)
);

DESC OrdemDeServiço_Servico;

-- Inserir Dados nas tabelas

INSERT INTO Cliente (Nome, CPF, Telefone, Email) VALUES
('João Silva', '25664878912', '3254-6598', 'joao.silva@ab.com.br'),
('Maria de Jesus', '54625878931', '58749632', 'maria.j@uji.com.br'),
('Julio Cesar Oliveira', '63214785412', '5555-5847', 'julio.oliveira@ghb.com.br'),
('Marlene Pereira', '63214789654', '2541-8965', 'marlene.p@bvc.com');

SELECT * FROM Cliente;

INSERT INTO Veiculo (Marca, Modelo, Placa, IDCliente) VALUES
('Toyota', 'Yaris', 'abc-1234', 2),
('Honda', 'City', 'mnb-4h56', 1),
('Fiat', 'argo', 'mnh-1j67', 3),
('Ford', 'Focus', 'nhu-2547', 2);

SELECT * FROM Veiculo;

INSERT INTO EquipeMecanica (Nome, Especialidade) VALUES
('Equipe A', 'Motor'),
('Equipe B', 'Suspensão'),
('Equipe C', 'Transmissão');

SELECT * FROM EquipeMecanica;

INSERT INTO Mecanico (Nome, Endereço, Telefone, Email, Especialidade, IDEquipe) VALUES
('Pedro Almeida', 'Rua ABC, 65', '5645-5858', 'pedro.a@ghy.com', 'Motor', 1),
('Moacir Costa', 'Rua B, 589', '2546-8957', 'Moacir-costa@bn.com', 'Transmissão', 3),
('Lucas Lima', 'Rua MNO, 06', '2541-3698', 'Lucas.l@lkm.com', 'Suspensão', 2);

SELECT * FROM Mecanico;

INSERT INTO OrdemDeServico (DataEmissao, ValorPeca, ValorServico, StatusOS, DataConclusao, IDCliente, IDVeiculo, IDEquipe) VALUES
('2025-01-15', 500.00, 200.00, 'Em Andamento', NULL, 2, 1, 3),
('2025-01-10', 300.00, 150.00, 'Concluído', '2025-01-18', 1, 2, 2),
('2025-01-20', 400.00, 180.00, 'Em Andamento', NULL, 3, 3, 1);

SELECT * FROM OrdemDeServico;

INSERT INTO Peca (Nome, Descricao, Preco) VALUES
('Filtro de Óleo', 'Marca Tecfil', 50.00),
('Pastilha de Freio', 'Marca Jurid', 120.00),
('Correia Dentada', 'Marca ACDelco', 330.00);

SELECT * FROM Peca;

INSERT INTO Servico (IDServico, Descricao, Preco) VALUES
(1, 'Troca de óleo', 80.00),
(2, 'Troca de pastilhas', 100.00),
(3, 'Troca de correia', 150.00);

SELECT * FROM Servico;

INSERT INTO OrdemDeServico_Peca (IDOS, IDPeca) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 3);

SELECT * FROM OrdemDeServico_Peca;

INSERT INTO OrdemDeServiço_Servico (IDOS, IDServico) VALUES
(1, 1),
(2, 2),
(3, 3);

SELECT * FROM OrdemDeServiço_Servico;

SELECT * FROM Veiculo
WHERE IDCliente = 1;

SELECT * FROM OrdemDeServico
WHERE StatusOS = 'Em Andamento';

SELECT * FROM Peca
WHERE Preco > 100.00;

SELECT * FROM Servico
WHERE Descricao LIKE '%Troca%';

SELECT IDMecanico, 
       CONCAT(Nome, ' - ', Especialidade) AS NomeCompletoEspecialidade
FROM Mecanico;

SELECT IDOS, 
       COUNT(IDPeca) AS TotalPeças
FROM OrdemDeServico_Peca
GROUP BY IDOS;

SELECT * FROM Cliente
ORDER BY Nome ASC;

SELECT * FROM OrdemDeServico
ORDER BY DataEmissao DESC;

SELECT * FROM Mecanico
ORDER BY Especialidade ASC, Nome ASC;

SELECT IDPeca, COUNT(*) AS TotalOS
FROM OrdemDeServico_Peca
GROUP BY IDPeca
HAVING COUNT(*) > 1;

SELECT V.IDVeiculo, V.Marca, V.Modelo, V.Placa, 
       C.Nome AS NomeCliente, C.CPF, C.Telefone, C.Email
FROM Veiculo V
JOIN Cliente C ON V.IDCliente = C.IDCliente;

SELECT OS.IDOS, OS.DataEmissao, OS.ValorPeca, OS.ValorServico, OS.StatusOS, OS.DataConclusao, 
       V.Marca, V.Modelo, V.Placa
FROM OrdemDeServico OS
JOIN Veiculo V ON OS.IDVeiculo = V.IDVeiculo;



