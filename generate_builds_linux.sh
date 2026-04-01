# Enter the bin directory
cd bin/

# Load the previously generated script encryption key
export SCRIPT_AES256_ENCRYPTION_KEY=$(cat godot.gdkey)

# Enter the godot directory
cd godot/

# Build the editor
scons target=editor production=yes platform=linuxbsd use_static_cpp=yes debug_symbols=no lto=auto

# Build linux export templates
scons target=template_debug production=yes platform=linuxbsd use_static_cpp=yes debug_symbols=no lto=auto
scons target=template_release production=yes platform=linuxbsd use_static_cpp=yes debug_symbols=no lto=auto
