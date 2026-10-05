# Next Event (GNOME Shell Extension)

Shows today’s next calendar event in the GNOME top bar. Click the widget to see all upcoming events for today, then click any event to open GNOME Calendar.

The top bar shows only timed events. All-day events appear at the top of the dropdown with an “All day” label, separated from timed events. Because GNOME’s event source provides only start and end times, events running from midnight to a later midnight are treated as all-day events.

A dot pulses beside the displayed event during the 5 minutes before it starts. Opening the dropdown acknowledges the alert. The dot stops when the event starts, when the label changes to `Now` if that setting is enabled.

## Quick install (Ubuntu, end user)

1. Download `next-event@bhavik.dev.shell-extension.zip` from this repo’s **Releases** page.
2. Open terminal in your Downloads folder and run:
   ```bash
   gnome-extensions install --force next-event@bhavik.dev.shell-extension.zip
   gnome-extensions enable next-event@bhavik.dev
   ```
3. (Optional) Open **Extension Manager** and configure preferences.

If the UI does not refresh immediately on Wayland, log out and back in once.

## Customize (Extension Manager / Preferences)

Open preferences:

```bash
gnome-extensions prefs next-event@bhavik.dev
```

Available settings:
- Panel position (left / center / right)
- Font size
- Max title length
- Refresh interval (seconds)
- Show/hide `Now` indicator
- Alert before event (minutes, default 5; 0 disables alerts)

## Uninstall

```bash
gnome-extensions disable next-event@bhavik.dev
rm -rf ~/.local/share/gnome-shell/extensions/next-event@bhavik.dev
```

## Build package from source

```bash
./package.sh
```

Creates: `dist/next-event@bhavik.dev.shell-extension.zip`

## Maintainer docs

Publishing + review checklist: `docs/README.md`
