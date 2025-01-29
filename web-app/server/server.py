from flask import Flask, request, jsonify
from arithmetic import Addition, Subtraction, Multiplication, Division

app = Flask(__name__)

def perform_operation(operation, a, b):
    operations = {
        "+": Addition(),
        "-": Subtraction(),
        "*": Multiplication(),
        "/": Division(),
    }
    if operation not in operations:
        return "Invalid operation."
    try:
        return operations[operation].compute(a, b)
    except Exception as e:
        return str(e)

@app.route("/health", methods=["GET"])
def health_check():
    return jsonify({"status": "healthy"}), 200

@app.route("/compute", methods=["POST"])
def compute():
    data = request.json
    operation = data.get("operation")
    a = data.get("a")
    b = data.get("b")

    if operation is None or a is None or b is None:
        return jsonify({"error": "Missing required fields."}), 400

    print(f"Received request: {data}")
    result = perform_operation(operation, a, b)
    print(f"Computed result: {result}")

    return jsonify({"result": result})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
