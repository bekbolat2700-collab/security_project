#!/bin/bash

# --- НАСТРОЙКИ GREEN-API ---
ID_INSTANCE="1101000001"
API_TOKEN="d7f8...ваша_строка"
PHONE_NUMBER="77010000000" # Номер без знака +

# 1. Анализируем логи
echo "🔍 Проверка логов безопасности..."
# Вытаскиваем IP тех, кто ошибся паролем
data=$(grep "Failed password" /var/log/auth.log | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr)

# 2. Проверяем, есть ли данные
if [ -z "$data" ]; then
    echo "✅ Подозрительной активности не обнаружено."
else
    while read count ip; do
        # Если попыток больше 3 — отправляем алерт
        if [ "$count" -gt 3 ]; then
            echo "🚨 Нашел злодея: $ip ($count попыток). Отправляю уведомление..."
            
            # Текст сообщения
            MESSAGE="🛡️ *Security Alert (Astana)*%0AОбнаружен брутфорс!%0A📍 IP: $ip%0A📊 Попыток: $count"

            # Отправка через GREEN-API
            curl -s -X POST "https://api.green-api.com/waInstance$ID_INSTANCE/sendMessage/$API_TOKEN" \
            -H "Content-Type: application/json" \
            -d "{
                \"chatId\": \"$PHONE_NUMBER@c.us\",
                \"message\": \"$MESSAGE\"
            }" > /dev/null
        fi
    done <<< "$data"
    echo "🚀 Проверка завершена."
fi



