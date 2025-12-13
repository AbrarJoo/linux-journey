# 13(security and anonimity)

Status: Done

---

## 📌 **Notes – Becoming Secure & Anonymous Online**

---

### **1. Tor Browser**

- Routes traffic through multiple encrypted relays.
- Final exit node knows destination → weak point.
- Vulnerable to **traffic correlation attacks** by agencies (NSA, etc.).
- Still good for hiding identity from corporations (Google, ads).
- May not fully protect from advanced surveillance agencies.
- Often slow due to multi-node routing.

---

### **2. Proxy Servers**

- Works as an intermediary: user → proxy → destination.
- Proxy IP appears instead of your real IP.
- Logs may exist; law enforcement can access them with warrants.
- **Proxy Chains** (multiple proxies) = harder to trace.
- Kali Linux tool: **proxychains**

### Command format:

```
proxychains <command> <arguments>

```

Example (anonymous nmap scan):

```
proxychains nmap -sT -Pn <IP>

```

---

### **3. Configuring ProxyChains**

File location:

```
/etc/proxychains.conf

```

Default config uses **Tor (127.0.0.1:9050)** unless replaced.

### Adding proxies:

Format:

```
<type> <IP> <port>

```

Example:

```
socks4 114.134.186.12 22020
socks4 188.187.190.59 8888

```

---

### **4. ProxyChaining Modes**

Only one mode active at a time.

| Mode | Behavior |
| --- | --- |
| **strict_chain** | All proxies used, all must be online |
| **dynamic_chain** | Uses proxies in order, skips dead ones |
| **random_chain** | Random proxy selection each run |

For random chaining, configure:

```
random_chain
chain_len = X

```

Higher anonymity but more latency.

---

### **5. Proxy Security Concerns**

- Free proxies often unsafe (log/sell data).
- Paid private proxies recommended.
- Proxy owner can reveal identity under pressure.
- No anonymity method is 100% secure.

---

### **6. VPN (Virtual Private Network)**

- Encrypts traffic between you and VPN server.
- ISP and outsiders cannot view your activity.
- Traffic appears from VPN server IP.
- VPN provider still knows your original IP.

Best VPNs (as listed):

- NordVPN
- ExpressVPN
- IPVanish
- CyberGhost
- Private Internet Access
- PureVPN, etc.

❗ Choose VPN providers with **no-log policy**.

---

### **7. Encrypted Email**

- Standard services (Gmail, Yahoo, Outlook) scan emails for data/ads.
- **ProtonMail** → end-to-end encrypted + Swiss privacy laws.
- Emails to non-ProtonMail addresses may not stay fully encrypted.

---

### **8. Key Takeaways**

- Online activity is constantly monitored.
- Use **Tor**, **VPN**, **proxychains**, **encrypted mail** for privacy.
- Layering methods increases anonymity.
- No tool guarantees absolute protection, but combined usage reduces traceability significantly.

---