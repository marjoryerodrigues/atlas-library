CREATE TYPE tipo_user AS ENUM('aluno','professor','bibliotecario');
CREATE TYPE status_user AS ENUM('ativo','bloqueado');

CREATE TABLE usuarios (
  id serial PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE, 
  senha VARCHAR(255) NOT NULL,
  telefone VARCHAR(20),
  tipo_usuario tipo_user NOT NULL,
  status_usuario status_user NOT NULL DEFAULT 'ativo',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE autores(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    nacionalidade VARCHAR(100),
    data_nascimento DATE,
    biografia TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE editoras(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    site_fc VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categorias(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE livros(
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    descricao TEXT,
    idioma VARCHAR(50) NOT NULL,
    ano_publicacao INTEGER NOT NULL,
    numero_paginas INTEGER NOT NULL,
    edicao VARCHAR(20) NOT NULL,

    editora_id INTEGER NOT NULL,
    categoria_id INTEGER NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (editora_id) REFERENCES editoras(id),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id),

    CHECK(numero_paginas > 0),
    CHECK(ano_publicacao BETWEEN 1000 and 2100)
);

CREATE TABLE livros_autores(
    livro_id INTEGER NOT NULL,
    autor_id INTEGER NOT NULL, 
    PRIMARY KEY (livro_id, autor_id),
    FOREIGN KEY (livro_id) REFERENCES livros(id),
    FOREIGN KEY (autor_id) REFERENCES autores(id)
);

CREATE TYPE status_exemplar AS ENUM (
    'disponivel',
    'emprestado',
    'reservado',
    'manutencao',
    'perdido'
);

CREATE TABLE exemplares(
    id SERIAL PRIMARY KEY,
    livro_id INTEGER NOT NULL,
    codigo_patrimonio VARCHAR(30) NOT NULL UNIQUE,
    status_exe status_exemplar NOT NULL DEFAULT 'disponivel',
    observacao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (livro_id) REFERENCES livros(id)
);

CREATE TYPE status_emprestimo AS ENUM (
    'ativo',
    'devolvido',
    'atrasado',
    'cancelado'
);

CREATE TABLE emprestimos(
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER NOT NULL,
    exemplar_id INTEGER NOT NULL,
    data_emprestimo TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_prevista DATE NOT NULL,
    data_devolucao DATE,
    status_empre status_emprestimo NOT NULL DEFAULT 'ativo',
    observacao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (exemplar_id) REFERENCES exemplares(id)
);

CREATE TABLE resenhas(
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER NOT NULL,
    livro_id INTEGER NOT NULL,
    titulo VARCHAR(150),
    texto TEXT NOT NULL,
    nota INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY(livro_id) REFERENCES livros(id),

    UNIQUE(usuario_id, livro_id),

    CHECK(nota >= 1 AND nota <= 5)
);

INSERT INTO usuarios
(nome,email,senha,telefone,tipo_usuario)
VALUES
('João Silva','joao@email.com','123456','889999999','aluno');

INSERT INTO categorias(nome,descricao)
VALUES
('Tecnologia','Livros de programação e computação');

INSERT INTO editoras
(nome,cidade,estado,pais)
VALUES
('O Reilly','São Paulo','SP','Brasil');

INSERT INTO autores(nome,nacionalidade)
VALUES
('Robert C. Martin','Americano');


INSERT INTO usuarios
(nome, email, senha, telefone, tipo_usuario)
VALUES
('Francisco Apolonio', 'francisco@email.com', '123456', '88999999999', 'aluno'),
('Maria Silva', 'maria@email.com', '123456', '88988888888', 'professor'),
('Carlos Souza', 'carlos@email.com', '123456', '88977777777', 'bibliotecario');

INSERT INTO autores
(nome, nacionalidade, data_nascimento, biografia)
VALUES
('Robert C. Martin', 'Americano', '1952-12-05', 'Autor conhecido por livros sobre engenharia de software.'),
('Machado de Assis', 'Brasileiro', '1839-06-21', 'Um dos maiores escritores brasileiros.'),
('J. K. Rowling', 'Britânica', '1965-07-31', 'Autora da série Harry Potter.');

INSERT INTO editoras
(nome, cidade, estado, pais, site_fc)
VALUES
('O Reilly Media', 'Sebastopol', 'Califórnia', 'Estados Unidos', 'https://oreilly.com'),
('Companhia das Letras', 'São Paulo', 'SP', 'Brasil', NULL),
('Bloomsbury', 'Londres', 'Inglaterra', 'Reino Unido', NULL);

INSERT INTO categorias
(nome, descricao)
VALUES
('Tecnologia', 'Livros de programação, sistemas e computação.'),
('Romance', 'Obras literárias de romance.'),
('Fantasia', 'Livros de mundos fictícios e fantasia.');

INSERT INTO livros
(titulo, isbn, descricao, idioma, ano_publicacao, numero_paginas, edicao, editora_id, categoria_id)
VALUES
(
'Clean Code',
'9780132350884',
'Livro sobre boas práticas de programação e escrita de código limpo.',
'Português',
2008,
464,
'1ª',
1,
1
),
(
'Dom Casmurro',
'9788535914849',
'Romance clássico da literatura brasileira.',
'Português',
1899,
256,
'1ª',
2,
2
),
(
'Harry Potter e a Pedra Filosofal',
'9788532511010',
'Primeiro livro da série Harry Potter.',
'Português',
1997,
264,
'1ª',
3,
3
);

INSERT INTO livros_autores
(livro_id, autor_id)
VALUES
(1,1),
(2,2),
(3,3);