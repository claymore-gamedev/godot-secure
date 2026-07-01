# Make the bin directory
mkdir bin
cd bin

# Prepare godot sources
#   - Clone
#   - Reset hard and clean to undo all modifications
#   - Checkout the engine version you want
git clone https://github.com/godotengine/godot.git
cd godot
git fetch
git submodule update --init
git reset --hard
git clean -xfd
git submodule foreach --recursive git reset --hard
git submodule foreach --recursive git clean -xfd
git checkout 4.7-stable
rm -rf ./bin
cd ..

# Generate an encryption key and set it as en environment variable
openssl rand -hex 32 > godot.gdkey
export SCRIPT_AES256_ENCRYPTION_KEY=$(cat godot.gdkey)

# Find and replace all occurences of godot with something else across all files
# Example usage:
# replace_string apple banana

# Run godot-secure scripts
python ../scripts/godot-secure_AES-256_v4.py ./godot/

cd godot

python misc/scripts/install_accesskit.py
python misc/scripts/install_angle.py
python misc/scripts/install_d3d12_sdk_windows.py
python misc/scripts/install_perfetto.py
python misc/scripts/install_swappy_android.py
python misc/scripts/install_winrt.py