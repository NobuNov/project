#!/bin/bash
read -p "Enter directory name: " DEV_DIR
mkdir -p $DEV_DIR/.devcontainer

# Create devcontainer.json file with the specified content
cat <<EOF > $DEV_DIR/.devcontainer/devcontainer.json
{
	"name": "Node.js & TypeScript",
	"image": "mcr.microsoft.com/devcontainers/typescript-node:1-22-bookworm"
}
EOF

cd $DEV_DIR
code .