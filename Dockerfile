# Используем легкий образ Ubuntu
FROM ubuntu:latest

# Устанавливаем curl для работы с API
RUN apt-get update && apt-get install -y curl

# Копируем наш скрипт в контейнер
COPY analyze_logs.sh /usr/local/bin/analyze_logs.sh

# Даем права на выполнение
RUN chmod +x /usr/local/bin/analyze_logs.sh

# Команда, которая запустится при старте контейнера
CMD ["/usr/local/bin/analyze_logs.sh"]
