# Estágio de build
FROM nginx:1.27-alpine AS runtime

# Copia os arquivos estáticos do site
COPY . /usr/share/nginx/html

# Remove arquivos que não devem ser servidos
RUN rm -f /usr/share/nginx/html/Dockerfile \
    /usr/share/nginx/html/nginx.conf \
    /usr/share/nginx/html/easypanel.json \
    /usr/share/nginx/html/.htaccess \
    /usr/share/nginx/html/README-DEPLOY.md

# Configura customizada de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Porta de exposição
EXPOSE 80
