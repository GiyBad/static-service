# Используем Ubuntu 22.04
FROM ubuntu:22.04

# Отключаем интерактивные запросы
ENV DEBIAN_FRONTEND=noninteractive
# Устанавливаем путь поиска модулей Python на текущую директорию
ENV PYTHONPATH="/app"
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Обновляем систему и ставим зависимости
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Скачиваем агент playit
RUN curl -Lo playit https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 && \
    chmod +x playit

# Сначала копируем зависимости для кэширования
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Копируем ВЕСЬ проект (все папки Packets, Logic, Utils и т.д.)
COPY . .

# Даем права на выполнение (на всякий случай)
RUN chmod +x playit

# Запуск туннеля и сервера
# Мы используем python3 main.py, а PYTHONPATH="/app" поможет найти Packets
CMD ./playit & python3 main.py
