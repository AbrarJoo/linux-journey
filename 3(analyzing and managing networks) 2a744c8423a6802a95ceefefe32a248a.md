# 3(analyzing and managing networks)

Status: Done

# 

---

## IP Addresses (Internet Protocol)

IP addresses are the backbone of digital communication, enabling email, video chat, browsing, and all online activities. Every device (computer, laptop, phone, tablet) receives an IP address to communicate with other devices.

## Public vs Private IP Addresses

The IPv4 system has only 4.3 billion addresses—insufficient for 8+ billion people with multiple devices. To address this:

- **Private IP addresses**: Reusable within local networks (LANs), cannot access the internet
- **Common private ranges**: 192.168.x.x, 10.x.x.x, 172.16.x.xyoutube
- **NAT (Network Address Translation)**: Translates private IPs to public IPs for internet

The NAT device maintains a table mapping internal IPs to external IPs, seamlessly handling the translation without user 

## DHCP (Dynamic Host Configuration Protocol)

DHCP dynamically assigns IP addresses to devices joining a network rather than using fixed addresses. When a device connects to a LAN:

1. DHCP client sends a broadcast request for an IP 
2. DHCP server assigns an IP from its pool for a specific lease period
3. Each connection typically receives a different dynamic IP within the same 

## TCP (Transmission Control Protocol)

TCP is a connection-oriented protocol that ensures reliable data delivery.

## TCP Header Fields

**Important for hackers and forensics**

- **Source/Destination Ports**: Show communication endpoints
- **Sequence Number**: Ensures correct packet order and prevents man-in-the-middle attacks
- **Acknowledgement Number**: Confirms packet receipt; no ACK triggers retransmission
- **Window Size**: Manages buffering and flow control; useful for OS fingerprinting (80% accuracy)

## TCP Flags

Critical for reconnaissance with tools like `nmap` or `hping3`

- **SYN**: Initiates new connection
- **ACK**: Acknowledges packet receipt
- **FIN**: Normal connection close
- **RST**: Hard close/error communication
- **URG**: Marks urgent data
- **PSH**: Directs data past buffer to application

## Three-Way Handshake

