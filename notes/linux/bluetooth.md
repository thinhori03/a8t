To enable Bluetooth on Linux via the command line, you can use the following steps:

## ensure your linux user in bluetooth group.

``` sb
  groups $USER
```

2. **Check if Bluetooth is installed:**

   Make sure the Bluetooth utilities are installed. On most distributions, the package is called `bluez`. Install it if it's not present:
   
   - **Debian/Ubuntu**:
     ```bash
     sudo apt install bluez
     ```

   - **Fedora**:
     ```bash
     sudo dnf install bluez
     ```

   - **Arch Linux**:
     ```bash
     sudo pacman -S bluez
     ```

3. **Start the Bluetooth service:**

   Start the Bluetooth service using `systemctl`:
   ```bash
   sudo systemctl start bluetooth
   ```

   To ensure the Bluetooth service starts automatically at boot:
   ```bash
   sudo systemctl enable bluetooth
   ```

4. **Check the status of Bluetooth:**

   You can check if Bluetooth is active with:
   ```bash
   sudo systemctl status bluetooth
   ```

5. **Enable the Bluetooth adapter (if needed):**

   If the Bluetooth adapter is powered off, you can turn it on using `bluetoothctl`:
   ```bash
   bluetoothctl
   power on
   ```

6. **Pairing and Connecting Devices:**

   Inside the `bluetoothctl` interactive shell:
   - To list available devices:
     ```bash
     devices
     ```

   - To start scanning for devices:
     ```bash
     scan on
     ```

   - To pair with a device:
     ```bash
     pair <device_mac_address>
     ```

   - To connect to a paired device:
     ```bash
     connect <device_mac_address>
     ```

   - To trust a device:
     ```bash
     trust <device_mac_address>
     ```

7. **Exit `bluetoothctl`:**

   When you're done, exit the `bluetoothctl` interactive shell by typing:
   ```bash
   exit
   ```

This should enable Bluetooth and allow you to manage your Bluetooth devices via the command line.
