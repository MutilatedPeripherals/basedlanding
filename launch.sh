export SECRET_KEY_BASE=$(openssl rand -base64 48)

docker compose up --build -d