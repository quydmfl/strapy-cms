#!/bin/bash

submodule_path="protobuf"
sparse_checkout_paths="pb"

# Check if submodule exists
if [ ! -d "$submodule_path" ]; then
  git submodule add --force git@github.com:quydmfl/strapy-api.git "$submodule_path"
fi

# Update the submodule (consider adding --remote for fetching)
git submodule update --recursive --sparse

# Go to the submodule directory
cd "$submodule_path"

# Initialize sparse checkout (if not already initialized)
if [ ! -f ".git/info/sparse-checkout" ]; then
  git sparse-checkout init
fi

# Set the sparse checkout paths (only if sparse checkout is enabled)
if git config --get core.sparseCheckout; then
  git sparse-checkout set "$sparse_checkout_paths"
fi

# Go back to the main project directory
cd ..
