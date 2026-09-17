FROM alpine:3.18 AS builder

RUN apk add --no-cache git

WORKDIR /app
RUN git clone https://github.com/3esolucoes2026-max/eletro-seguranca.git .

# --- Runtime ---
FROM nginx:1.27-alpine

# Copia os arquivos estáticos do site
COPY --from=builder /app/ /usr/share/nginx/html/

# Remove arquivos que não devem ser servidos
RUN rm -f /usr/share/nginx/html/Dockerfile \
    /usr/share/nginx/html/nginx.conf \
    /usr/share/nginx/html/easypanel.json \
    /usr/share/nginx/html/.htaccess \
    /usr/share/nginx/html/README-DEPLOY.md \
    /usr/share/nginx/html/deploy_eletro.tar.gz \
    /usr/share/nginx/html/.dockerignore

# Configura customizada de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
