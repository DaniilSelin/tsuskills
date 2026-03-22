FROM ubuntu:22.04

# Установка пакетов включая python3
RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils zip bash python3 python3-pip

# Установка Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="$PATH:/flutter/bin"

# Настройка Flutter
RUN flutter channel stable && flutter upgrade

WORKDIR /app
COPY tsu_skills /app

RUN flutter pub get && flutter build web

# Явно указываем путь к python3
CMD ["/usr/bin/python3", "-m", "http.server", "8000", "--directory", "build/web"]
