# 7(managing user and environment variables)

Status: Done

---

# **📌 Linux Environment & Shell Variables — Clean Notes**

## **1. Types of Variables**

### **Environment Variables**

- Uppercase (`PATH`, `HOME`, `SHELL`).
- System-wide for the process and inherited by child processes.
- Affect how the system/shell behaves.

### **Shell Variables**

- Lowercase usually.
- Only valid within the shell session in which they are set.
- Not inherited by child processes.

---

## **2. Structure of Variables**

- Form: `KEY=value`
- Multiple values: `KEY=value1:value2`
- Value with spaces must be quoted.

---

## **3. Viewing Variables**

### **View environment variables**

```
env

```

### **View ALL variables**

(including environment, shell vars, functions, aliases)

```
set

```

### **Paginated output**

```
set | more

```

(Press `q` to exit.)

### **Filter output with `grep`**

Example: finding `HISTSIZE`

```
set | grep HISTSIZE

```

---

## **4. Modifying Variables (Session Only)**

Change value:

```
HISTSIZE=0

```

Variable now changed but valid only for this session.

---

## **5. Make Variable Changes Permanent**

Use `export`:

```
export HISTSIZE

```

Now it applies to child processes.

### **Restore default**

```
HISTSIZE=1000
export HISTSIZE

```

---

## **6. Saving Variable Contents (Backup)**

Save a variable:

```
echo $HISTSIZE > ~/valueofHISTSIZE.txt

```

Save ALL variables:

```
set > ~/valueofALLon01012019.txt

```

---

## **7. Changing the Shell Prompt (PS1)**

Placeholders:

- `\u` = username
- `\h` = hostname
- `\w` = current working directory

Examples:

### **Custom Prompt**

```
PS1="World's Best Hacker: #"
export PS1

```

### **Windows-style Prompt**

```
export PS1='C:\w> '

```

---

## **8. PATH Variable**

Shows directories that shell searches for commands:

```
echo $PATH

```

### **Add a directory to PATH**

```
PATH=$PATH:/root/newhackingtool

```

⚠️ **Do NOT replace PATH entirely**

Wrong:

```
PATH=/root/newhackingtool

```

This removes `/bin`, `/sbin`, etc., and breaks common commands.

---

## **9. Creating User-Defined Variables**

### **Create**

```
MYNEWVARIABLE="Hacking is the most valuable skill set in the 21st century"

```

### **View**

```
echo $MYNEWVARIABLE

```

### **Export (make permanent for child sessions)**

```
export MYNEWVARIABLE

```

---

## **10. Deleting Variables**

```
unset MYNEWVARIABLE

```

---