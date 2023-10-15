-- Questão 1)

-- letra A)
CREATE TABLE nomes (
    nome VARCHAR(50)
);

INSERT INTO nomes (nome) VALUES 
('Roberta'),
('Roberto'),
('Maria Clara'),
('João');

-- Letra B)
UPDATE nomes
SET nome = UPPER(nome)
WHERE nome IN ('Roberta', 'Roberto', 'Maria Clara', 'João');



-- Letra C)
SELECT nome, LENGTH(nome) AS tamanho
FROM nomes;

-- Letra D)
SELECT 
    CASE 
        WHEN nome LIKE '%Maria%' THEN CONCAT('Sra. ', nome)
        ELSE CONCAT('Sr. ', nome)
    END AS nome_pronto
FROM nomes;

-- Questão 2)

-- Letra A)
CREATE TABLE produtos (
    produto VARCHAR(50),
    preco DECIMAL(10, 2),
    quantidade INT
);

INSERT INTO produtos (produto, preco, quantidade) VALUES 
('Produto A', 49.99, 5),
('Produto B', 79.99, 0),
('Produto C', 129.99, 10);


-- Letra B)
SELECT produto, ROUND(preco, 2) AS preco_arredondado
FROM produtos;

-- Letra C)
SELECT produto, ABS(quantidade) AS quantidade_absoluta
FROM produtos;

-- Letra D)
SELECT AVG(preco) AS media_precos
FROM produtos;

-- Questão 3)

-- Letra A)
CREATE TABLE eventos (
    data_evento DATE
);

INSERT INTO eventos (data_evento) VALUES 
('2023-10-15'),
('2023-10-10'),
('2023-10-05');


-- Letra B)
INSERT INTO eventos (data_evento) VALUES (CURDATE());


-- Letra C)
SELECT DATEDIFF(CURDATE(), data_evento) AS dias_passados
FROM eventos;

-- Letra D)
SELECT data_evento, DAYNAME(data_evento) AS dia_semana
FROM eventos;

-- Questão 4)

-- Letra A)
SELECT produto,
       IF(quantidade > 0, 'Em estoque', 'Fora de estoque') AS status_estoque
FROM produtos;

-- Letra B)
SELECT produto,
       CASE 
           WHEN preco < 50 THEN 'Barato'
           WHEN preco >= 50 AND preco < 100 THEN 'Médio'
           ELSE 'Caro'
       END AS categoria_preco
FROM produtos;

-- Questão 5)

-- Letra A)
DELIMITER //

CREATE FUNCTION TOTAL_VALOR(preco DECIMAL(10, 2), quantidade INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    RETURN preco * quantidade;
END//

DELIMITER ;


-- Letra B)
SELECT produto, TOTAL_VALOR(preco, quantidade) AS valor_total
FROM produtos;

-- Questão 6)

-- Letra A)
SELECT COUNT(*) AS numero_produtos
FROM produtos;

-- Letra B)
SELECT MAX(preco) AS produto_mais_caro
FROM produtos;

-- Letra C)
SELECT MIN(preco) AS produto_mais_barato
FROM produtos;

-- Letra D )
SELECT SUM(IF(quantidade > 0, preco * quantidade, 0)) AS valor_total_estoque
FROM produtos;

-- Questão 7)

-- Letra A)
DELIMITER //

CREATE FUNCTION FATORIAL(n INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE resultado INT DEFAULT 1;
    DECLARE i INT DEFAULT 1;
    WHILE i <= n DO
        SET resultado = resultado * i;
        SET i = i + 1;
    END WHILE;
    RETURN resultado;
END//

DELIMITER ;

-- Letra B)
DELIMITER //

CREATE PROCEDURE calcular_exponencial(IN base INT, IN expoente INT, OUT resultado INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    SET resultado = 1;
    WHILE i <= expoente DO
        SET resultado = resultado * base;
        SET i = i + 1;
    END WHILE;
END//

DELIMITER ;

-- Letra C)
DELIMITER //

CREATE PROCEDURE verificar_palindromo(IN palavra VARCHAR(50), OUT eh_palindromo INT)
BEGIN
    DECLARE reverso VARCHAR(50);
    SET reverso = REVERSE(palavra);
    IF palavra = reverso THEN
        SET eh_palindromo = 1;
    ELSE
        SET eh_palindromo = 0;
    END IF;
END//

DELIMITER ;