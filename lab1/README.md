```markdown
# Лабораторная работа №1

**Дисциплина:** Безопасность операционных систем  
**Выполнил:** Зинченко Михаил Алексеевич
**Группа:** Б24-502
**Дата:** 26.09.2026

---

## 2.1. Перемещение по файловой системе

### 2.1.2
```bash
whoami
pwd
```

### 2.1.3
```bash
cd /
cd ..
```

### 2.1.4
```bash
ls
```

### 2.1.5
```bash
ls /etc
```

### 2.1.6
```bash
cd ~
```

### 2.1.7
```bash
ls
```

### 2.1.8
```bash
ls -la
```

---

## 2.2. Работа с файловой системой

### 2.2.1
```bash
mkdir ~/fruits
```

### 2.2.2
```bash
cd /
mkdir ~/animals
```

### 2.2.3
```bash
cd /tmp
touch temp
```

### 2.2.4
```bash
echo "Hello" > /tmp/temp
echo "world" >> /tmp/temp
nano /tmp/temp
```

### 2.2.5
```bash
cd ~/fruits && touch apple && touch banana && touch pineaple && touch lion
```

### 2.2.6
```bash
touch ~/animals/cat.txt ~/animals/dog.txt ~/animals/elephant.txt
```

### 2.2.7
```bash
ls ~/fruits/a*
```

### 2.2.8
```bash
ls ~/fruits/*e
```

### 2.2.9
```bash
find ~/fruits -maxdepth 1 -type f \( -name '*a*n*' -o -name '*n*a*' \)
```

### 2.2.10
```bash
cp /etc/passwd ~/passwd
wc -l ~/passwd
ln -s ~/passwd ~/passwd.link
stat -c '%i %n' ~/passwd.link
```

### 2.2.11
```bash
cat /etc/issue
```

### 2.2.12
```bash
cp /etc/issue ~/fruits/apple
cat ~/fruits/apple
```

### 2.2.13
```bash
mv ~/fruits/lion ~/animals/
```

### 2.2.14
```bash
mv ~/fruits/pineaple ~/fruits/pineapple
```

### 2.2.15
```bash
ln ~/.bash_history ~/bash_history.hard
stat -c '%h %n' ~/.bash_history
```

### 2.2.16
```bash
rm -r ~/fruits
```

### 2.2.17
```bash
sudo cat /var/log/boot.log
```

---

## 2.3. Механизм конвейеров

### 2.3.1
```bash
cut -d: -f1 /etc/passwd | sort
```

### 2.3.2
```bash
grep -c '/bash$' /etc/passwd
```

### 2.3.3
```bash
grep '/bash$' /etc/passwd | cut -d: -f1 | sort -r
```

### 2.3.4
```bash
cut -d: -f1,7 /etc/passwd | column -t -s:
```

---

## 2.4. Получение прав суперпользователя

### 2.4.1
```bash
cat /etc/shadow
```

### 2.4.2
```bash
groups
id -nG
getent group sudo
sudo usermod -aG sudo $USER
```

### 2.4.3
```bash
sudo cat /etc/shadow
```

### 2.4.4
```bash
getent group sudo
```

### 2.4.5
```bash
sudo apt update
sudo apt install -y build-essential
gcc --version
g++ --version
make --version
```

---

## 2.5. Поиск файлов и каталогов

### 2.5.1
```bash
find --help
```

### 2.5.2
```bash
find / -name '*pass*' 2>/dev/null
```

### 2.5.3
```bash
find / -iname '*pass*' 2>/dev/null
```

### 2.5.4
```bash
find / -maxdepth 1 -name '*pass*' 2>/dev/null
```

### 2.5.5
```bash
find /home -name '*.bin' 2>/dev/null
```

### 2.5.6
```bash
find . -type f -name '*.bak' -delete
```

### 2.5.7
```bash
find . -type f \( -name '*.txt' -o -name '*.sh' \)
```

### 2.5.8
```bash
find . -type f -printf '%f %u %g %n %s\n'
```

### 2.5.9
```bash
find . -mindepth 1 -type d -empty
```

### 2.5.10
```bash
find . -mindepth 1 -type d -empty -delete
```

### 2.5.11
```bash
find . -type f -empty -delete
```

### 2.5.12
```bash
find . -type f -links +1
```

### 2.5.13
```bash
find /etc ! -user root 2>/dev/null
```

### 2.5.14
```bash
find . -type f ! -name '*.sh'
```

### 2.5.15
```bash
find . -type f -links +2
```

### 2.5.16
```bash
find /usr/bin -type f -atime +90
```

### 2.5.17
```bash
find /usr/bin /usr/share -type f -mtime -10
```

### 2.5.18
```bash
find /tmp -type f -mtime +14 -delete
```
```
