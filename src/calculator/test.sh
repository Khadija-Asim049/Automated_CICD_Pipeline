#!/bin/bash
OUTPUT=$(./build/app)
echo "$OUTPUT" | grep -q "add(3,3) = 5" && \
echo "$OUTPUT" | grep -q "subtract(5,1) = 4" && \
echo "All tests passed." && exit 0

echo "Tests failed." && exit 1
