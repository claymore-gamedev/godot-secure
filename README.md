# Godot Secure - Enhanced Asset Protection For Godot
[![Godot Engine 4.x](https://img.shields.io/badge/Godot_Engine-4.x-blue)](https://godotengine.org/)
[![MIT License](https://img.shields.io/badge/license-MIT-blue)](https://github.com/KnifeXRage/Godot-Secure/blob/main/LICENSE)
<a href='https://ko-fi.com/V7V41FR21F' target='_blank'><img height='21' style='border:0px;height:21px;' src='https://storage.ko-fi.com/cdn/kofi5.png?v=6' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>

![Godot Secure Logo](/logos/pngs/Godot%20Secure.png)

## Description

**Godot Secure** is a simple python script that modifies the Godot Engine source code to integrate **Camellia-256 / AES-256** encryption with a **unique security token**. This solution creates a **unique engine build** that prevents generic decryption tools from accessing your game assets.

## Key Features

- **Randomized Magic Headers**: Unique file signatures
- **Security Token System**: 32-byte token embedded directly in engine's binary
- **Per-Build Uniqueness**: Each compilation of engine and templates is unique
- **Automated Setup**: One-command modification of Godot source
- **No external dependencies**: Everything included

## Difference

| Feature | Standard Godot | Godot Secure |
|---------|----------------|--------------|
| Encryption Algorithm | AES-256 | Camellia-256 / AES-256 |
| Universal Decryption Tools | Vulnerable | **Protected** |
| Per Build Uniqueness | No | **Yes** |
| Key Obfuscation | No | **Yes** |
| Magic Header | Fixed | **Randomized** |
| Required Reverse Engineering | Generic | **Per-Build** |

## Requirements

1. **Godot Source Code** (4.x recommended)
2. **Python 3.10+**
3. **OpenSSL**
4. **Build Tools** (SCons, platform specific dependencies)

## Installation & Usage

### Step 0: Download Godot-Secure

Download the latest release of Godot-Secure: [Download](https://github.com/KnifeXRage/Godot-Secure/releases/)

### Step 1: Prepare Environment

```bash
git clone https://github.com/godotengine/godot.git
cd godot
```

### Step 2: Generate Encryption Key

Generate a 256-bit key (KEEP THIS SECURE!).
```bash
openssl rand -hex 32 > godot.gdkey
```
Store the generated key in an environment variable.

For Linux/macOS:
```bash
export SCRIPT_AES256_ENCRYPTION_KEY=$(cat godot.gdkey)
```

For Windows (PowerShell):
```bash
$env:SCRIPT_AES256_ENCRYPTION_KEY = Get-Content godot.gdkey
```

### Step 3: Run Setup Script
> _NOTE:_ You can run the script directly inside the Godot source folder without using an argument for the path!
```bash
# Run The Godot Secure Script
python godot_secure.py /path/to/godot_source/
```

### Step 4: Compile Godot Engine and Export Templates
> _NOTE:_ These commands must be run from the modified Godot Engine source code root.
```bash
# Compile any needed platform editor binaries:
scons platform=windows  target=editor # Example for Windows
scons platform=linuxbsd target=editor # Example for Linux BSD
scons platform=macos    target=editor # Example for MacOS

# Compile any needed platform export templates:
scons platform=[platform] target=template_debug  
scons platform=[platform] target=template_release 
```

# How It Works

The script makes these key modifications:

1. **Unique Identifiers**
   - Generates random magic headers for file signatures
   - Creates security token embedded in engine binary

2. **Key Protection**
   - Without Advanced Key Derivation Enabled: 
       - `token_key.write[i] = key_ptr[i] ^ Security::TOKEN[i];`
         OR
         `Actual Key = (Input Key) XOR (Security Token)`
   - Token exists only in compiled binary
3. **If Advanced Key Derivation Enabled**
   - A long totally unique key derivation formula is created using different mathematical operations.
   - Examples of some generated formulas using this algorithm:
      ```bash
      1. token_key.write[i] = (uint8_t)(((((key_ptr[i] & Security::TOKEN[i]) + key_ptr[i]) ^ 151) ^ key_ptr[i]));
      2. token_key.write[i] = (uint8_t)(((((((((key_ptr[i] ^ Security::TOKEN[i]) + key_ptr[i]) ^ 106) + key_ptr[i]) ^ 138) << 6) | ((((((key_ptr[i] ^ Security::TOKEN[i]) + key_ptr[i]) ^ 106) + key_ptr[i]) ^ 138) >> 2)) | Security::TOKEN[i]));
      3. token_key.write[i] = (uint8_t)(((((Security::TOKEN[i] & key_ptr[i]) + Security::TOKEN[i]) ^ Security::TOKEN[i]) ^ Security::TOKEN[i]));
      4. token_key.write[i] = (uint8_t)((((((((((((key_ptr[i] << 7) | (key_ptr[i] >> 1)) ^ Security::TOKEN[i]) + key_ptr[i]) ^ 242) << 2) | ((((((key_ptr[i] << 7) | (key_ptr[i] >> 1)) ^ Security::TOKEN[i]) + key_ptr[i]) ^ 242) >> 6)) + Security::TOKEN[i]) ^ 126) << 6) | ((((((((((key_ptr[i] << 7) | (key_ptr[i] >> 1)) ^ Security::TOKEN[i]) + key_ptr[i]) ^ 242) << 2) | ((((((key_ptr[i] << 7) | (key_ptr[i] >> 1)) ^ Security::TOKEN[i]) + key_ptr[i]) ^ 242) >> 6)) + Security::TOKEN[i]) ^ 126) >> 2)));
      ```
   - _NOTE:_ This may increase your Game Loading time a little bit but it will make your actual key **MUCH HARDER** to obtain using automated tools. And it will make your Engine build completely unique.

# Restore Backup Files

File backups are created automatically, to restore them to their original version run the `restore_backup.py` script located in `utils` folder.

## Troubleshooting

**Script not working?**
- Ensure Python 3.10+ installed
- Verify correct Godot source path
- Run with absolute path if needed: `python godot_secure.py /path/to/godot_source`

**Compilation errors?**
- Clean build: `scons --clean`
- Ensure all submodules: `git submodule update --init`
- Don't runt the script multiple times on the same copy of Godot Engine's source code. Using the script multiple times on same source code can cause **Compilation Errors!**. So, always refresh your Godot Engine source code before running the script on it.

### Common Issues
1. **File not found errors**: Ensure correct Godot Engine source code path
3. **Encryption/decryption mismatch**: Always use matching engine builds and template builds

### Verification Steps
1. Check script output for success messages
2. Confirm `security_token.h` exists in `core/crypto/`
3. Search for `CamelliaContext / AESContext` in modified files
4. Verify magic header values in file headers

## Disclaimer

**Use at Your Own Risk**  
This script modifies core Godot Engine files. Always:
- Back up your source code before running
- Test builds thoroughly before deployment
- Maintain secure copies of security tokens
- Understand that enhanced security increases complexity

### Security Disclaimer

**Important Considerations**
   - Standard export templates won't work
   - Always test builds before deployment
   - Maintain backups of security tokens

### Rebuild Protocol
**Always rebuild when:**
   - Updating Godot Engine source
   - Changing security parameters
   - Creating new game versions
   - Suspecting key compromise

# License
- MIT License - Free for Personal and Commercial use with attribution: 
[View License](https://github.com/KnifeXRage/Godot-Secure/blob/main/LICENSE)
---
