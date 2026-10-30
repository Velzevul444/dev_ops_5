import os
import psycopg2
from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify(
        message="DevOps Practical Work 7",
        status="running"
    )

@app.route("/db")
def database():
    try:
        conn = psycopg2.connect(
            host=os.getenv("DB_HOST", "db"),
            dbname=os.getenv("DB_NAME", "devops"),
            user=os.getenv("DB_USER", "devops"),
            password=os.environ["DB_PASSWORD"],
            connect_timeout=5
        )

        with conn.cursor() as cursor:
            cursor.execute("SELECT version();")
            version = cursor.fetchone()[0]

        conn.close()

        return jsonify(
            database="connected",
            version=version
        )

    except Exception as error:
        return jsonify(
            database="error",
            message=str(error)
        ), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
