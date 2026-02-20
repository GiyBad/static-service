FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app
RUN apt-get update && apt-get install -y python3 python3-pip curl && rm -rf /var/lib/apt/lists/*
RUN curl -Lo playit https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 && chmod +x playit
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .
# Запускаем и туннель, и сервер
CMD ./playit & python3 main.py
