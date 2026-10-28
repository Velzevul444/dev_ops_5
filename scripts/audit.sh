#!/usr/bin/env bash

errors=0

check() {
    if eval "$2"; then
        echo "[PASS] $1"
    else
        echo "[FAIL] $1"
        errors=$((errors + 1))
    fi
}

config=$(sudo sshd -T)
ufw=$(sudo ufw status verbose)

check "Пользователь devops" "id devops >/dev/null 2>&1"
check "Права sudo" "id -nG devops | grep -qw sudo"
check "Порт SSH 2222" "echo \"\$config\" | grep -qx 'port 2222'"
check "Root запрещён" "echo \"\$config\" | grep -qx 'permitrootlogin no'"
check "Пароль отключён" "echo \"\$config\" | grep -qx 'passwordauthentication no'"
check "UFW активен" "echo \"\$ufw\" | grep -q 'Status: active'"
check "SSH LIMIT" "echo \"\$ufw\" | grep -Eq '^2222/tcp[[:space:]]+LIMIT IN'"
check "HTTP разрешён" "echo \"\$ufw\" | grep -Eq '^80/tcp[[:space:]]+ALLOW IN'"
check "HTTPS разрешён" "echo \"\$ufw\" | grep -Eq '^443/tcp[[:space:]]+ALLOW IN'"

echo "Ошибок: $errors"
[ "$errors" -eq 0 ]
