# 8(BASH scripting)

Status: Done

---

# **Bash Scripting Notes**

---

## **1. Introduction to Scripting**

- **Scripting:** Automates tasks on Linux systems.
- **Bash:** Stands for **Bourne Again Shell**.
- Scripts are saved with the **`.sh`** extension.

### **Finding Available Shells**

```bash
cat /etc/shells

```

- Lists all shells on your system.

### **Finding Shell Path**

```bash
which bash

```

- Returns the full path (e.g., `/bin/bash`) to use in scripts.

### **Creating Your First Script**

1. **Create the file**

```bash
touch hello_script.sh

```

1. **Add Shebang line**

```bash
#!/bin/bash

```

- Must be the first line; tells system which interpreter to use.
1. **Add a command**

```bash
#!/bin/bash
echo "Hello Scripting"

```

1. **Make script executable**

```bash
chmod +x hello_script.sh

```

1. **Execute script**

```bash
./hello_script.sh

```

- `./` runs the script from the current directory.

---

## **2. Redirecting Output to Files**

- **Single `>`:** Overwrites file.

```bash
echo "Hello Linux" > file.txt

```

- **Double `>>`:** Appends to file.

```bash
echo "Hello again" >> file.txt

```

- **Using `cat` for input**

```bash
cat > file.txt      # Type text, then Ctrl+D to save
cat >> file.txt     # Append text

```

**Key Difference:**

- `>` = overwrite
- `>>` = append

---

## **3. Comments**

- **Single-line:** Start with `#`

```bash
# This is a comment

```

- **Multi-line:** Use `: ' ... '`

```bash
: '
This is line 1
This is line 2
'

```

- **Here-doc syntax:** Useful for multi-line text or pseudo-comments

```bash
cat << END
This is line 1
This is line 2
END

```

- Delimiters must match exactly.

---

## **4. Conditional Statements**

### **If Statement**

```bash
count=10
if [ $count -eq 10 ]
then
    echo "The condition is true"
fi

```

- **Spacing is critical** around `[ ]`.

### **If-Else Statement**

```bash
if [ $count -eq 9 ]
then
    echo "True"
else
    echo "False"
fi

```

### **Comparison Operators**

- **Equality:** `eq`, `ne`
- **Relational:** `gt`, `lt`, `ge`, `le`
- **Alternative (arithmetic):**

```bash
if (( count > 9 ))
then
    echo "True"
fi

```

### **If-Elif-Else**

```bash
if [ $count -lt 9 ]; then
    echo "First"
elif [ $count -le 9 ]; then
    echo "Second"
else
    echo "False"
fi

```

### **Logical Operators**

- **AND:** `a`, `&&`
- **OR:** `o`, `||`

### **Case Statement**

```bash
car="BMW"
case $car in
    "BMW") echo "BMW selected" ;;
    "Mercedes") echo "Mercedes selected" ;;
    *) echo "Unknown car" ;;
esac

```

---

## **5. Loops**

### **While Loop**

```bash
number=1
while [ $number -lt 10 ]
do
    echo $number
    number=$((number + 1))
done

```

### **Until Loop**

```bash
number=1
until [ $number -ge 10 ]
do
    echo $number
    number=$((number + 1))
done

```

### **For Loops**

- **List-based**

```bash
for i in 1 2 3 4 5; do
    echo $i
done

```

- **Range**

```bash
for i in {0..20}; do echo $i; done
for i in {0..20..2}; do echo $i; done

```

- **C-style**

```bash
for (( i=0; i<5; i++ )); do
    echo $i
done

```

### **Break and Continue**

- **Break:** exit loop

```bash
if [ $i -gt 5 ]; then break; fi

```

- **Continue:** skip iteration

```bash
if [[ $i -eq 3 || $i -eq 7 ]]; then continue; fi

```

---

## **6. Script Input**

### **Command-Line Arguments**

- `$0` = script name
- `$1`, `$2`, `$3` = positional arguments
- `$@` = all arguments
- `$#` = number of arguments

```bash
args=("$@")
echo ${args[0]} ${args[1]} ${args[2]}

```

### **Reading from Files**

```bash
while read line
do
    echo $line
done < "$1"

```

### **Handling Spaces in Filenames**

```bash
./script.sh "file with spaces.txt"

```

---

## **7. Script Output**

### **Redirect to File**

- Overwrite: `> file.txt`
- Append: `>> file.txt`

### **Exit Status**

- `$?` contains last command's exit status (0 = success, non-zero = error)

### **stdout vs stderr**

```bash
command > output.txt 2> error.txt     # separate
command > all.txt 2>&1               # combined

```

---

## **8. Connecting Scripts**

### **Producer Script**

```bash
echo "Line 1"
echo "Line 2"

```

### **Consumer Script**

```bash
while read line; do
    echo "Received: $line"
done

```

### **Pipe Scripts**

```bash
./producer.sh | ./consumer.sh

```

- Can chain multiple scripts:

```bash
./script1.sh | ./script2.sh | ./script3.sh

```

---

## **9. String Processing**

### **Variable Declaration**

```bash
string="Hello World"
length=${#string}       # length of string

```

### **Concatenation**

```bash
string3="$string1 $string2"

```

### **Substring Extraction**

```bash
${string:start:length}

```

### **Replacement**

```bash
${string/old/new}       # first occurrence
${string//old/new}      # all occurrences

```

### **Deletion**

```bash
${string#prefix}    # remove from start
${string%suffix}    # remove from end

```

### **Case Conversion**

```bash
${string^^}   # upper
${string,,}   # lower
${string^}    # capitalize first char

```

### **Check contents**

```bash
[[ $string == *"World"* ]]   # contains
[[ $string == Hello* ]]      # starts with
[[ $string == *World ]]      # ends with

```

### **Comparison**

```bash
[ "$s1" = "$s2" ]   # equal
[ "$s1" != "$s2" ]  # not equal
[[ $s1 < $s2 ]]     # lexicographical

```

### **Empty String Check**

```bash
[ -z "$string" ]     # empty
[ -n "$string" ]     # not empty

```

### **Splitting Strings**

```bash
IFS=',' read -ra arr <<< "$string"
for item in "${arr[@]}"; do echo $item; done

```

---

## **10. Numbers and Arithmetic**

### **Basic Arithmetic**

```bash
result=$((num1 + num2))
let result=num1+num2
result=$(expr $num1 + $num2)

```

### **Operators**

- `+`, , , `/`, `%`, `*`

### **Increment/Decrement**

```bash
((num++))
((++num))
((num--))
((--num))
((num += 5))   # shorthand

```

### **Floating Point (using bc)**

```bash
result=$(echo "scale=2; 10 / 3" | bc)

```

- Square root: `sqrt(25)`
- Power: `2^10`

### **Numeric Comparison**

- `[ $a -gt $b ]`
- `(( a > b ))` (alternative syntax)

### **Random Numbers**

```bash
$RANDOM               # 0-32767
$(( (RANDOM % 100) + 1 ))   # 1-100

```

### **Examples**

- **Average**

```bash
sum=$((n1 + n2 + n3))
average=$((sum / 3))

```

- **Factorial**

```bash
factorial=1
for (( i=1; i<=num; i++ )); do
    factorial=$((factorial * i))
done

```

- **Temperature Conversion**

```bash
fahrenheit=$(echo "scale=2; ($celsius*9/5)+32" | bc)

```

---

✅ **Tips:**

- Always use `#!/bin/bash` at the top.
- Quote variables in `[ ]` comparisons.
- Remember space in `[ ]` tests.
- Use `chmod +x` to make scripts executable.

---