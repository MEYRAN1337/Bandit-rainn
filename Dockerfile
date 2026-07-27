FROM python:3.10-slim

# Instalacja zależności systemowych, narzędzi oraz przeglądarki Google Chrome
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip \
    curl \
    libxi6 \
    libgconf-2-4 \
    libnss3 \
    libglib2.0-0 \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Ustawienie katalogu roboczego w kontenerze
WORKDIR /app

# Skopiowanie plików projektu do kontenera
COPY . /app

# Instalacja bibliotek Pythona z pliku requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Uruchomienie bota (zmień bot.py na nazwę swojego głównego pliku Pythona)
CMD ["python", "bot.py"]

