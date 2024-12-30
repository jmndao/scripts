# Update Version Script

This Bash script simplifies version management for your `package.json` files. It supports incrementing the version number or setting a specific version. You can also configure a root directory for your projects, making the script flexible and reusable across multiple projects.

## Features

- **Increment Version**: Automatically increments the `patch` version of your project.
- **Set Specific Version**: Allows you to manually set a specific version (e.g., `1.2.3`).
- **Directory Configuration**: Use a configurable root directory to locate your project folders.
- **Easy Integration**: Globally accessible after setup.

---

## Usage

### Command Syntax

```bash
update-version [-i|--increment] [-v|--version <newVersion>] [-d|--dir <relativeDirectory>] [-h|--help]
```

### Options

| Option              | Description                                         |
| ------------------- | --------------------------------------------------- |
| `-i`, `--increment` | Increment the current version (patch by default).   |
| `-v`, `--version`   | Set a specific version (e.g., `1.2.3`).             |
| `-d`, `--dir`       | Specify the relative directory under the root path. |
| `-h`, `--help`      | Show the help message.                              |

---

### Examples

#### Increment Version

Increment the `patch` version of the `package.json` file in the `routines` directory:

```bash
update-version -i -d routines
```

#### Set a Specific Version

Set the version to `2.0.0` for a project in the `routines` directory:

```bash
update-version -v 2.0.0 -d routines
```

#### Default Directory

If no directory is specified, the script assumes the root directory as configured:

```bash
update-version -i
```

#### Override the Root Path

Temporarily override the root path for specific use cases:

```bash
ROOT_PATH="/custom/path" update-version -v 3.0.0 -d my-project
```

---

## Configuration

The script uses a configuration file located at `~/scripts/update-version.conf` to set default values like the root path.

### Example Configuration File

```bash
# Root path for locating projects
ROOT_PATH="$HOME/projects"
```

---

## Setup Instructions

### 1. Clone or Save the Script

Save the `update-version` script to a directory, such as `~/scripts`.

### 2. Make the Script Executable

```bash
chmod +x ~/scripts/update-version
```

### 3. Add the Directory to PATH

Add the following line to your shell configuration file (`~/.bashrc` or `~/.zshrc`):

```bash
export PATH="$HOME/scripts:$PATH"
```

Reload the shell configuration:

```bash
source ~/.bashrc
```

---

## Author

**Jonathan Moussa Ndao**

---

## License

This script is licensed under the ISC License. See the `LICENSE` file for details.

```

This README includes:

- **Features**: Lists key functionalities.
- **Usage**: Explains the syntax and options.
- **Examples**: Provides practical examples.
- **Configuration**: Details how to set up and configure the script.
- **Setup Instructions**: Guides users through installation.
- **Author**: Highlights your name as the creator.
- **License**: Adds a placeholder for licensing information. You can replace or remove it as needed.
```