1. **SYN**: Client initiates connection ("Hello, I want to talk")
2. **SYN-ACK**: Server acknowledges and responds ("I'm ready)
3. **ACK**: Client confirms ("Let's proceed")

## UDP (User Datagram Protocol)

UDP is a connectionless, lightweight protocol that prioritizes speed over reliability.

**Key characteristics**:

- No connection setup (no handshake)
- No delivery confirmation
- Faster than TCP
- Perfect for streaming, gaming, VoIP where occasional packet loss is acceptable

**Common UDP protocols**: DNS, SNMP, NTP

## ARP (Address Resolution Protocol)

ARP translates logical IP addresses to physical MAC addresses on Ethernet networks.

## How ARP Works

1. Computer 1 checks its ARP table for Computer 2's MAC address
2. If not found, broadcasts "Who has this IP address?"
3. Computer 2 responds with its MAC address
4. Computer 1 updates its ARP table and sends the message

## Security Concerns

- **Lacks authentication**: Vulnerable to exploitation
- **Man-in-the-middle attacks**: Attackers can manipulate ARP messages
- **Network discovery**: Tools like `netdiscover` on Kali use gratuitous ARP requests to map all network systems

## DNS (Domain Name System)

DNS translates human-readable domain names ([www.google.com](http://www.google.com/)) into IP addresses.

## Security Vulnerabilities

Historical fragility has improved, but attacks still occur

- **DNS scanning/reconnaissance**: Harvesting domain names and IPs from target DNS servers
- **DNS spoofing**: Using tools like `dnsspoof` to redirect traffic to malicious sites (e.g., fake banking pages)

## FTP (File Transfer Protocol)

FTP is a client-server protocol for file transfers over networks.

**Features**:

- Uses two channels: command channel (control) and data channel (file transfer)
- Supports download, upload, edit, copy, delete operations
- Still common for private/secure file sharing (banking, secure environments)
- Declining for public use due to HTTP prevalence

## SMB (Server Message Block)

SMB enables computers to share files, printers, and resources over LANs

**How it works**

- Clients connect to servers via TCP/IP or NetBIOS
- Access shared folders, read/write files, use shared printers

## Critical Security Issue

SMB (Windows) and Samba (Linux/Unix) have historically been major vulnerability sources. Attackers can:

- Send specially crafted packets to exploit SMB services
- Execute remote code with system privileges
- Gain full control of vulnerable systems

## SMTP (Simple Mail Transfer Protocol)

SMTP handles email transmission between users, first standardized in 1983. It acts as the internet's "postal service" for email delivery.[geeksforgeeks+1](https://www.geeksforgeeks.org/computer-networks/what-are-the-differences-between-http-ftp-and-smtp/)youtube

## SNMP (Simple Network Management Protocol)

SNMP manages and monitors computers and network devices

## Why It's Dangerous

SNMP is often overlooked but critical—making it a prime attack target:

- **Breach consequences**: Access to comprehensive network information
- **Decrypt VPN traffic**: Eavesdrop on sensitive communications
- **Device manipulation**: View and control every network device
- **Operates on**: UDP ports 161 and 162youtube

Attackers with SNMP access can harvest sensitive data, disrupt operations, or control critical infrastructure like routers and switches.

## Telnet

Telnet enables remote connectivity and login to host machines from remote endpoints.

## Why It's Obsolete

- **Security flaw**: Transmits all data (including credentials) in plain text
- **Replaced by**: SSH (Secure Shell) with encryption and stronger authentication
- **Origins**: Developed in the 1960s, unsuitable for modern security needs

## HTTP (Hypertext Transfer Protocol)

HTTP is the foundation of web communication, enabling client-server interactions for web applications.

**Characteristics**

- Message-based model (request-response cycle)
- Connectionless (each request establishes and closes connection)
- Uses TCP for reliable transmission
- Originally for static pages, now supports complex web applications

# Analyzing Networks with `ip`

## Purpose

`ip` is a modern Linux tool for examining and interacting with active network interfaces. Use it to view interface state, IP configuration, MAC addresses, and basic link information. It replaces the older `ifconfig` command.

## Quick command

```bash
ip addr show

```

Run as a normal user to view configured interfaces. Use `sudo` if you need elevated output or to change settings.

## Typical output (shortened)

```
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:c0:ca:3f:ee:02 brd ff:ff:ff:ff:ff:ff
    inet 192.168.181.131/24 brd 192.168.181.255 scope global dynamic eth0

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo

```

## Fields explained

- **Interface name** (`eth0`, `lo`, `wlan0`): the logical label for each network device. Linux starts counting at 0.
- **state flags**: e.g., `UP` (interface enabled), `LOWER_UP` (link active), `BROADCAST`, `MULTICAST`.
- **mtu**: Maximum Transmission Unit — largest packet size the interface will send.
- **inet**: IPv4 address assigned to the interface (with CIDR notation, e.g., `/24`).
- **brd**: broadcast address for the subnet — used to send packets to every host on the subnet.
- **link/ether** / **MAC address**: the physical, globally unique hardware address of the NIC.
- **lo (loopback)**: special software interface (127.0.0.1) used for local inter-process network testing.

## How to read the IP/netmask/broadcast

- IP: identifies the host on the subnet (e.g., `192.168.181.131`).
- Netmask: shown in CIDR notation (e.g., `/24` = `255.255.255.0`).
- Broadcast: highest address in the subnet used for broadcasting (e.g., `192.168.181.255`).

## Common `ip` actions (examples)

- Show all interfaces: `ip addr show` or `ip link show`
- Bring interface up: `sudo ip link set eth0 up`
- Bring interface down: `sudo ip link set eth0 down`
- Assign an IP temporarily: `sudo ip addr add 192.168.1.50/24 dev eth0`

> Note: Changes made with ip are not persistent across reboots; to persist, edit your distro's network configuration files or use network managers.
> 

## Quick troubleshooting checklist

- If interface missing: check `ip link show` and `dmesg` for driver errors.
- If no IP: run `dhclient <interface>` or check DHCP server.
- If link down: verify cables, wireless adapter power, or driver.

## Useful companion commands

- `ip route` — show routing table and default gateway.
- `ip neigh` — view ARP table (mapping IP ⇄ MAC).
- `ping`, `traceroute` — test connectivity.

## Practical tips

- Remember `lo` is local only — external systems can't reach it.
- The MAC (`link/ether`) is useful when filtering or creating DHCP reservations.
- `ip` output is more detailed and modern than `ifconfig`.

---

# Checking Wireless Network Devices with `iwconfig` — Concise Notes

## Purpose

`iwconfig` displays wireless-specific information for network interfaces. Use it to identify wireless-capable interfaces, view their mode, ESSID, association status, and transmit power.

## Quick command

```bash
iwconfig

```

Run without arguments to list wireless-capable interfaces and their settings.

## Typical output (shortened)

```
wlan0     IEEE 802.11bg  ESSID:off/any
Mode:Managed  Access Point: Not-Associated  Tx-Power=20 dBm
lo        no wireless extensions
eth0      no wireless extensions

```

## Fields explained

- **Interface name** (`wlan0`): the wireless device logical name.
- **IEEE 802.11bg**: the 802.11 standards the device supports (b, g, `n`, a, etc.).
- **ESSID**: the network name (SSID). `off/any` means the adapter is not connected to a specific network and will accept any.
- **Mode**: operating mode, e.g., `Managed` (normal client), `Master` (AP), `Monitor` (passive capture), `Ad-Hoc` (peer-to-peer). Note: changing modes affects how the radio operates.
- **Access Point**: the BSSID/MAC of the associated AP; `Not-Associated` means not connected.
- **Tx-Power**: transmit power reported in dBm — higher values increase range but may be regulated or limited by hardware.
- **no wireless extensions**: indicates the interface does not support wireless functions (typical for loopback and wired NICs).

## How to interpret

- If only one interface shows wireless info (`wlan0`), all wireless activity will go through it.
- `Mode:Managed` is normal client operation; `Mode:Monitor` is used for passive capture and diagnostics.
- `Not-Associated` means the adapter is not connected to any AP — useful when troubleshooting connection issues.

## Troubleshooting checklist

- If an expected wireless interface does not appear: verify drivers and check `dmesg` or `rfkill list` for blocked radios.
- If ESSID shows `off/any` but you expect to be connected: confirm network manager settings or DHCP status.
- If Tx-Power is low: check regulatory settings and power management (driver/hardware may limit power).

## Useful companion commands

- `ip link` — view link/operational state of interfaces.
- `iw list` — detailed capabilities of the wireless device (supported channels, modes, features).
- `iw dev` — modern tool to show wireless device info and interfaces.
- `rfkill list` — check for soft/hard blocks on wireless radios.
- `iwlist <iface> scan` — scan for nearby networks; may require appropriate permissions.

## Safety & ethics note

These commands reveal and help manage wireless hardware and links. Use them for legitimate administration, troubleshooting, or learning. Avoid using them to access or interfere with networks you do not own or have explicit permission to test.

---

# Changing Your Network Information

## Overview

Using `ip` (and companion tools) you can temporarily change IP addresses, netmasks, broadcast addresses, and spoof MAC addresses. These changes are powerful for administration and testing, but can be misused — always have authorization before altering network identity or accessing networks.

## Changing your IP address (temporary)

```bash
sudo ip addr add 192.168.181.115/24 dev eth0

```

- The command silently returns to prompt on success.
- Changes are immediate but **not persistent** across reboots.

## Changing netmask and broadcast

```bash
sudo ip addr add 192.168.181.115/16 broadcast 192.168.1.255 dev eth0

```

- Verify with `ip addr show` afterwards to confirm values.

## Spoofing (changing) your MAC address

```bash
sudo ip link set dev eth0 down
sudo ip link set dev eth0 address 00:11:22:33:44:55
sudo ip link set dev eth0 up

```

- Check `ip link show` to confirm MAC changed.
- Note: some drivers or network managers may override spoofed MACs; check for persistent MAC settings.

## Requesting a new DHCP-assigned IP

```bash
sudo nmcli device connect eth0

```

- DHCPDISCOVER and negotiates an address (DHCPOFFER → DHCPREQUEST → DHCPACK).

## Practical & ethical notes

- **Persistence:** Changes via `ip` are temporary. To make permanent changes, update your distribution's network config or NetworkManager settings.
- **Detection & forensics:** DHCP logs and MAC address history can help trace devices. Spoofing IP/MAC can hinder traceability but may be illegal or unethical without permission.
- **Alternatives:** `ip` (from iproute2) offers more features (e.g., `ip addr add/del`, `ip link set`).

---

# DNS Manipulation & Network Reconnaissance - Study Notes

## DNS Fundamentals

- **Purpose**: Translates domain names (e.g., hackers-arise.com) to IP addresses
- **Why it matters**: Without DNS, we'd need to memorize thousands of IP addresses
- **Linux DNS**: Most common is BIND (Berkeley Internet Name Domain) - DNS and BIND are often used interchangeably

---

## The `dig` Command - DNS Reconnaissance

### Basic Syntax & Purpose

- **dig** = Domain Information Groper
- Used for DNS reconnaissance and gathering target information
- Reveals: nameservers, email servers, subdomains, IP addresses

### Getting Nameserver Information

```bash
dig hackers-arise.com ns

```

**Output sections:**

- **QUESTION SECTION**: Shows your query
- **ANSWER SECTION**: Lists the nameservers (e.g., ns7.wixdns.net)
- **ADDITIONAL SECTION**: May reveal IP addresses of DNS servers

### Getting Mail Server Information

```bash
dig hackers-arise.com mx

```

**Purpose**: Critical for planning email system attacks

**Output**: Shows mail exchange (MX) server in AUTHORITY SECTION

---

## Changing DNS Servers

### Method 1: Edit `resolv.conf` File

```bash
leafpad /etc/resolv.conf

```

- File location: `/etc/resolv.conf`
- Default: Points to local DNS (e.g., 192.168.181.2)
- Add line: `nameserver 8.8.8.8` (for Google's public DNS)

### Method 2: Command Line

```bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf

```

**Warning**: This **replaces** all current content (use `>` redirect)

### Best Practice

- **Keep multiple DNS servers** in `resolv.conf`
- System queries in order listed
- Local DNS first (faster), public DNS as backup
- **DHCP caveat**: DHCP servers may overwrite this file when renewing addresses

---

## The Hosts File - Local DNS Override

### Location & Purpose

- **Path**: `/etc/hosts`
- **Function**: Manual IP-to-domain mapping that overrides DNS
- **Use case**: Redirect traffic locally, hijack connections

### Editing the Hosts File

```bash
leafpad /etc/hosts

```

### Default Content

```
127.0.0.1    localhost
127.0.1.1    kali

```

### Adding Custom Mappings

```
192.168.181.131    bankofamerica.com

```

**Important**: Use TAB (not spacebar) between IP and domain

### Hacking Applications

- Works with tools like **dnsspoof** and **Ettercap**
- Can redirect LAN traffic to malicious servers
- Example: Redirect bankofamerica.com traffic to your local web server
- Enables man-in-the-middle attacks on local networks

---

## Key Security Insights

**For Hackers:**

- DNS provides reconnaissance treasure trove
- Early-stage information gathering before attacks
- Hosts file enables traffic hijacking on LANs

**For Defenders:**

- Monitor DNS queries for reconnaissance attempts
- Secure DNS infrastructure (nameservers, MX records)
- Be aware of hosts file manipulation
- Watch for DNS spoofing attacks

---

## Quick Reference Commands

| Command | Purpose |
| --- | --- |
| `dig domain.com ns` | Get nameserver info |
| `dig domain.com mx` | Get mail server info |
| `leafpad /etc/resolv.conf` | Edit DNS server settings |
| `leafpad /etc/hosts` | Edit local DNS mappings |
| `echo "nameserver IP" > /etc/resolv.conf` | Change DNS via command line |

---

# 

---

# 🔍 Linux ARP Command Reference

## What is ARP?

**Address Resolution Protocol (ARP)** maps IP addresses to MAC (hardware) addresses on a local network.

---

## 📋 Basic Syntax

`arp [options] [hostname]`

---

## 🔧 Common Commands

## View ARP Cache

| Command | Description | Example Output |
| --- | --- | --- |
| `arp` | Display all ARP entries (default format) | Shows hostname, MAC, interface  |
| `arp -a` | Show all entries (BSD style) | Displays all entries including incomplete |
| `arp -e` | Show entries (Linux style) | Default Linux format  |
| `arp -n` | Display numeric IPs (no DNS lookup) | Shows IP instead of hostname |
| `arp -v` | Verbose mode | Extra details + function calls  |
| `arp -i eth0` | Show entries for specific interface | Filter by network interface  |

---

## Add ARP Entry

`bashsudo arp -s <IP_ADDRESS> <MAC_ADDRESS>`

**Example:**

`bashsudo arp -s 192.168.6.100 10:99:90:BE:E1:00`

**Options:**

- `s` = Set/add static entry
- Requires root/sudo permissions

---

## Delete ARP Entry

`bashsudo arp -d <IP_ADDRESS>`

**Example:**

`bashsudo arp -d 192.168.1.1`

---

## Bulk Operations

**Load from file:**

`bashsudo arp -f /path/to/file`

**Default file:** `/etc/ethers`

**File format:**

`textIP_ADDRESS MAC_ADDRESS [temp,pub] [netmask NETMASK]`

---

## 🏷️ ARP Table Flags

| Flag | Meaning |
| --- | --- |
| `C` | Complete entry (response received) |
| `M` | Permanent/static entry  |
| `P` | Published entry (proxy ARP)  |

---

## ⚠️ Important Notes

- **Deprecated tool**: `arp` is part of the old `net-tools` package
- **Modern alternative**: Use `ip neigh` or `ip neighbour` command instead
- **Requires sudo**: Adding/deleting entries needs root permissions

---

## 🆕 Modern Replacement

`bash*# View ARP cache*
ip neigh show

*# Add entry*
ip neigh add <IP> lladdr <MAC> dev <interface>

*# Delete entry*
ip neigh del <IP> dev <interface>`

---

## 🎯 Use Cases

✅ Network troubleshooting & connectivity issues

✅ Verify IP-to-MAC mappings

✅ Security testing & network discovery

✅ Create static mappings for critical devices\

---