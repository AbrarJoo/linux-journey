# 4(adding and removing software)

Status: Done

---

## 🧰 **Using APT to Handle Software (Debian, Ubuntu, Kali)**

### 1. **APT Overview**

- **APT (Advanced Packaging Tool)** is the default software manager for Debian-based systems.
- **Primary command:** `apt-get`
- **Alternate command:** `apt` (simpler, but `apt-get` has more functionality)

---

### 2. **Searching for a Package**

- Used to check if a package is available in the repository.
- **Command syntax:**
    
    ```bash
    apt-cache search keyword
    
    ```
    
- Example:
    
    ```bash
    apt-cache search snort
    
    ```
    
- Searches the APT cache and lists packages related to the keyword.

---

### 3. **Installing Software**

- **Command syntax:**
    
    ```bash
    apt-get install packagename
    
    ```
    
- Example:
    
    ```bash
    apt-get install snort
    
    ```
    
- Prompts for confirmation `[Y/n]` before installing.
- Installs the package and any required dependencies.

---

### 4. **Removing Software**

- **Command syntax:**
    
    ```bash
    apt-get remove packagename
    
    ```
    
- Removes the software but **keeps configuration files**.
- To remove configuration files as well:
    
    ```bash
    apt-get purge packagename
    
    ```
    
- **Example:**
    
    ```bash
    apt-get remove snort
    apt-get purge snort
    
    ```
    

---

### 5. **Removing Unused Dependencies**

- After removing a package, clean up unnecessary libraries:
    
    ```bash
    apt autoremove
    
    ```
    
- Deletes dependencies that are no longer required.

---

### 6. **Updating Repositories**

- **Command syntax:**
    
    ```bash
    apt-get update
    
    ```
    
- Updates the **list of available packages** from repositories.
- Does **not** upgrade installed packages.

---

### 7. **Upgrading Packages**

- **Command syntax:**
    
    ```bash
    apt-get upgrade
    
    ```
    
- Upgrades **all installed packages** to the latest versions available in the repository.
- Must be **run as root**.
- May require significant disk space and time.

---

### 8. **Key Differences**

| Action | Command | Description |
| --- | --- | --- |
| Search | `apt-cache search` | Find available packages |
| Install | `apt-get install` | Download & install software |
| Remove | `apt-get remove` | Uninstall software, keep config |
| Purge | `apt-get purge` | Uninstall + delete configs |
| Clean deps | `apt autoremove` | Remove unused dependencies |
| Update list | `apt-get update` | Update package index |
| Upgrade | `apt-get upgrade` | Upgrade installed packages |

---

# Adding Repositories & Alternate Install Methods (Kali / Debian-based)

**Overview**

- Repositories (servers) host distro-specific packages. Different distributions’ repos may contain different software and versions.
- Kali uses its own repos (security-focused). Adding other compatible repos (e.g., Ubuntu/Debian) can provide packages not available in Kali.

**sources.list**

- File: `/etc/apt/sources.list`
- Edit with any text editor (example):
    
    ```bash
    sudo leafpad /etc/apt/sources.list
    
    ```
    
- Add repository lines to let `apt` search additional sources.
- Example PPA entries (for Oracle Java 8 via WebUpd8):
    
    ```
    deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
    deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main
    
    ```
    
- Advice: avoid `testing`, `experimental`, or `unstable` repos unless you need them — they can break the system.

**Repository categories (Debian-style)**

- `main` — supported open-source software
- `universe` — community-maintained OSS
- `multiverse` — restricted-by-license software
- `restricted` — proprietary drivers
- `backports` — packages from later releases

**How apt chooses packages**

- When installing, `apt` searches listed repos and selects the most recent compatible version.
- Ensure any repo you add is compatible with your system (Kali is Debian-based; Ubuntu/Debian repos often work but check compatibility).

**GUI-based installers**

- Kali may not include GUI package managers by default. Common options:
    - **Synaptic** — full-featured package manager
        
        ```bash
        sudo apt-get install synaptic
        synaptic   # start it
        
        ```
        
    - **GDebi** — useful for installing local `.deb` files
- Synaptic workflow: Search → check package → Apply → install dependencies automatically.

**Installing from git / GitHub**

- If package not in repos, it may be on GitHub.
- Clone repository:
    
    ```bash
    git clone https://www.github.com/username/repo.git
    
    ```
    
    Example:
    
    ```bash
    git clone https://www.github.com/balle/bluediving.git
    
    ```
    
- After clone: `ls -l` to verify directory and files.
- Note: software from git often requires building/install steps (read the repo README for install instructions).

**Practical tips**

- Back up `sources.list` before editing:
    
    ```bash
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    
    ```
    
- After adding repos, run:
    
    ```bash
    sudo apt-get update
    
    ```
    
    to refresh package lists before installing.
    
- Prefer stable, well-maintained repos for security/stability.

---

Would you like these turned into a printable one-page cheat-sheet (PDF)?