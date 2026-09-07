from fastapi import FastAPI
from pydantic import BaseModel
import psycopg2

app = FastAPI()


DB_CONFIG = {
    "host": "host.docker.internal",
    "port": 55432,
    "database": "myapp",
    "user": "admin",
    "password": "admin123"
}


def get_connection():
    return psycopg2.connect(**DB_CONFIG)


def create_table():
    connection = get_connection()
    cursor = connection.cursor()

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            age INTEGER NOT NULL
        )
    """)

    connection.commit()
    cursor.close()
    connection.close()


class User(BaseModel):
    name: str
    age: int


@app.on_event("startup")
def startup():
    create_table()


@app.get("/")
def home():
    return {
        "message": "Python Kubernetes Application is running"
    }


@app.post("/users")
def create_user(user: User):

    connection = get_connection()
    cursor = connection.cursor()

    cursor.execute(
        "INSERT INTO users (name, age) VALUES (%s, %s) RETURNING id",
        (user.name, user.age)
    )

    user_id = cursor.fetchone()[0]

    connection.commit()

    cursor.close()
    connection.close()

    return {
        "message": "User created successfully",
        "id": user_id,
        "name": user.name,
        "age": user.age
    }


@app.get("/users")
def get_users():

    connection = get_connection()
    cursor = connection.cursor()

    cursor.execute("SELECT id, name, age FROM users ORDER BY id")

    users = cursor.fetchall()

    cursor.close()
    connection.close()

    return [
        {
            "id": user[0],
            "name": user[1],
            "age": user[2]
        }
        for user in users
    ]