TARGET = RayTracer

CXX = c++
CXXFLAGS = -I./lib/glew-2.1.0/include -I./lib/glfw-3.4/include -I./include -std=c++11 -Wall

LDFLAGS = -L./lib/glew-2.1.0/lib -L./lib/glfw-3.4/lib-arm64 \
			-lglfw3 -framework OpenGL -lGLEW -framework OpenGL -framework GLUT -framework Cocoa -framework IOKit -framework CoreVideo \
			-Wl,-rpath,./lib/glew-2.1.0/lib -Wl,-rpath,./lib/glfw-3.4/lib-arm64

SRC_DIR		= ./src
OBJ_DIR		= ./obj

SRC_FILES = $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES = $(SRC_FILES:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

CLANGD_GEN = ./clangd_gen.sh

all : $(TARGET)
	$(MAKE) clangd

$(TARGET) : $(OBJ_FILES)
	$(CXX) -o $@ $^ $(LDFLAGS)
	install_name_tool -change /usr/local/lib/libGLEW.2.1.0.dylib @executable_path//lib/glew-2.1.0/lib/libGLEW.2.1.0.dylib $(TARGET)

$(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp
	mkdir -p $(dir $@)
	$(CXX) -c -o $@ $(CXXFLAGS) $<

clean :
	rm .clangd
	rm -rf $(OBJ_DIR) $(TARGET)

clangd :
	/bin/bash $(CLANGD_GEN)

fclean :
	$(MAKE) clean
	rm -rf ./lib/sfml/2.6.1

.PHONY : all clean