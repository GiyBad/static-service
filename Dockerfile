FROM ubuntu:22.04

# Отключаем интерактив и настраиваем пути Python
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
# Эта строка заставляет Python видеть папки Packets, Logic и т.д.
ENV PYTHONPATH="/app"

WORKDIR /app

# Установка системных зависимостей
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Установка Playit
RUN curl -Lo playit https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 && \
    chmod +x playit

# Установка библиотек Python
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Копируем ВЕСЬ проект (все папки со скриншота)
COPY . .

# Команда запуска туннеля и сервера через PYTHONPATH
CMD ./playit & python3 main.py
