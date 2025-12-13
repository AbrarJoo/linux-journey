# 5(managing file and directory permissions)

Status: Done

---

### **Different Types of Users in Linux**

- **Root user**:
    - Has **full control** over the system (superuser).
    - Can access, modify, and delete any file or configuration.
- **Regular users**:
    - Have **limited permissions**.
    - Are organized into **groups** (e.g., finance, engineering, developers, admins).
    - Each group shares similar access needs.
    - **Group permissions** simplify administration and improve security.
- **Root group**:
    - The root user belongs to this group by default.
    - Every new user must belong to at least one group to inherit permissions.

---

### **File Permissions**

Each file has **three types of permissions**:

| Permission | Symbol | Function |
| --- | --- | --- |
| Read | `r` | View/open the file |
| Write | `w` | Edit or modify the file |
| Execute | `x` | Run the file (execute programs/scripts) |

Permissions are assigned to:

1. **Owner (user)**
2. **Group**
3. **Others**

---

### **Ownership and Permission Management**

### **1. Granting Ownership to an Individual User**

- Command:
    
    ```bash
    chown username filename
    
    ```
    
- Example:
    
    ```bash
    chown bob /tmp/bobsfile
    
    ```
    
    → Transfers ownership of `bobsfile` to user **bob**.
    

---

### **2. Granting Ownership to a Group**

- Command:
    
    ```bash
    chgrp groupname filename
    
    ```
    
- Example:
    
    ```bash
    chgrp usecurity newIDS
    
    ```
    
    → Transfers group ownership of `newIDS` to group `**usecurity**.`
    

---

### **Checking Permissions**

- Use the **`ls -l`** command to view permissions, ownership, and group information.
    
    Example output:
    
    ```
    -rwxr-xr-- 1 bob usecurity 2048 Nov 12  newIDS
    
    ```
    
    - `rwx` → owner permissions
    - `r-x` → group permissions
    - `r--` → others’ permissions
    - `bob` → owner
    - `usecurity` → group

---

---

## **Checking Permissions in Linux**

### **Purpose**

- To view file or directory permissions, ownership, and other details.

---

### **Command**

```bash
ls -l [path]

```

- The `l` option stands for **long format**.
- Example:
    
    ```bash
    ls -l /usr/share/hashcat
    
    ```
    

---

### **Example Output**

```
drwxr-xr-x 5 root root 4096 Dec 5 10:47 charsets
-rw-r--r-- 1 root root 33685504 June 28 2018 hashcat.hcstat
drwxr-xr-x 2 root root 4096 Dec 5 10:47 masks

```

---

### **Understanding the Output**

Each line gives information about a file or directory:

