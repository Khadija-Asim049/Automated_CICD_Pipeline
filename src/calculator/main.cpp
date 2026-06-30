#include <iostream>
using namespace std;

int add(int a, int b) { 
	return a + b; 
}
int subtract(int a, int b) { 
	return a - b; 
}

int main() {
    cout << "Program running." << endl;
    cout << "add(3,2) = " << add(3,2) << endl;
    cout << "subtract(5,1) = " << subtract(5,1) << endl;
    return 0;
}
