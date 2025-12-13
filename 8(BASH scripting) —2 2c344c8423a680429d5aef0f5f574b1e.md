# 8(BASH scripting) —2

Status: Done

---

# **Bash Scripting Notes (Sections 11–18)**

---

## **11. `declare` Command**

### Purpose

- Declare variables with attributes, types, and scope.
- Makes code more robust and predictable.

### Common Flags

| Flag | Description | Example |
| --- | --- | --- |
| `-r` | Readonly | `declare -r PI=3.14159` |
| `-i` | Integer | `declare -i num=10; num=num+5` |
| `-a` | Indexed array | `declare -a fruits; fruits[0]="Apple"` |
| `-A` | Associative array | `declare -A colors; colors[red]="#FF0000"` |
| `-l` | Lowercase | `declare -l name="JOHN"` → `john` |
| `-u` | Uppercase | `declare -u city="new york"` → `NEW YORK` |
| `-p` | Print declaration | `declare -p num` |

### Combining Flags

```bash
declare -ir MAX_COUNT=100
declare -ux ENV_NAME="production"

```

### Local Variables in Functions

```bash
function f() {
    declare local_var="local"
    echo $local_var
}
f
echo $local_var   # Empty

```

---

## **12. Arrays**

### Indexed Arrays

```bash
fruits=("Apple" "Banana" "Cherry")
echo ${fruits[0]}  # Apple
echo ${fruits[@]}  # All elements

```

### Array Length

```bash
echo ${#fruits[@]}   # Number of elements
echo ${#fruits[0]}   # Length of first element

```

### Add / Remove Elements

```bash
fruits+=("Date")      # Append
unset fruits[1]       # Remove element
unset fruits          # Remove entire array

```

### Looping Through Arrays

```bash
for fruit in "${fruits[@]}"; do echo $fruit; done
for i in "${!fruits[@]}"; do echo "$i: ${fruits[$i]}"; done
for ((i=0; i<${#fruits[@]}; i++)); do echo "${fruits[$i]}"; done

```

### Array Slicing

```bash
numbers=(10 20 30 40 50)
echo ${numbers[@]:2:3}  # 30 40 50

```

### Associative Arrays

```bash
declare -A person
person[name]="John"
person[age]=30
echo ${person[name]}
echo ${!person[@]}  # All keys

```

---

## **13. Functions**

### Declaration

```bash
function greet() { echo "Hello"; }
greet() { echo "Hello"; }

```

### Parameters

```bash
greet "John"   # $1 = John
echo "All params: $@, Count: $#"

```

### Return Values

- `return` (integer 0-255)

```bash
function is_even() { [ $(($1 % 2)) -eq 0 ]; return $?; }
is_even 4
echo $?   # 0 = success

```

- `echo` (any value)

```bash
function multiply() { echo $(($1*$2)); }
result=$(multiply 6 7)

```

### Local Variables

```bash
function f() { local name="John"; }

```

### Recursive Functions

```bash
function factorial() {
    if [ $1 -le 1 ]; then echo 1
    else prev=$(factorial $(($1-1))); echo $(($1*prev)); fi
}
result=$(factorial 5)

```

### Function Libraries

```bash
source mylib.sh
greet "John"

```

---

## **14. Files and Directories**

### File Test Operators

| Operator | Description |
| --- | --- |
| `-f` | Regular file |
| `-d` | Directory |
| `-e` | Exists |
| `-r` | Readable |
| `-w` | Writable |
| `-x` | Executable |
| `-s` | Size > 0 |

### File Operations

```bash
touch file.txt
echo "Hello" > file.txt
mkdir mydir
mkdir -p nested/dir
cat file.txt
head -n5 file.txt
tail -n5 file.txt
while IFS= read -r line; do echo $line; done < file.txt

```

### Copy / Move / Delete

