from python import Python

def main():
    np = Python.import_module('numpy')
    array = np.array([1,2,3,4,5])
    print(array)
