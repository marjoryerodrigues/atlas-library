import psycopg


def conectar():
    conexao = psycopg.connect(
        host="localhost",
        dbname="atlas_library",
        user="postgres",
        password="apolonio",
        port="5432"
    )

    return conexao


def criar_cursor():
    conexao = conectar()
    cursor = conexao.cursor()

    return conexao, cursor

def pesquisar_isbn(isbn):
    conexao, cursor = criar_cursor()

    cursor.execute(
        "SELECT id FROM livros WHERE isbn = %s;",
        (isbn,)
    )

    resultado = cursor.fetchone()

    cursor.close()
    conexao.close()

    return resultado