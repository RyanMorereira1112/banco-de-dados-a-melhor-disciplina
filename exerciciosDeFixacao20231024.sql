-- Script Mayck

CREATE DATABASE exercicios_trigger;
USE exercicios_trigger;

-- Criação das tabelas
CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE Auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mensagem TEXT NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE Pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    quantidade INT NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES Produtos(id)
);

-- Questão 1

DELIMITER //
CREATE TRIGGER after_insert_cliente
AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem) VALUES (CONCAT('Novo cliente inserido em ', NOW()));
END;
//
DELIMITER ;

-- Questão 2

DELIMITER //
CREATE TRIGGER before_delete_cliente
BEFORE DELETE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem) VALUES (CONCAT('Tentativa de excluir cliente em ', NOW()));
END;
//
DELIMITER ;

-- Questão 3

DELIMITER //
CREATE TRIGGER after_update_cliente
AFTER UPDATE ON Clientes
FOR EACH ROW
BEGIN
    IF NEW.nome <> OLD.nome THEN
        INSERT INTO Auditoria (mensagem) VALUES (CONCAT('Nome do cliente atualizado de ', OLD.nome, ' para ', NEW.nome, ' em ', NOW()));
    END IF;
END;
//
DELIMITER ;

-- Questão 4

DELIMITER //
CREATE TRIGGER before_update_cliente
BEFORE UPDATE ON Clientes
FOR EACH ROW
BEGIN
    IF NEW.nome IS NULL OR NEW.nome = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome do cliente não pode ser vazio ou NULL';
    END IF;
END;
//
DELIMITER ;

-- Questão 5

DELIMITER //
CREATE TRIGGER after_insert_pedido
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    UPDATE Produtos
    SET estoque = estoque - NEW.quantidade
    WHERE id = NEW.produto_id;

    IF (SELECT estoque FROM Produtos WHERE id = NEW.produto_id) < 5 THEN
        INSERT INTO Auditoria (mensagem) VALUES (CONCAT('Estoque baixo para o produto ', NEW.produto_id, ' em ', NOW()));
    END IF;
END;
//
DELIMITER ;



