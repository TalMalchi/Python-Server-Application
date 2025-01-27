from flask import Flask, request, jsonify, send_from_directory
import requests
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)

# Server URL
SERVER_URL = "http://server:5000/compute"


@app.route('/')
def index():
    return send_from_directory('.', 'index.html')


@app.route('/calculate', methods=['POST'])
def calculate():
    data = request.json
    logger.info(f"Received calculation request: {data}")

    try:
        response = requests.post(SERVER_URL, json=data)
        response_data = response.json()

        logger.info(f"Server response: {response_data}")
        return jsonify(response_data), response.status_code

    except Exception as e:
        error_msg = f"Error occurred: {str(e)}"
        logger.error(error_msg)
        return jsonify({"error": error_msg}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001, debug=True)