CREATE DATABASE aula_db_exemplos;
USE aula_db_exemplos;

CREATE TABLE vendas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    produto VARCHAR(255) NOT NULL,
    receita DECIMAL(10, 2) NOT NULL
);

CREATE TABLE autores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    nascimento DATE
);

CREATE TABLE livros (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    autor_id INT,
    FOREIGN KEY (autor_id) REFERENCES autores(id)
);

CREATE TABLE alunos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE matriculas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT,
    curso VARCHAR(255) NOT NULL,
    FOREIGN KEY (aluno_id) REFERENCES alunos(id)
);



USE aula_db_exemplos;

INSERT INTO autores (nome, nascimento) VALUES 
('J.K. Rowling', '1965-07-31'),
('George Orwell', '1903-06-25'),
('J.R.R. Tolkien', '1892-01-03'),
('Jane Austen', '1775-12-16'),
('Agatha Christie', '1890-09-15'),
('F. Scott Fitzgerald', '1896-09-24');


INSERT INTO livros (titulo, autor_id) VALUES
('Harry Potter e a Pedra Filosofal', 1),
('Harry Potter e a Câmara Secreta', 1),
('1984', 2),
('O Senhor dos Anéis', 3),
('Orgulho e Preconceito', 4),
('Morte no Nilo', 5),
('O Grande Gatsby', 6),
('O Misterioso Caso de Styles', 5),
('Razão e Sensibilidade', 4);


INSERT INTO alunos (nome) VALUES 
('João'),
('Maria'),
('Pedro'),
('Ana'),
('Beatriz'),
('Lucas'),
('Fernanda'),
('Eduardo'),
('Luisa'),
('Roberto');

INSERT INTO matriculas (aluno_id, curso) VALUES
(1, 'Engenharia de Software'),
(2, 'Medicina'),
(3, 'Engenharia de Software'),
(3, 'Arquitetura'),
(5, 'Física'),
(6, 'História'),
(7, 'Psicologia'),
(8, 'Engenharia Civil'),
(9, 'Artes'),
(10, 'Engenharia de Software'),
(10, 'Economia');

INSERT INTO vendas (produto, receita) VALUES 
('Produto A', 5000.00),
('Produto B', 15000.00),
('Produto C', 8000.00),
('Produto A', 6000.00),
('Produto B', 17000.00),
('Produto C', 3000.00),
('Produto D', 10000.00),
('Produto E', 6500.00),
('Produto F', 8500.00),
('Produto A', 7000.00),
('Produto B', 12000.00),
('Produto E', 4000.00),
('Produto C', 11000.00),
('Produto D', 5000.00);

-- Selecione todos os títulos de livros na tabela livros.
SELECT titulo FROM livros;

-- Selecione todos os nomes de autores nascidos antes de 1900.
SELECT nome FROM autores WHERE nascimento < '1900-01-01';

--Liste todos os livros escritos por 'J.K. Rowling'.
SELECT livros.titulo
FROM livros
JOIN autores ON livros.autor_id = autores.id
WHERE autores.nome = 'J.K. Rowling';

--Encontre todos os alunos matriculados em 'Engenharia de Software'.
SELECT alunos.nome
FROM alunos
JOIN matriculas ON alunos.id = matriculas.aluno_id
WHERE matriculas.curso = 'Engenharia de Software';

--Calcule a receita total gerada por cada produto.
SELECT produto, SUM(receita) AS receita_total
FROM vendas
GROUP BY produto;

--Determine o número total de livros por autor.
SELECT autores.nome, COUNT(livros.id) AS numero_de_livros
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome;

--Agrupe os alunos por curso e conte quantos alunos estão matriculados em cada curso.
SELECT curso, COUNT(*) AS numero_de_alunos
FROM matriculas
GROUP BY curso;

--Liste a média de receita para cada produto.
SELECT produto, AVG(receita) AS media_de_receita
FROM vendas
GROUP BY produto;

--Encontre os produtos que geraram uma receita total superior a $10.000.
SELECT produto, SUM(receita) AS receita_total
FROM vendas
GROUP BY produto
HAVING receita_total > 10000;

--Determine os autores que têm mais de 2 livros publicados.
SELECT autores.nome
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome
HAVING COUNT(livros.id) > 2;

--Junte as tabelas livros e autores e selecione todos os livros com seus respectivos autores.
SELECT livros.titulo, autores.nome AS autor
FROM livros
JOIN autores ON livros.autor_id = autores.id;

--Liste todos os alunos e os cursos em que estão matriculados.
SELECT alunos.nome, matriculas.curso
FROM alunos
LEFT JOIN matriculas ON alunos.id = matriculas.aluno_id;

--Usando LEFT JOIN, selecione todos os autores e seus livros, incluindo autores que não têm livros publicados.
SELECT autores.nome, livros.titulo
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id;

--Com RIGHT JOIN, liste todos os cursos e alunos, mesmo que o curso não tenha nenhum aluno matriculado.
SELECT alunos.nome, matriculas.curso
FROM matriculas
RIGHT JOIN alunos ON matriculas.aluno_id = alunos.id;

--Utilizando INNER JOIN, mostre somente os alunos e cursos que possuem correspondência mútua.
SELECT alunos.nome, matriculas.curso
FROM alunos
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id;

--Descubra qual autor tem a maior quantidade de livros publicados.
SELECT autores.nome, COUNT(livros.id) AS numero_de_livros
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome
ORDER BY numero_de_livros DESC
LIMIT 1;

--Determine o produto que gerou a menor receita.
SELECT produto, SUM(receita) AS receita_total
FROM vendas
GROUP BY produto
ORDER BY receita_total ASC
LIMIT 1;

