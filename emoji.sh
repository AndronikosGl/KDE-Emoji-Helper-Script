#!/bin/bash

# Έλεγχος περιβάλλοντος (X11 ή Wayland)
IS_WAYLAND=false
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    IS_WAYLAND=true
fi

# Αν είναι X11, αποθήκευσε το ID του ενεργού παραθύρου
if [ "$IS_WAYLAND" = false ]; then
    ACTIVE_WIN=$(xdotool getactivewindow)
fi

# 1. Καθάρισε το clipboard
qdbus org.kde.klipper /klipper org.kde.klipper.klipper.clearClipboardHistory
qdbus org.kde.klipper /klipper org.kde.klipper.klipper.setClipboardContents ""

# 2. Άνοιξε το Emoji Picker
plasma-emojier &
PICKER_PID=$!

# 3. Περίμενε μέχρι το clipboard να αλλάξει
while true; do
    CLIP=$(qdbus org.kde.klipper /klipper org.kde.klipper.klipper.getClipboardContents)

    if [ -n "$CLIP" ]; then
        break
    fi

    if ! kill -0 $PICKER_PID 2>/dev/null; then
        exit 0
    fi

    sleep 0.05
done

# 4. Κλείσε το picker
kill $PICKER_PID 2>/dev/null

# 5. Επαναφορά Focus & Επικόλληση ανάλογα με το περιβάλλον
if [ "$IS_WAYLAND" = true ]; then
    # Wayland: Επαναφορά focus με ESC
    ydotool key 1:1 1:0
    sleep 0.2
    # Paste με Ctrl+V (29=Ctrl, 47=V)
    ydotool key 29:1 47:1 47:0 29:0
else
    # X11: Επαναφορά focus στο αρχικό παράθυρο
    xdotool windowactivate "$ACTIVE_WIN"
    sleep 0.2
    # Paste με Ctrl+V μέσω xdotool
    xdotool key ctrl+v
fi
