# 16(job scheduling)

Status: Not started

---

# **📌 Chapter Notes: Automating Tasks with Job Scheduling (cron & rc scripts)**

---

## **1. Purpose of Job Scheduling**

- Automates repetitive tasks without user intervention.
- Useful for:
    - Backups
    - Log rotation
    - Running security scans (e.g., MySQLscanner.sh)
    - Running tasks at night or when system is idle
- Services can also be set to start automatically on system boot.

---

## **2. Cron & Crontab**

- **cron / crond** → background daemon that executes scheduled jobs.
- **crontab** → file that stores scheduled tasks.

### Cron file location:

```
/etc/crontab

```

---

## **3. crontab Format**

```
M H DOM MON DOW USER COMMAND

```

Where:

| Field | Meaning | Values |
| --- | --- | --- |
| M | Minute | 0–59 |
| H | Hour | 0–23 |
| DOM | Day of Month | 1–31 |
| MON | Month | 1–12 |
| DOW | Day of Week | 0–7 (0 & 7 = Sunday) |

### Symbols:

- → any value / all
- `,` → multiple values
- → range of values

---

## **4. Example Cron Entry**

### Run script at 2:30 AM, Mon–Fri:

```
30 2 * * 1-5 root /root/myscanningscript

```

---

## **5. Editing crontab**

### Using terminal editor (first time asks to choose editor):

```
crontab -e

```

### Edit system-wide crontab using GUI editor:

```
leafpad /etc/crontab

```

---

## **6. Backup Task Examples**

### Run every Sunday at 2 AM:

```
00 2 * * 0 backup /bin/systembackup.sh

```

### Run every month on 15th & 30th:

```
00 2 15,30 * * backup /root/systembackup.sh

```

### Run every weekday at 11 PM:

```
00 23 * * 1-5 backup /root/systembackup.sh

```

---

## **7. Scheduling MySQL Scanner**

### Run daily at 9 AM:

```
00 9 * * * user /usr/share/MySQLsscanner.sh

```

### Only weekends in June–August at 2 AM:

```
00 2 * 6-8 0,6 user /usr/share/MySQLsscanner.sh

```

---

## **8. crontab Shortcuts**

| Shortcut | Meaning |
| --- | --- |
| @yearly / @annually | Once a year |
| @monthly | Once a month |
| @weekly | Weekly |
| @daily | Daily |
| @midnight | Midnight daily |
| @noon | Noon daily |
| @reboot | Run at system startup |

### Example:

```
@midnight user /usr/share/MySQLsscanner.sh

```

---

## **9. Startup Automation Using rc.d**

### Run services at boot using:

```
update-rc.d <script_name> <defaults|remove|enable|disable>

```

### Example: Auto-start PostgreSQL:

```
update-rc.d postgresql defaults

```

---

## **10. Checking if PostgreSQL is running**

```
ps aux | grep postgresql

```

---

## **11. GUI-based service startup control**

Install rcconf:

```
apt-get install rcconf

```

Run rcconf:

```
rcconf

```

- Select services to auto-start at boot.
- Useful alternative to command-line method.

---

### **Summary**

- cron automates periodic tasks using crontab.
- Supports time scheduling using minute/hour/day/month/week format.
- rc scripts control services started at boot.
- update-rc.d adds/removes startup services.
- rcconf provides GUI for enabling services on startup.

---