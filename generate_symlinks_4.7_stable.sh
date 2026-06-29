cd bin/godot/bin

mkdir ~/.local/share/godot/export_templates/4.7.stable/

# Link templates to the correct spot
sudo ln -f godot.linuxbsd.template_debug.x86_64 ~/.local/share/godot/export_templates/4.7.stable/linux_debug.x86_64
sudo ln -f godot.linuxbsd.template_release.x86_64 ~/.local/share/godot/export_templates/4.7.stable/linux_release.x86_64
sudo ln -f godot.windows.template_debug.x86_64.exe ~/.local/share/godot/export_templates/4.7.stable/windows_debug_x86_64.exe
sudo ln -f godot.windows.template_release.x86_64.exe ~/.local/share/godot/export_templates/4.7.stable/windows_release_x86_64.exe
sudo ln -f godot.web.template_debug.wasm32.zip ~/.local/share/godot/export_templates/4.7.stable/web_debug.zip
sudo ln -f godot.web.template_release.wasm32.zip ~/.local/share/godot/export_templates/4.7.stable/web_release.zip
sudo ln -f godot.web.template_debug.wasm32.nothreads.zip ~/.local/share/godot/export_templates/4.7.stable/web_nothreads_debug.zip
sudo ln -f godot.web.template_release.wasm32.nothreads.zip ~/.local/share/godot/export_templates/4.7.stable/web_nothreads_release.zip
