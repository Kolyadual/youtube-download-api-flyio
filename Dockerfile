# Используем легковесный образ Python версии 3.11
FROM python:3.11-slim

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Устанавливаем системные зависимости, включая ffmpeg (нужен yt-dlp)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Копируем файл с зависимостями и устанавливаем их
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь код приложения в контейнер
COPY . .

# Явно указываем порт, который будет слушать наше приложение
EXPOSE 8080

# Команда для запуска приложения через Gunicorn
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8080"]
