# --- Настройка логирования ---
LOG_FILE="/var/log/system_hardening.log"

# Функция для записи логов в файл и вывода на экран
log_message() {
    local MESSAGE="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $MESSAGE" | sudo tee -a "$LOG_FILE"
}

# --- Проверка прав ROOT ---
if [[ $EUID -ne 0 ]]; then
   echo "ОШИБКА: Этот скрипт требует прав суперпользователя (root)."
   echo "Запустите его через: sudo $0"
   exit 1
fi

log_message "=== ЗАПУСК ПРОЦЕССА HARDENING ==="
# 1. Обновление системы
log_message "Обновление списка пакетов..."
sudo apt-get update -y >> "$LOG_FILE" 2>&1

# 2. Установка и настройка брандмауэра (UFW)
log_message "Настройка UFW..."
sudo apt-get install -y ufw >> "$LOG_FILE" 2>&1
sudo ufw default deny incoming >> "$LOG_FILE" 2>&1
sudo ufw default allow outgoing >> "$LOG_FILE" 2>&1
sudo ufw allow ssh >> "$LOG_FILE" 2>&1
sudo ufw --force enable >> "$LOG_FILE" 2>&1
log_message "UFW настроен: входящие запрещены, SSH разрешен."

# 3. Базовая защита SSH (отключение входа для root)
log_message "Оптимизация безопасности SSH..."
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart ssh >> "$LOG_FILE" 2>&1
log_message "Вход для root через SSH отключен."

# 4. Установка Fail2Ban (защита от перебора паролей)
log_message "Установка Fail2Ban..."
sudo apt-get install -y fail2ban >> "$LOG_FILE" 2>&1
sudo systemctl enable fail2ban >> "$LOG_FILE" 2>&1
log_message "Fail2Ban активен."

log_message "=== ПРОЦЕСС ЗАВЕРШЕН УСПЕШНО ==="
