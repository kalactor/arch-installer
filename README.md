# Arch Linux Auto Install Script

This repo includes scripts which automate the installation of a minimal Arch Linux system. It requires user input only at the start and then proceeds automatically, setting up partitions, installing packages, configuring the system, and enabling necessary services.

## Features
- Automated disk partitioning and formatting
- Base system installation with essential packages
- Configures system settings (hostname, locale, timezone, etc.)
- Sets up a bootloader (GRUB/EFI support)
- Enables networking and user creation
  
## Prerequisites
Before running the script, ensure:
- The system is booted into an Arch Linux live environment
- You have a working internet connection
- `git` must be installed
- The disk you want to install Arch Linux on is identified with `lsblk` etc. (e.g., `/dev/sda`)

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/kalactor/arch-installer
   cd arch-installer
   ```
2. Make the all scripts executable:
   ```sh
   chmod +x *.sh
   ```
3. Run the script:
   ```sh
   ./arch.sh
   ```

## Customization
The script allows customization of the following:
- Installed packages
- User configuration
- Window manager or desktop environment (optional)

Modify the `arch.sh` script as needed before execution.

## Disclaimer
This script will erase the target disk and install Arch Linux. Use it at your own risk.

## Contributing
Feel free to fork this repository, submit issues, or contribute improvements via pull requests.

## License

This project is licensed under the MIT License. See the [`LICENSE`](LICENSE) file for details.

---

## MIT License

```
MIT License

Copyright (c) 2025 Amit Kumar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

