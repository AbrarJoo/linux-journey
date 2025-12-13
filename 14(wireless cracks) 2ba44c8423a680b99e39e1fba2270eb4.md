# 14(wireless cracks)

Status: In progress

---

## 📡 **Wi-Fi & Bluetooth Scanning – Summary Notes**

Scanning & inspecting wireless networks is useful for ethical hacking, cybersecurity, and securing devices. To do any Wi-Fi security testing, you must first be able to **find, identify, and analyze network devices**.

---

## 🔑 Basic Wi-Fi Terms

| Term | Meaning |
| --- | --- |
| **AP (Access Point)** | Device people connect to for internet (router/hotspot). |
| **SSID** | Network name shown to users. |
| **ESSID** | Same as SSID but can represent multiple APs on same network. |
| **BSSID** | MAC address of the AP (unique identifier). |
| **Channels** | Wi-Fi operates on channels (1–14). US commonly uses 1–11. |
| **Frequency Bands** | 2.4GHz & 5GHz (modern APs may use both). |
| **Modes** | Managed (connect to AP), Master (AP mode), Monitor (packet capture). |
| **Security Types** | WEP (weak), WPA (better), WPA2-PSK (common & secure). |

---

## 📍 Range & Power

- Normal AP range ≈ **100m (~300ft)**
- High-gain antennas can reach **many kilometers/miles**

---

## 🖥 Useful Linux Commands for Wi-Fi

| Command | Purpose |
| --- | --- |
| `ifconfig` | Shows all network interfaces (IP, status, etc). |
| `iwconfig` | Shows only wireless interfaces & settings. |
| `iwlist wlan0 scan` | Scans and lists nearby Wi-Fi access points. |
| `nmcli dev wifi` | Lists APs with details (channel, speed, security). |
| `nmcli dev wifi connect "SSID" password "PASS"` | Connects to a Wi-Fi network. |

---

### Example `iwconfig` Output Breakdown

| Field | Meaning |
| --- | --- |
| ESSID | The Wi-Fi network currently connected to. |
| Mode | Whether adapter is Managed/Master/Monitor. |
| Frequency | 2.4GHz / 5GHz band used. |
| Access Point | MAC address of AP connected to. |
| Link Quality / Signal | Strength of the connection. |

---

## 🔍 Wi-Fi Reconnaissance with Aircrack-NG Tools

**Goal:** Collect information about networks & clients (for *legal security testing only*).

Before scanning traffic, set adapter to **Monitor Mode**:

```
airmon-ng start wlan0

```

→ Your interface becomes something like: `wlan0mon`

---

### Scan Wireless Traffic

```
airodump-ng wlan0mon

```

You’ll see:

| Field | Meaning |
| --- | --- |
| **BSSID** | MAC of AP |
| **PWR** | Signal strength |
| **CH** | Channel number |
| **ENC** | Encryption type (WEP/WPA/WPA2) |
| **ESSID** | Network name |

---

## ⚠️ WPA/WPA2 Password Cracking (Ethical Use Only)

Cracking Wi-Fi requires:

✔ BSSID (router MAC)

✔ Client MAC

✔ Channel

✔ Packet capture + handshake

✔ Wordlist

Steps (educational reference only):

1. Capture AP data:

```
airodump-ng -c <channel> --bssid <AP_MAC> -w output wlan0mon

```

1. Force device re-auth to capture handshake:

```
aireplay-ng --deauth 100 -a <AP_MAC> -c <CLIENT_MAC> wlan0mon

```

1. Attempt password crack using wordlist:

```
aircrack-ng -w wordlist.txt -b <AP_MAC> output.cap

```

🔴 Must only be done on *your own network or with permission*.

---

### 

---

# 🔵 **Bluetooth Security — Detecting & Connecting (Summary Notes)**

Modern devices — phones, laptops, controllers, speakers, wearables — all use Bluetooth.

Understanding how to **detect, scan, and analyze Bluetooth devices** is the first step in securing them or testing them in a legal environment.

---

## 🔹 What is Bluetooth?

| Feature | Description |
| --- | --- |
| Frequency | 2.4 GHz – 2.485 GHz |
| Security Method | **Frequency hopping** at 1,600 hops/sec |
| Range | Typically 10 m, sometimes 100 m+ |
| Purpose | Short-range, low-power communication |
| Origin | Ericsson (1994), named after King *Harald Bluetooth* |

Bluetooth devices connect through a process called **pairing**.

During pairing they exchange a **link key** — stored for automatic reconnection.

Each device has:

✔ Unique 48-bit MAC-like address

✔ Device name (manufacturer-assigned)

✔ Service list (e.g., audio, file transfer, tethering)

---

# 🔍 Bluetooth Reconnaissance (Ethical + Legal Use Only)

Linux uses **BlueZ**, the official Bluetooth stack.

If missing, install:

```
apt-get install bluez

```

---

## **1. Identify & Enable Bluetooth Interface**

| Command | Purpose |
| --- | --- |
| `hciconfig` | Shows Bluetooth interface, specs & status |
| `hciconfig hci0 up` | Enables the interface |

Output example:

```
hci0: MAC: 10:AE:60:58:F1:37  STATUS: RUNNING

```

---

## **2. Scan for Nearby Devices**

### 🔸 Discover devices in pairing/visible mode

```
hcitool scan

```

Outputs device names + MAC addresses.

### 🔸 Deeper info scan

```
hcitool inq

```

Shows:

- MAC

• Clock offset

• Device class (type of device)

Use Bluetooth SIG website to decode device class.

---

## **3. Scan Device Services (without needing discoverable mode)**

```
sdptool browse <MAC>

```

Reveals supported services & protocols (e.g., audio, HID, BLE, tethering).

This helps identify capabilities + potential interaction paths.

---

## **4. Check if Device is Reachable**

```
l2ping <MAC> -c <packet_count>

```

If packets return → device is active and in range.

Useful before doing any legal testing.

---

# 🧠 Key Takeaways

| Tool | Use |
| --- | --- |
| **hciconfig** | Manage Bluetooth adapter (view, enable) |
| **hcitool** | Scan, inquire device details |
| **sdptool** | View services on a target device |
| **l2ping** | Test if device is reachable |

---

Wireless technologies (Wi-Fi + Bluetooth) are powerful — and so are the tools designed to test their security.

Use them **only on devices/networks you own or have explicit permission to test.**

---

## .