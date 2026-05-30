## About
This simple script makes typing emojis in KDE Plasma easier by auto inserting them in the focus application and then closing the emoji dialog, something that existed always on Gnome but was never implemented on KDE Plasma. It uses a simple magic of ydotool, xdotool and pkill
## Demo video
https://github.com/user-attachments/assets/08b793bf-9e0e-42cb-a864-cf7ebafe906b

## How to set it up
- First you need to give permitions to the script by using `chmod +x emoji.sh
- Make sure that xdotool and ydotool are installed on your system
- For wayland make sure you give input permisions to your user by executing `sudo usermod -aG input <yourusername>`
- Create a new keyboard shortcut in plasma settings `Settings> Keyboard> Shortcuts> Add` and add your script by using `your/full/path/emoji.sh`


