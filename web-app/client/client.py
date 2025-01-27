import requests

def main():
    while True:
        print("Enter two numbers and an operation (+, -, *, /):")
        a = float(input("First number: "))
        b = float(input("Second number: "))
        operation = input("Operation: ").strip()

        if operation not in ["+", "-", "*", "/"]:
            print("Invalid operation. Please enter one of +, -, *, /.")
            continue

        request_data = {"a": a, "b": b, "operation": operation}

        try:
            response = requests.post("http://server:5000/compute", json=request_data)
            response_data = response.json()

            if response.status_code == 200:
                print(f"Result: {response_data['result']}")
            else:
                print(f"Error: {response_data.get('error', 'Unknown error')}")
        except Exception as e:
            print(f"An error occurred: {e}")

        again = input("Do you want to perform another operation? (yes/no): ").strip().lower()
        if again != "yes":
            break

if __name__ == "__main__":
    main()
