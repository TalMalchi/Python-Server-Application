from abc import ABC, abstractmethod

class ArithmeticOperation(ABC):
    @abstractmethod
    def compute(self, a, b):
        pass

class Addition(ArithmeticOperation):
    def compute(self, a, b):
        return a + b

class Subtraction(ArithmeticOperation):
    def compute(self, a, b):
        return a - b

class Multiplication(ArithmeticOperation):
    def compute(self, a, b):
        return a * b

class Division(ArithmeticOperation):
    def compute(self, a, b):
        if b == 0:
            raise ValueError("Cannot divide by zero.")
        return a / b
