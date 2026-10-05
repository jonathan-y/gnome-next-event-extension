# Next Event (GNOME Shell Extension)

Shows today’s next calendar event in the GNOME top bar. Click the widget to see all upcoming events for today, then click any event to open GNOME Calendar.

The top bar shows only timed events. All-day events appear at the top of the dropdown with an “All day” label, separated from timed events. Because GNOME’s event source provides only start and end times, events running from midnight to a later midnight are treated as all-day events.

An ongoing event shows its title with a solid white dot. During the 5 minutes before the next timed event, that upcoming event takes priority in the top bar with its time, title, and a pulsing white dot, even if another event is still running. Opening the dropdown stops the pulse while keeping the upcoming event displayed. At its start, the dot becomes solid and the newly started event becomes current. When no event is running, the next event's time and title appear normally until its alert window.

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
- Highlight ongoing events (solid white dot in the top bar, `Now` in the dropdown)
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

For development on GNOME 49 and later, install `mutter-dev-bin` (Ubuntu), then run:

```bash
./dev.sh
```

This compiles settings, links the extension to this checkout (backing up any previous installation), and enables it in a nested GNOME preview. Close the preview and rerun the command after changing JavaScript. Your main desktop session keeps running. Preference changes apply immediately, and preview logs appear in the terminal.

Publishing + review checklist: `docs/README.md`
