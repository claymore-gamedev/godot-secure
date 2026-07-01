# Enter the bin directory
cd bin/

# Load the previously generated script encryption key
export SCRIPT_AES256_ENCRYPTION_KEY=$(cat godot.gdkey)

# Enter the godot directory
cd godot/

# Build linux export templates

scons target=template_debug production=yes platform=web use_static_cpp=yes debug_symbols=no lto=auto threads=no
scons target=template_release production=yes platform=web use_static_cpp=yes debug_symbols=no lto=auto threads=no
