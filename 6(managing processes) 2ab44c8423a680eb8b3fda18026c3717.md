# 6(managing processes)

Status: Done

---

## 

### **1. What is a Process?**

- A **process** is any program that is currently running and using system resources.
- Examples: terminal, web server, databases, GUI interface, scripts.
- Each process has a **PID (Process ID)** assigned by the Linux kernel.
- PID is crucial when managing processes.

---

# ***2. Viewing Processes***

### **2.1 `ps` Command**

- **Basic use:**
    
    ```bash
    ps
    
    ```
    
    - Shows processes started by the **current user** in the current terminal.
    - Example output:
        
        ```
        PID TTY TIME CMD
        39659 pts/0 00:00:01 bash
        39665 pts/0 00:00:00 ps
        
        ```
        

### **2.2 Viewing All Processes**

- Use **`ps aux`** for detailed info on all processes:
    
    ```bash
    ps aux
    
    ```
    
- Key columns in output:
    - `USER` → user who started the process
    - `PID` → process ID
    - `%CPU` → CPU usage
    - `%MEM` → memory usage
    - `COMMAND` → command that started the process

---

### **3. Filtering Processes**

- Use `grep` to search for a specific process by name:
    
    ```bash
    ps aux | grep <process_name>
    
    ```
    
- Example: check if Metasploit is running:
    
    ```bash
    ps aux | grep msfconsole
    
    ```
    
- Output shows **all processes matching the string**, including the grep command itself.

---

### **4. Monitoring Resource Usage**

### **4.1 `top` Command**

- Displays processes **ordered by resource usage** (CPU/memory).
- Updates dynamically every few seconds (default 3s).
- Example usage:
    
    ```bash
    top
    
    ```
    
- Key points:
    - `PID` → process ID
    - `%CPU` → CPU usage
    - `%MEM` → memory usage
    - `COMMAND` → command/process name
- Interactive keys while running `top`:
    - `H` or `?` → show help/commands
    - `Q` → quit

---

### **5. Summary**

- **Step 1:** View processes using `ps` or `top`.
- **Step 2:** Filter with `grep` to locate specific processes.
- **Step 3:** Monitor resource-heavy processes using `top`.
- **Step 4:** Use PID to manage, prioritize, or kill processes if needed.

---

---

# **Process Management**

## **1. Changing Process Priority**

### **Niceness Values**

- Range: **20 to +19**
- **Lower value = higher priority** (less “nice” to others)
- **Higher value = lower priority** (more “nice”)

### **`nice` Command (set priority at start)**

- Syntax:
    
    ```bash
    nice -n <increment> <command>
    
    ```
    
- Examples:
    - Increase priority:
        
        ```bash
        nice -n -10 /bin/slowprocess
        
        ```
        
    - Lower priority:
        
        ```bash
        nice -n 10 /bin/slowprocess
        
        ```
        

### **`renice` Command (change priority of running process)**

- Uses **absolute** value, not increments.
- Requires **PID**.
- Syntax:
    
    ```bash
    renice <nice_value> <PID>
    
    ```
    
- Examples:
    
    ```bash
    renice 19 6996       # lower priority
    renice -5 6996       # raise priority (root only)
    
    ```
    

### **Changing Nice Value from `top`**

- While `top` is running:
    - Press **R**
    - Enter **PID**
    - Enter new **nice value**

---

## **2. Killing Processes**

### **`kill` Command**

Syntax:

```bash
kill -<signal> <PID>

```

### **Important Kill Signals**

| Signal | Number | Description |
| --- | --- | --- |
| **SIGHUP** | 1 | Stop & restart process (same PID) |
| **SIGINT** | 2 | Weak interrupt (like Ctrl+C) |
| **SIGQUIT** | 3 | Terminate + create core dump |
| **SIGTERM** | 15 | Default terminate signal |
| **SIGKILL** | 9 | **Force kill** (cannot be blocked) |

### **Examples**

Restart:

```bash
kill -1 6996

```

Force kill:

```bash
kill -9 6996

```

### **`killall` Command**

- Kill by process **name**, not PID:
    
    ```bash
    killall -9 rogueprocess
    
    ```
    

### **Killing from `top`**

- Press **K**
- Enter PID

---

## **3. Running Processes in the Background**

### **Starting a process in background**

Add `&`:

```bash
leafpad newscript &

```

### **Send running process to background**

```bash
bg <PID>

```

---

## **4. Bringing Process to Foreground**

```bash
fg <PID>

```

---

## **5. Scheduling Processes**

### **Using `at` (run once in the future)**

### **Syntax**

```bash
at <time>

```

### **Accepted Time Formats**

Examples:

- `at 7:20pm`
- `at 7:20pm June 25`
- `at noon`
- `at tomorrow`
- `at now + 20 minutes`
- `at now + 5 days`
- `at 7:20pm 06/25/2019`

### **At Prompt**

- After typing:
    
    ```bash
    at 7:20am
    
    ```
    
- You get:
    
    ```
    at>
    
    ```
    
- Then type the command(s) to be executed:
    
    ```
    /root/myscanningscript
    
    ```
    
- Exit with:
    
    **`Ctrl+D`**
    

---

If you'd like, I can also turn all of this into a **one-page cheat sheet**, **flashcards**, or a **practice test** for revision.