```bash
cp source.txt dest.txt
cp -r dir1 dir2
mv old.txt new.txt
rm file.txt
rm -r dir/
rm -rf dir/  # Dangerous!

```

### Find Files

```bash
find /path -name "*.txt"
find /path -type f
find /path -mtime -7
find /path -size +10M

```

---

## **15. Send Email via Script**

### Using `mail`

```bash
echo "Body" | mail -s "Subject" user@example.com
mail -s "Report" admin@example.com < /var/log/report.txt

```

### Using `sendmail`

```bash
sendmail user@example.com << EOF
Subject: Test Email
From: sender@example.com

Body text
EOF

```

### Using `mutt` with attachment

```bash
echo "Body" | mutt -s "Subject" -a file.pdf -- user@example.com

```

---

## **16. cURL in Scripts**

### Basic GET/Save

```bash
curl https://example.com
curl -o output.html https://example.com
curl -O https://example.com/file.pdf
curl -s https://example.com

```

### HTTP Methods

```bash
curl -X POST -H "Content-Type: application/json" -d '{"name":"John"}' https://api.example.com
curl -X PUT ...
curl -X DELETE ...

```

### Authentication

```bash
curl -u user:pass https://api.example.com
curl -H "Authorization: Bearer $TOKEN" https://api.example.com

```

### Status Code

```bash
status=$(curl -s -o /dev/null -w "%{http_code}" https://example.com)

```

### Practical Example: API Health Check

```bash
MAX_RETRIES=3; RETRY=0
while [ $RETRY -lt $MAX_RETRIES ]; do
    status=$(curl -s -o /dev/null -w "%{http_code}" "$API_URL")
    [ $status -eq 200 ] && echo "Healthy" && exit 0
    RETRY=$((RETRY+1)); sleep 5
done
echo "API down"

```

---

## **17. Professional Menus**

### Basic Menu

```bash
while true; do
    echo "1. Option 1"; echo "2. Exit"
    read choice
    case $choice in 1) ... ;; 2) exit 0 ;; *) echo "Invalid";; esac
done

```

### Select Command

```bash
PS3="Select: "
options=("Start" "Stop" "Quit")
select opt in "${options[@]}"; do case $opt in ...) break;; esac; done

```

### Colored Menus

```bash
RED='\033[0;31m'; NC='\033[0m'
echo -e "${RED}Option 1${NC}"

```

### Multi-Level Menus

```bash
function main_menu() { echo "1. User Management"; echo "2. Exit"; }
function user_menu() { echo "1. Add User"; echo "2. Back"; }

```

### Input Validation

```bash
while true; do read input; [[ $input =~ ^[0-9]+$ ]] && break; done

```

---

## **18. Wait for Filesystem Events with inotify**

### Install

```bash
sudo apt-get install inotify-tools
sudo yum install inotify-tools

```

### Basic Usage

```bash
inotifywait -m /path/to/dir
inotifywait -m -r -e create,modify /path

```

### Events

- `create`, `modify`, `delete`, `moved_to`, `moved_from`, `close_write`, `access`, `open`

### Example: Auto Backup

```bash
inotifywait -m -r -e modify,create,delete "$WATCH_DIR" |
while read dir event file; do
    case $event in
        CREATE|MODIFY) cp "$dir$file" "$BACKUP_DIR/";;
        DELETE) rm -f "$BACKUP_DIR/$file";;
    esac
done

```

### Hot Reload Development

```bash
inotifywait -m -r -e modify "$PROJECT_DIR" --exclude '(__pycache__|\.pyc$)' |
while read dir event file; do
    [[ "$file" == *.py ]] && restart_server
done

```

### Advanced Features

- Custom output: `-format '%T %w%f %e' --timefmt '%Y-%m-%d %H:%M:%S'`
- Exclude patterns: `-exclude '(\.swp|\.tmp|~)$'`
- Increase watch limit: `sudo sysctl fs.inotify.max_user_watches=524288`

---