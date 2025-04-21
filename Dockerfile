FROM ubuntu:22.04

# Установка зависимостей с очисткой кеша
RUN apt-get update && \
    apt-get install -yy \
    gcc \
    g++ \
    cmake \
    git \
    wget \
    openssl \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Клонируем Hunter вручную
RUN git clone https://github.com/cpp-pm/hunter /root/.hunter && \
    cd /root/.hunter && \
    git checkout v0.23.314

# Устанавливаем переменную окружения для Hunter
ENV HUNTER_ROOT=/root/.hunter

# Копируем исходный код
COPY . print/
WORKDIR print

# Собираем проект
RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install && \
    cmake --build _build && \
    cmake --build _build --target install

# Настройка окружения
ENV LOG_PATH=/home/logs/log.txt
VOLUME /home/logs
WORKDIR _install/bin
ENTRYPOINT ["./demo"]
