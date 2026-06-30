#include <iostream>
#include <string>
#include <algorithm>
using namespace std;

string checkPalindrome(string s) {
    string reversed = s;
    reverse(reversed.begin(), reversed.end());
    return (s == reversed) ? "palindrome" : "not a palindrome";
}

int main() {
    cout << "racecar is " << checkPalindrome("racecar") << endl;
    cout << "hello is " << checkPalindrome("hello") << endl;
    cout << "madam is " << checkPalindrome("madam") << endl;
    return 0;
}