| Symbol | Description |
| --- | --- |
| **u** | File type (`d` for directory, `-` for regular file) |
| **v** | Permissions for **owner**, **group**, and **others** |
| **w** | Number of links (advanced topic) |
| **x** | File owner |
| **y** | File size (in bytes) |
| **z** | Date/time last modified |
| **{** | File or directory name |

---

### **File Type**

- `d` → Directory
- → Regular file

---

### **Permission Structure**

Format:

```
[File Type][Owner Permissions][Group Permissions][Other Permissions]

```

Example:

```
-rw-r--r--

```

Breakdown:

| Segment | Meaning | Description |
| --- | --- | --- |
| `-` | File type | `-` = file, `d` = directory |
| `rw-` | Owner permissions | Read & write only |
| `r--` | Group permissions | Read only |
| `r--` | Others' permissions | Read only |

---

### **Meaning of Letters**

| Symbol | Permission | Description |
| --- | --- | --- |
| `r` | Read | View file contents |
| `w` | Write | Modify or delete the file |
| `x` | Execute | Run file (for scripts or programs) |
| `-` | No permission | Permission not granted |

---

### **Example Analysis**

```
-rw-r--r-- 1 root root 33685504 June 28 2018 hashcat.hcstat

```

| Part | Meaning |
| --- | --- |
| `-` | Regular file |
| `rw-` | Owner (root) can read & write |
| `r--` | Group (root) can read only |
| `r--` | Others can read only |
| `root root` | Owner and group are both root |
| `33685504` | File size in bytes |
| `hashcat.hcstat` | File name |

---

# Changing Permissions

---

### Who can change permissions

- **Only the file owner or root** may change a file’s permissions (using `chmod`).

---

### `chmod` — two common methods

1. **Numeric (octal) notation** — quick, compact
2. **Symbolic (UGO) notation** — explicit and readable

---

### Octal / binary mapping (one digit = one `rwx` set)

| Binary | Octal | `rwx` |
| --- | --- | --- |
| 000 | 0 | `---` |
| 001 | 1 | `--x` |
| 010 | 2 | `-w-` |
| 011 | 3 | `-wx` |
| 100 | 4 | `r--` |
| 101 | 5 | `r-x` |
| 110 | 6 | `rw-` |
| 111 | 7 | `rwx` |
- One octal digit represents **owner**, the second **group**, the third **others**.
- Example: `chmod 774 file` → owner `7` (`rwx`), group `7` (`rwx`), others `4` (`r--`).

---

### Examples (numeric)

- `chmod 774 hashcat.hcstat` → `rwxrwxr--`
- `chmod 766 newhackertool` → `rwxrw-rw-` (owner: all; group & others: `rw-`)

---

### UGO (symbolic) syntax

Format: `chmod [who][operator][perm] file`

- **who**: `u` = user(owner), `g` = group, `o` = others (you can combine, e.g. `ug`)
- **operator**: `+` add,  remove, `=` set exactly
- **perm**: `r`, `w`, `x`

Examples:

- `chmod u-w hashcat.hcstat` → remove write from owner
- `chmod u+x,o+x hashcat.hcstat` → add execute to owner and others
- `chmod g=r file` → set group permissions to read only

You can combine multiple changes in one command separated by commas:

- `chmod u+r,g-w,o=x filename`

---

### Typical workflow

1. Inspect current permissions: `ls -l filename`
2. Change permissions with `chmod` (numeric or symbolic)
3. Re-check with `ls -l` to confirm changes

---

### Notes on newly downloaded files

- By default (before `umask` adjustment) files are often created with permissive defaults (commonly described as `666` for files / `777` for directories).
- Downloaded files frequently **lack execute permission**, so you must `chmod` them to run (e.g., `chmod u+x file` or `chmod 766 file` if you want owner execute plus group/others write/read as in the example).

---

---

## **Setting More Secure Default Permissions with Masks (umask)**

### **Purpose**

- Controls **default permissions** automatically assigned to **new files and directories**.
- Helps make systems more **secure** by removing unnecessary permissions.

---

### **Base Permissions**

- Default Linux base permissions:
    - **Files:** `666` → read and write for everyone (no execute)
    - **Directories:** `777` → read, write, and execute for everyone

---

### **What is `umask`**

- **`umask` (User Mask)** defines which permissions to **remove** from the base permissions.
- It’s a **three-digit octal number**.
- Formula:
    
    ```
    New permissions = Base permissions − umask
    
    ```
    

---

### **Example: `umask` 022**

| Type | Base Permission | umask | Result | Meaning |
| --- | --- | --- | --- | --- |
| File | 666 | 022 | 644 | Owner: rw-, Group: r--, Others: r-- |
| Directory | 777 | 022 | 755 | Owner: rwx, Group: r-x, Others: r-x |
- So, **umask 022** means:
    - Owner: read & write (or execute for directories)
    - Group & others: read-only (or execute for directories)

---

### **Kali Linux / Debian Default**

- Default **umask = 022**
    - Files → `644`
    - Directories → `755`

---

### **Viewing and Changing umask**

- **Check current umask:**
    
    ```bash
    umask
    
    ```
    
- **Set a new umask temporarily (current session):**
    
    ```bash
    umask 007
    
    ```
    
    → Removes write and execute permissions for others (so only user & group have access).
    
- **Set umask permanently:**
    - Edit the user’s **profile file**:
        
        ```bash
        /home/username/.profile
        
        ```
        
    - Add line:
        
        ```bash
        umask 007
        
        ```
        
    
    → Applies automatically each time the user logs in.
    

---

### **Quick Summary Table**

| umask | File Perm | Dir Perm | Description |
| --- | --- | --- | --- |
| 000 | 666 | 777 | Full access for all |
| 022 | 644 | 755 | Default (secure for most systems) |
| 027 | 640 | 750 | Restricts others’ access |
| 077 | 600 | 700 | Only owner can access |
| 007 | 660 | 770 | Only user and group can access |

---

# Special Permissions

---

### Overview

Linux has three **special permission bits** in addition to the normal `rwx` sets:

- **SUID** (set user ID)
- **SGID** (set group ID)
- **Sticky bit** (legacy; used on directories)

---

### SUID — set user ID (temporary owner privileges)

- When **SUID** is set on a program, **any user executing that program runs it with the file owner’s privileges** (commonly used to let a program access root-owned resources).
- Typical use: password-change utilities that must read `/etc/shadow`.
- **Octal form:** prefix `4` (e.g., `chmod 4644 filename`).
- **`ls -l` representation:** an `s` in the owner-execute position (e.g., `rwsr-xr-x`).
    - Lowercase `s` means execute + SUID; uppercase `S` means SUID set but execute bit not set.
- **Security note:** misconfigured SUID programs are common privilege-escalation vectors for attackers.

---

### SGID — set group ID (temporary group privileges / directory behavior)

- **SGID on a file:** executing users run the program with the file’s **group** privileges.
- **SGID on a directory:** files **created inside** the directory inherit the **directory’s group**, not the creator’s group — useful for shared-group collaboration.
- **Octal form:** prefix `2` (e.g., `chmod 2644 filename`).
- **`ls -l` representation:** an `s` in the group-execute position (e.g., `rwxr-sr-x`).

---

### Sticky bit — legacy (directory use remains relevant)

- Historically used for executables; modern Linux ignores that legacy behaviour.
- On directories, the sticky bit is used to restrict **deletion/renaming of files**: only the file owner (or directory owner/root) can remove or rename files in that directory (common on `/tmp`).
- **Octal form:** prefix `1` (e.g., `chmod 1777 /tmp`).
- **`ls -l` representation on dirs:** `t` in the others-execute position (e.g., `drwxrwxrwt`).

---

### Finding files with SUID (example)

- To find root-owned files with SUID set:

```bash
find / -user root -perm -4000

```

- Example output often includes programs like `sudo`, `passwd`, `pkexec`, etc.
- After locating, inspect with `ls -l` to confirm the `s` in the permission string.

---

### Practical security advice (summary)

- Audit SUID/SGID files regularly — they are attractive targets for privilege escalation.
- Minimize SUID/SGID program usage; only set them when absolutely necessary.
- For shared directories, prefer **SGID on the directory** (not individual files) to ensure consistent group ownership of new files.

---

Would you like me to merge these special-permissions notes with the previous sections into a single **one-page cheat sheet** or a full **study PDF**?