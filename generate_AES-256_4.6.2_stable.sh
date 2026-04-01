# Make the bin directory
mkdir bin
cd bin

# Prepare godot sources
#   - Clone
#   - Reset hard and clean to undo all modifications
#   - Checkout the engine version you want
git clone https://github.com/godotengine/godot.git
cd godot
git submodule update --init
git reset --hard
git clean -f
git checkout 4.6.2-stable
cd ..

# Generate an encryption key and set it as en environment variable
openssl rand -hex 32 > godot.gdkey
export SCRIPT_AES256_ENCRYPTION_KEY=$(cat godot.gdkey)

# Run godot-secure scripts
python ../scripts/v4.6.x-latest/godot-secure_AES-256_v4.py ./godot/
