# 2 (text manipulation)

Status: Done

# ***Linux Text Viewing Commands - Study Notes***

## Basic File Viewing Commands

### `cat` Command

- **Purpose**: Most basic text display command
- **Limitation**: Displays entire file at once, streams to end
- **Use case**: Quick viewing of small files
- **Syntax**: `cat /path/to/file`
- **Problem**: Not practical for large files (they scroll past too quickly)

---

## Partial File Viewing

### `head` Command

- **Purpose**: View the beginning of a file
- **Default behavior**: Shows first 10 lines
- **Basic syntax**: `head /path/to/file`
- **Custom line count**: `head -20 /path/to/file` (shows first 20 lines)
- **Use case**: Checking file headers, configuration file beginnings

### `tail` Command

- **Purpose**: View the end of a file
- **Default behavior**: Shows last 10 lines
- **Basic syntax**: `tail /path/to/file`
- **Custom line count**: `tail -20 /path/to/file` (shows last 20 lines)
- **Use case**: Checking log file endings, recent entries

---

## Line Numbering

### `nl` Command

- **Purpose**: Display file with line numbers
- **Syntax**: `nl /path/to/file`
- **Benefit**: Easier to reference specific lines in large files
- **Note**: Skips numbering for blank lines
- **Use case**: Working with large config files (600+ lines), debugging, collaborative editing

---

## Key Takeaways

1. **Choose the right tool**:
    - `cat` → small files, quick viewing
    - `head` → check file beginnings
    - `tail` → check file endings
    - `nl` → need line references
2. **Customization**: Both `head` and `tail` use `number` flag to specify lines
3. **Practical example used**: `/etc/snort/snort.conf` (600+ line configuration file)
4. **Pro tip**: Line numbers make it easier to reference changes and navigate back to specific locations in files

# Notes on grep Command

## Overview

- **grep** = most widely used text manipulation command in Linux
- Primary function: **filter file content for display**
- Saves significant time when searching for specific text in files

## Basic Syntax

```bash
cat filename | grep "search_term"

```

## Example Breakdown

```bash
kali >cat /etc/snort/snort.conf | grep output

```

**What happens:**

1. `cat` reads the entire `snort.con`f file
2. Pipe (`|`) sends output to grep
3. `grep output` filters and displays **only lines containing "output"**
4. All other lines are hidden

## Key Concepts

### The Pipe Operator (`|`)

- Connects commands together
- Sends output of first command as input to second command
- Enables command chaining for powerful text processing

### Use Cases

- Finding configuration settings in large files
- Locating specific log entries
- Searching for keywords across multiple files
- Debugging by filtering relevant information

### Why It's Essential

- **Time-saving**: No manual scrolling through entire files
- **Precision**: Shows only relevant matches
- **Efficiency**: Critical for system administration and security work
- **Scalability**: Works on files of any size

## Result

The command displays only lines from `snort.conf` that contain `"output"` - in this case, configuration lines related to output plugins and settings.

---

**Remember**: grep is fundamental for Linux text processing and file analysis!

---

# 🧩 Notes: Using `sed` to Find and Replace in Linux

### 📘 What is `sed`?

- **`sed` (Stream Editor)** is a command-line tool used to **find, replace, insert, or delete text** in files.
- Works like the “Find and Replace” feature in text editors but directly from the terminal.
- Often used for **automating edits** in configuration or log files.

---

## ⚙️ Step 1: Create a Test File

Since `/etc/snort/snort.conf` may not exist, create your own file:

```bash
echo -e "include /rules/mysql.rules\n#include /rules/server-mysql.rules\nalert tcp any any -> any any (msg:\"mysql test\");" > test.conf

```

Check the content:

```bash
cat test.conf

```

**Output:**

```
include /rules/mysql.rules
#include /rules/server-mysql.rules
alert tcp any any -> any any (msg:"mysql test");

```

---

## 🔍 Step 2: Search for a Word

