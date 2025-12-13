# 15(kernals and kernal modules).

Status: Done

---

## 🔥 **Kernel & Kernel Modules — Updated Notes for Kali (2024/2025)**

### **What is the Kernel?**

- The **core of Linux**, managing communication between **hardware** and **user processes.**
- Controls memory, scheduling, networking, I/O, drivers, security policies.
- Kali (like most Linux distros) uses a **monolithic Linux kernel**, meaning most features run in kernel space but can be extended with **Loadable Kernel Modules (LKMs)** — no full kernel rebuild required.

---

### 🧩 **Kernel Modules (LKMs)**

- Plug-in components that can be **loaded/unloaded at runtime**.
- Used for:
    - Device drivers → USB, Wi-Fi card, GPU, Bluetooth
    - Network features → VPN modules, firewall drivers
    - Filesystems → exFAT, NTFS
    - Security monitoring or virtualization (e.g., VirtualBox, Docker overlay)
- Kali’s default kernel supports most modules without recompilation.

---

### ⚠ Kernel Module Security (more relevant today)

- LKMs run with **Ring-0 privileges** → absolute control.
- Modern Kali kernels support:
    - **Secure Boot module signing** (unsigned modules blocked unless disabled)
    - **Kernel lockdown mode** (restricts debug interfaces)
    - `module.sig_enforce=1` can be enforced to allow *only* signed modules

> Loading malicious drivers is still a common rootkit vector — attackers can hide ports, processes & hook syscalls at kernel level.
> 

---

### 🖥 Check Kernel Version (Latest Kernels are usually 6.x on Kali)

| Command | Output |
| --- | --- |
| `uname -r` | Kernel version only (e.g., `6.8.12-kali1`) |
| `uname -a` | Full kernel + architecture + build info |
| `hostnamectl` | More detailed OS & kernel state |
| `cat /proc/version` | Shows build details + GCC version |

---

### 🔧 Kernel Tuning Using `sysctl` (Modern Kali Behavior)

View all tunables:

```
sysctl -a | less

```

Edit values temporarily (valid until reboot):

```
sudo sysctl -w net.ipv4.ip_forward=1

```

### Permanent configuration (New Kali Standard)

Modern Kali prefers `/etc/sysctl.d/*.conf` instead of editing the main file.

Create config:

```bash
sudo nano /etc/sysctl.d/ip_forward.conf

```

Add:

```
net.ipv4.ip_forward=1

```

Apply instantly:

```bash
sudo sysctl --system

```

---

### 🔥 IP Forwarding (Still common in MITM, routing, hotspot setups)

Check status:

```bash
sysctl net.ipv4.ip_forward

```

Enable permanently (2024+ recommended method):

```bash
echo "net.ipv4.ip_forward=1" | sudo tee /etc/sysctl.d/ip_forward.conf
sudo sysctl --system

```

> No need to edit sysctl.conf — newer Kali loads from /etc/sysctl.d/.
> 

---

### 📦 Managing Kernel Modules (Updated Commands)

| Function | Modern Command |
| --- | --- |
| List loaded modules | `lsmod` |
| Load module | `sudo modprobe <module>` |
| Unload module | `sudo modprobe -r <module>` |
| Inspect module | `modinfo <module>` |
| Search modules on disk | `find /lib/modules/$(uname -r) -name "*.ko"` |

`modprobe` remains the safest — auto-handles dependencies.

Unsigned modules may fail if Secure Boot is enabled.

---

### 🔍 Debugging Modules in 2024+

Check kernel messages (now routed through journald too):

```
dmesg | grep -i <module>
journalctl -k | grep -i <module>

```

Great for driver crashes, firmware issues, USB/Wi-Fi injection modules.

---

### 🧠 Key Points (Updated)

- Kali runs a modern **6.x monolithic kernel** with modular capability.
- LKMs expand kernel functionality without rebuilding.
- Unsigned module loading may be restricted on Secure Boot systems.
- `/etc/sysctl.d/*.conf` is **now the proper place** for permanent tuning.
- `modprobe`, `modinfo`, `lsmod` remain core kernel module tools.
- Kernel-level compromise = total system compromise.

---