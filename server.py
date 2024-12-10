from flask import Flask, request

app = Flask(__name__)

@app.route('/log', methods=['POST'])
def log():
    data = request.get_json()
    print(data)
    return "Received", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
