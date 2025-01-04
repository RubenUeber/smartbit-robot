import psycopg2

db_conn = """
        host='ep-late-lake-a5vr6m8v.us-east-2.aws.neon.tech'
        dbname='neondb'
        user='neondb_owner'
        password='kOLGZ3HpS4Ut'
"""

def execute(query):
    conn = psycopg2.connect(db_conn)

    cur = conn.cursor()
    cur.execute(query)
    conn.commit()
    conn.close()

def insert_account(accounts):

    query = f"""
        INSERT INTO accounts (name, email, cpf) 
        VALUES ('{accounts["name"]}', '{accounts["email"]}','{accounts["cpf"]}')
    """
    execute(query)

  

def delete_account_by_email(email):

    query = f"DELETE FROM accounts where email = '{email}';"

    execute(query)