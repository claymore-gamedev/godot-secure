# Enter the bin directory
cd bin/

# Load the previously generated script encryption key
export SCRIPT_AES256_ENCRYPTION_KEY=$(cat godot.gdkey)

# Enter the godot directory
cd godot/

# Build the editor
scons target=editor production=yes use_llvm=yes platform=linuxbsd

# Build linux export templates
scons target=template_debug production=yes use_llvm=yes platform=linuxbsd
scons target=template_release production=yes use_llvm=yes platform=linuxbsd debug_symbols=no

# Build windows export templates
scons target=template_debug production=yes use_mingw=yes platform=windows d3d12=no
scons target=template_release production=yes use_mingw=yes platform=windows d3d12=no debug_symbols=no