To find all lines containing the word **`mysql` :**

```bash
:grep mysql test.conf

```

**Output:**

```
include /rules/mysql.rules
#include /rules/server-mysql.rules
alert tcp any any -> any any (msg:"mysql test");

```

---

## 🛠️ Step 3: Replace All Occurrences

Replace **every occurrence** of `mysql` with `MySQL` and save the result to a new file:

```bash
sed 's/mysql/MySQL/g' test.conf > test2.conf

```

- **s** → substitute
- **mysql** → text to find
- **MySQL** → text to replace with
- **g** → global replacement (every occurrence)

Check the new file:

```bash
cat test2.conf

```

**Output:**

```
include /rules/MySQL.rules
#include /rules/server-MySQL.rules
alert tcp any any -> any any (msg:"MySQL test");

```

---

## 🔁 Step 4: Replace Only the First Occurrence

To replace **only the first** `mysql` in each line:

```bash
sed 's/mysql/MySQL/' test.conf > test2.conf

```

Removes the `g` flag, so only the **first** match per line is replaced.

---

## 🔢 Step 5: Replace a Specific Occurrence

To replace only the **second occurrence** of `mysql` per line:

```bash
sed 's/mysql/MySQL/2' test.conf > test2.conf

```

The number **2** tells `sed` to change only the **second** match per line.

---

## 🧾 Quick Reference Table

| Action | Command | Description |
| --- | --- | --- |
| Search for word | `grep mysql test.conf` | Lists all lines containing “mysql” |
| Replace all occurrences | `sed 's/mysql/MySQL/g' test.conf > test2.conf` | Changes all matches |
| Replace first occurrence | `sed 's/mysql/MySQL/' test.conf > test2.conf` | Changes only the first per line |
| Replace specific occurrence | `sed 's/mysql/MySQL/2' test.conf > test2.conf` | Changes only the second per line |

---

## 💡 Extra Tips

- You can edit a file **in place** (without creating a new file) using the `i` flag:
    
    ```bash
    sed -i 's/mysql/MySQL/g' test.conf
    
    ```
    
- Use `cat` or `grep` after replacement to verify results.
- Always test with a **copy** of the file before editing system configs.

---

---

### 🗂 Viewing Files with `more` and `less`

### **1. Limitations of `cat`**

- `cat` displays entire file contents at once.
- Not practical for **large files** (e.g., `/etc/snort/snort.conf`).
- Better for **small files** or **creating files**.

---

### **2. The `more` Command**

- Displays a file **one page at a time**.
- Command example:
    
    ```bash
    more /etc/snort/snort.conf
    
    ```
    
- Shows percentage of file viewed (e.g., `-More--(2%)`).
- **Controls:**
    - `Enter` → scroll down one line
    - `Space` → scroll down one page
    - `q` → quit viewer

📘 *Useful for reading through long files gradually.*

---

### **3. The `less` Command**

- Enhanced version of `more` → “**Less is more**.”
- Command example:
    
    ```bash
    less /etc/snort/snort.conf
    
    ```
    
- Allows both **scrolling** and **searching**.
- **Controls:**
    - `Up` / `Down` arrows → scroll line by line
    - `Space` → next page
    - `b` → previous page
    - `/word` → search forward for a term
    - `n` → next match
    - `N` → previous match
    - `q` → quit

---

### **4. Example Use Case**

- Searching in Snort config file:
    
    ```bash
    /output
    
    ```
    
    - Highlights first occurrence of “output.”
    - `n` jumps to next match.

---

### ✅ **Key Differences**

| Feature | `more` | `less` |
| --- | --- | --- |
| Paging | Yes | Yes |
| Scroll backward | No | Yes |
| Search text | No | Yes |
| Performance | Basic | Advanced |
| Quit key | `q` | `q` |

---

**In summary:**

- Use **`more`** for simple paging.
- Use **`less`** for advanced navigation and searching within large files.