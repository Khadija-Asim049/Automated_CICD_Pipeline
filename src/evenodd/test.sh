#!/bin/bash
OUTPUT=$(./build/app)
echo "$OUTPUT" | grep -q "4 is even" && \
echo "$OUTPUT" | grep -q "7 is odd" && \
echo "$OUTPUT" | grep -q "0 is even" && \
echo "All tests passed." && exit 0
echo "Tests failed." && exit 1
