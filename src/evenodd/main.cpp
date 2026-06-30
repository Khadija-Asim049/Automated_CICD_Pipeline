#include <iostream>
using namespace std;

string checkEvenOdd(int n) {
    return (n % 2 == 0) ? "even" : "odd";
}

int main() {
    cout << "4 is " << checkEvenOdd(4) << endl;
    cout << "7 is " << checkEvenOdd(7) << endl;
    cout << "0 is " << checkEvenOdd(0) << endl;
    return 0;
}
