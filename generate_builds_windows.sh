# Enter the bin directory
cd bin/

# Load the previously generated script encryption key
export SCRIPT_AES256_ENCRYPTION_KEY=$(cat godot.gdkey)

# Enter the godot directory
cd godot/

# Build windows export templates
scons target=template_debug production=yes use_mingw=yes platform=windows use_static_cpp=yes debug_symbols=no lto=auto d3d12=no use_llvm=yes use_lld=yes
scons target=template_release production=yes use_mingw=yes platform=windows use_static_cpp=yes debug_symbols=no lto=auto d3d12=no use_llvm=yes use_lld=yes
