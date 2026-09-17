# Estágio 1: preparar os arquivos do site
FROM alpine:3.18 AS builder

RUN apk add --no-cache git

WORKDIR /app
RUN git clone https://github.com/3esolucoes2026-max/eletro-seguranca.git . && \
    rm -f Dockerfile nginx.conf easypanel.json .dockerignore .nixpacks.toml \
          README-DEPLOY.md deploy_eletro.tar.gz .htaccess

# --- Estágio runtime: Nginx ---
FROM nginx:1.27-alpine

# Copia os arquivos estáticos do site
COPY --from=builder /app/ /usr/share/nginx/html/

# Configuração customizada do Nginx
RUN printf 'server {\n\
    listen 80;\n\
    server_name _;\n\
    root /usr/share/nginx/html;\n\
    index index.html;\n\
    location / {\n\
        try_files $uri $uri/ /index.html;\n\
    }\n\
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80
