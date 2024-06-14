#!/bin/bash

glew_path="lib/glew-2.1.0/include"
glfw_path="lib/glfw-3.4/include"

if [ ! -d "$glew_path" ]; then
    echo "SFML library should exists in $sfml_path"
    exit 1
fi

if [ ! -d "$glfw_path" ]; then
    echo "GLFW library should exists in $glfw_path"
    exit 1
fi

pwd=$(pwd)

echo "CompileFlags:" > .clangd
echo "  Add: [-I$pwd/$glew_path,-I$pwd/$glfw_path,-I$pwd/include, -I$pwd/src]" >> .clangd