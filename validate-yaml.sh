#!/bin/bash
echo "Validating YAML files..."

# Check all YAML files for syntax errors
find . -name "*.yml" -o -name "*.yaml" | while read file; do
    echo "Checking: $file"
    python -c "import yaml; yaml.safe_load(open('$file'))" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "❌ ERROR in: $file"
    else
        echo "✅ Valid: $file"
    fi
done

echo "YAML validation complete."