cd bin/godot/bin

# Copy editor to godot4 executable
sudo cp godot.linuxbsd.editor.x86_64 /usr/bin/godot4

# Link templates to the correct spot
sudo ln -f godot.linuxbsd.template_debug.x86_64 ~/.local/share/godot/export_templates/4.6.3.stable/linux_debug.x86_64
sudo ln -f godot.linuxbsd.template_release.x86_64 ~/.local/share/godot/export_templates/4.6.3.stable/linux_release.x86_64
sudo ln -f godot.windows.template_debug.x86_64.exe ~/.local/share/godot/export_templates/4.6.3.stable/windows_debug_x86_64.exe
sudo ln -f godot.windows.template_release.x86_64.exe ~/.local/share/godot/export_templates/4.6.3.stable/windows_release_x86_64.exe
