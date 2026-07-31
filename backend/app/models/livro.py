class Livro:
    def __init__(
        self,
        titulo,
        isbn,
        descricao,
        idioma,
        ano_publicacao,
        numero_paginas,
        edicao,
        editora_id,
        categoria_id
    ):
        self.titulo = titulo
        self.isbn = isbn
        self.descricao = descricao
        self.idioma = idioma
        self.ano_publicacao = ano_publicacao
        self.numero_paginas = numero_paginas
        self.edicao = edicao
        self.editora_id = editora_id
        self.categoria_id = categoria_id