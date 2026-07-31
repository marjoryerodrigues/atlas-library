from app.repositories.livros import (
    listar_livros,
    pesquisar_livro,
    criar_livro,
    editar_livro,
    apagar_livro
)

from app.models.livro import Livro


# =========================
# TESTE 1 - LISTAR LIVROS
# =========================

print("\n", "=" * 8, "LISTAR LIVROS", "=" * 8)

livros = listar_livros()

for livro in livros:
    print(f"{livro[0]} - {livro[1]}")


# =========================
# TESTE 2 - PESQUISAR LIVRO
# =========================

print("\n", "=" * 8, "PESQUISAR LIVRO", "=" * 8)

id_livro = 1

livro = pesquisar_livro(id_livro)

if livro:
    print(livro)
else:
    print("Livro não encontrado")


# =========================
# TESTE 3 - CRIAR LIVRO
# =========================

print("\n", "=" * 8, "CRIAR LIVRO", "=" * 8)

novo_livro = Livro(
    titulo="Python Avançado",
    isbn="9999999999999",
    descricao="Livro para teste do CRUD",
    idioma="Português",
    ano_publicacao=2026,
    numero_paginas=300,
    edicao="1ª",
    editora_id=1,
    categoria_id=1
)


resultado = criar_livro(novo_livro)


if resultado:
    print("Livro criado com sucesso")
else:
    print("Livro já existe")


# =========================
# TESTE 4 - EDITAR LIVRO
# =========================

print("\n", "=" * 8, "EDITAR LIVRO", "=" * 8)


livro_editado = Livro(
    titulo="Clean Code Atualizado",
    isbn="9780132350884",
    descricao="Livro atualizado para teste do UPDATE",
    idioma="Português",
    ano_publicacao=2008,
    numero_paginas=500,
    edicao="2ª",
    editora_id=1,
    categoria_id=1
)


resultado = editar_livro(
    1,
    livro_editado
)


if resultado:
    print("Livro atualizado com sucesso")
else:
    print("Livro não encontrado")


# =========================
# TESTE 5 - APAGAR LIVRO
# =========================

print("\n", "=" * 8, "APAGAR LIVRO", "=" * 8)


# Buscar o livro criado para pegar o ID dele

livros = listar_livros()

id_teste = None

for livro in livros:
    if livro[1] == "Python Avançado":
        id_teste = livro[0]


if id_teste:

    resultado = apagar_livro(id_teste)

    if resultado:
        print("Livro de teste apagado com sucesso")
    else:
        print("Não foi possível apagar")

else:
    print("Livro de teste não encontrado")