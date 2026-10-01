# 🔍 pwhich (Package Which)

**pwhich** is a lightweight command-line utility and graphical application for **Ubuntu / Linux**. It quickly audits and identifies where a package or executable comes from across the different package managers (**APT/DEB**, **Snap** and **Flatpak**).

---

## ✨ Features

- **Unified search**: Queries APT (`dpkg`), Snap and Flatpak at the same time.
- **Binary location**: Shows the path of the executable and, if it is a symbolic link, its real target.
- **Partial name matching**: Filters matching packages for you.
- **GNOME application shortcut**: Integrates into the applications menu and opens an interactive terminal.
- **System-wide install**: Available globally through `/usr/local/bin/pwhich`.

---

## 🛠️ Project structure

* pwhich.sh: Main shell script
* pwhich.desktop: Desktop Entry file (GNOME shortcut)
* install.sh: Automatic installation script
* uninstall.sh: Uninstallation script
* DEBT.md: Known technical debt and pending decisions
* README.md: Project documentation

---

## 📋 Requirements

- Ubuntu / Debian (or derivative): the APT lookup relies on `dpkg`.
- `bash` and `sudo` (to copy the executable into `/usr/local/bin`).
- Optional: `snap` and `flatpak`. They are skipped when not installed.

---

## 🚀 Installation

1. Clone the repository and move into the project folder:
   git clone https://github.com/saxgard13/pwhich.git
   cd pwhich

2. Run the installation:
   ./install.sh

The installation script will:
- Copy the executable to `/usr/local/bin/pwhich`.
- Install the `.desktop` file in `~/.local/share/applications/`.
- Refresh the system application database.

---

## 💡 Usage

### Command line (Terminal)

You can run the tool from any folder:

pwhich keepassxc
pwhich firefox
pwhich docker

Without an argument, `pwhich` asks for the name to inspect.

The `--pause` option keeps the terminal open at the end (used by the application menu shortcut):

pwhich --pause

### Graphical interface (Applications menu)

1. Open the Ubuntu application launcher (Super / Windows key).
2. Search for "pwhich".
3. Click the icon: a terminal opens and asks for the name of the software to inspect.

---

## 🖥️ Example output

🔍 Looking up origin of: firefox
----------------------------------------
📍 Executable: /usr/bin/firefox

📦 APT package (DEB):
   - firefox              1:1snap1-0ubuntu9.1 

🟢 Snap package:
   - firefox              157.0-1             
----------------------------------------

If the executable is a symbolic link, an extra line shows its target:

📍 Executable: /usr/bin/c++
🔗 Links to  : /usr/bin/x86_64-linux-gnu-g++-15

---

## 🧪 Development

Before each commit, check the scripts with [ShellCheck](https://www.shellcheck.net/) (`sudo apt install shellcheck`):

shellcheck pwhich.sh install.sh uninstall.sh

---

## 🗑️ Uninstallation

To completely remove the application from the system:

./uninstall.sh
