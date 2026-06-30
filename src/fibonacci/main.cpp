#include <iostream>
using namespace std;

void fibonacci(int n) {
    int a = 0, b = 1;
    for (int i = 0; i < n; i++) {
        cout << a << " ";
        int temp = a + b;
        a = b;
        b = temp;
    }
    cout << endl;
}

int main() {
    cout << "Fibonacci(7): ";
    fibonacci(7);
    return 0;
}
