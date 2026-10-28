# Настройка Ubuntu Server

## SSH
Конфигурация:
- Port 2222
- PermitRootLogin no
- PasswordAuthentication no
- PubkeyAuthentication yes
- MaxAuthTries 3
- AllowUsers devops

Проверка:
sudo sshd -T
sudo ss -tlnp | grep sshd

## UFW
sudo ufw status verbose

## DNS
Локальное имя: devops.local.test
IP: 192.168.56.2
Hostname: devops-vm
