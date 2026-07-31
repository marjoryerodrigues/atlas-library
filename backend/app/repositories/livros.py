from app.config.conexao import criar_cursor, pesquisar_isbn


def listar_livros():
    conexao, cursor = criar_cursor()

    cursor.execute("""
        SELECT id, titulo
        FROM livros;
    """)

    livros = cursor.fetchall()

    cursor.close()
    conexao.close()

    return livros


def pesquisar_livro(id):
    conexao, cursor = criar_cursor()

    cursor.execute("""
        SELECT *
        FROM livros
        WHERE id = %s;
    """, (id,))

    livro = cursor.fetchone()

    cursor.close()
    conexao.close()

    return livro


def criar_livro(livro):
    conexao, cursor = criar_cursor()

    if pesquisar_isbn(livro.isbn):
        cursor.close()
        conexao.close()
        return False

    cursor.execute("""
        INSERT INTO livros(
            titulo,
            isbn,
            descricao,
            idioma,
            ano_publicacao,
            numero_paginas,
            edicao,
            editora_id,
            categoria_id
        )
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s);
    """,
    (
        livro.titulo,
        livro.isbn,
        livro.descricao,
        livro.idioma,
        livro.ano_publicacao,
        livro.numero_paginas,
        livro.edicao,
        livro.editora_id,
        livro.categoria_id
    ))

    conexao.commit()

    cursor.close()
    conexao.close()

    return True


def editar_livro(id, livro):
    if pesquisar_livro(id) is None:
        return False

    conexao, cursor = criar_cursor()

    cursor.execute("""
        UPDATE livros
        SET
            titulo = %s,
            isbn = %s,
            descricao = %s,
            idioma = %s,
            ano_publicacao = %s,
            numero_paginas = %s,
            edicao = %s,
            editora_id = %s,
            categoria_id = %s
        WHERE id = %s;
    """,
    (
        livro.titulo,
        livro.isbn,
        livro.descricao,
        livro.idioma,
        livro.ano_publicacao,
        livro.numero_paginas,
        livro.edicao,
        livro.editora_id,
        livro.categoria_id,
        id
    ))

    conexao.commit()

    cursor.close()
    conexao.close()

    return True


def apagar_livro(id):
    if pesquisar_livro(id) is None:
        return False

    conexao, cursor = criar_cursor()

    cursor.execute("""
        DELETE FROM livros
        WHERE id = %s;
    """, (id,))

    conexao.commit()

    cursor.close()
    conexao.close()

    return True