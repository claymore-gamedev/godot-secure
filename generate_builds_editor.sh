# Enter the bin directory
cd bin/

# Load the previously generated script encryption key
export SCRIPT_AES256_ENCRYPTION_KEY=$(cat godot.gdkey)

# Enter the godot directory
cd godot/

# Build the editor
scons target=editor production=yes platform=linuxbsd use_static_cpp=yes debug_symbols=no lto=auto linker=mold

# Copy editor to godot4 executable
sudo cp bin/godot.linuxbsd.editor.x86_64 /usr/bin/godot4