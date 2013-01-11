from flask import Flask
from flask import jsonify
import json


app = Flask(__name__)

@app.route("/")
def hello():
    return "hellooo"

@app.route("/news")
def news():
    return jsonify(data=["apple","orange","banana"])



if __name__ == "__main__":
    app.debug = True
    app.run()
