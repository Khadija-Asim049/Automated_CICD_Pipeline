#!/bin/bash
OUTPUT=$(./build/app)
echo "$OUTPUT" | grep -q "racecar is palindrome" && \
echo "$OUTPUT" | grep -q "hello is not a palindrome" && \
echo "$OUTPUT" | grep -q "madam is palindrome" && \
echo "All tests passed." && exit 0
echo "Tests failed." && exit 1
