# 9(compressing and archivin)

Status: Done

---

# 📘 **Compression & Archiving**

## 🔹 **What is Compression?**

- Compression reduces the size of data to save storage and make transmission easier.
- Two types:
    - **Lossy:**
        - Smaller file size but loses some data.
        - Used for media: `.mp3`, `.mp4`, `.jpg`.
    - **Lossless:**
        - No data loss.
        - Used for software, scripts, documents.
        - All Linux compression utilities in this chapter are **lossless**.

---

# 📦 **TAR — Archiving Files (not compression)**

**tar = tape archive**

Used to combine multiple files into a single archive (a “tarball”).

### **Key Commands**

| Action | Command | Notes |
| --- | --- | --- |
| Create tar | `tar -cvf archive.tar file1 file2` | `c`=create, `v`=verbose, `f`=filename |
| List contents | `tar -tvf archive.tar` | `t`=list |
| Extract files | `tar -xvf archive.tar` | `x`=extract |
| Extract silently | `tar -xf archive.tar` | no verbose |

Note: Tar **increases size** slightly due to overhead.

---

# 🗜️ **Compressing TAR Files**

## 1️⃣ **gzip**

- Commonly used.
- Output: `.tar.gz` or `.tgz`
- Medium speed, medium compression ratio.

### Commands:

- **Compress:**
    
    `gzip filename.tar`
    
- **Decompress:**
    
    `gunzip filename.tar.gz`
    

Resulting file replaces original.

---

## 2️⃣ **bzip2**

- Better compression than gzip.
- Slower.
- Output: `.tar.bz2`

### Commands:

- **Compress:**
    
    `bzip2 filename.tar`
    
- **Decompress:**
    
    `bunzip2 filename.tar.bz2`
    

---

## 3️⃣ **compress**

- Oldest and least efficient.
- Fast but poor compression.
- Output: `.tar.Z`

### Commands:

- **Compress:**
    
    `compress filename.tar`
    
- **Decompress:**
    
    `uncompress filename.tar.Z`
    
    (or `gunzip filename.tar.Z`)
    

---

# 📂 **zip and unzip — EXTRA NOTES (as you requested)**

Unlike tar, **zip both archives AND compresses** at the same time.

## 🔹 **zip Command**

**Basic syntax:**

```
zip [options] zipfile.zip file1 file2 dir1 ...

```

### **Common Options**

| Option | Description |
| --- | --- |
| `-r` | Recursively zip directories |
| `-9` | Maximum compression |
| `-0` | No compression (store only) |
| `-e` | Encrypt zip with password |
| `-P password` | Provide password in command (not secure) |
| `-q` | Quiet mode |
| `-u` | Update zip (add newer files only) |
| `-d` | Delete a file inside zip |
| `-m` | Move files into zip (remove originals) |

### **Examples**

- Zip files into archive:
    
    ```
    zip archive.zip file1 file2
    
    ```
    
- Zip directory:
    
    ```
    zip -r project.zip project_folder/
    
    ```
    
- Maximum compression:
    
    ```
    zip -9 archive.zip myfile
    
    ```
    
- Encrypted ZIP:
    
    ```
    zip -e secrets.zip secret.txt
    
    ```
    

---

## 🔹 **unzip Command**

**Basic syntax:**

```
unzip [options] file.zip

```

### **Common Options**

| Option | Description |
| --- | --- |
| `-l` | List contents without extracting |
| `-v` | Verbose listing |
| `-q` | Extract quietly |
| `-d directory` | Extract to specific directory |
| `-t` | Test zip file integrity |
| `-o` | Overwrite existing files |
| `-n` | Never overwrite existing files |

### **Examples**

- Extract zip:
    
    ```
    unzip archive.zip
    
    ```
    
- Extract to a directory:
    
    ```
    unzip archive.zip -d output_folder
    
    ```
    
- List contents:
    
    ```
    unzip -l archive.zip
    
    ```
    
- Test a zip file:
    
    ```
    unzip -t archive.zip
    
    ```
    

---

# 🖥️ **dd Command — Bit-by-Bit Copy**

Used to create **physical copies** of storage devices (forensics).

### **Syntax**

```
dd if=input of=output

```

### **Example**

Copy USB drive (`/dev/sdb`) to file:

```
dd if=/dev/sdb of=/root/flashcopy

```

### Useful Options

| Option | Description |
| --- | --- |
| `bs=4096` | Set block size (faster) |
| `conv=noerror` | Continue on read errors |
| `status=progress` | Show progress (depending on OS) |

Example using options:

```
dd if=/dev/sdb of=/root/flashcopy bs=4096 conv=noerror

```

---

# ✅ **Summary**

- **tar** → combine files
- **gzip, bzip2, compress** → compress tar archives
- **zip/unzip** → archive + compress together
- **dd** → forensic tool for physical disk copies