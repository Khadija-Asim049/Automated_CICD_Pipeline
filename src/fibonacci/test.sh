#!/bin/bash
OUTPUT=$(./build/app)
echo "$OUTPUT" | grep -q "Fibonacci(7):0 1 1 2 3 5 8" && \
echo "All tests passed." && exit 0
echo "Tests failed." && exit 1
