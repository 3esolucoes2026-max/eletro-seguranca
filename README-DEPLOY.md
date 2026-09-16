# 🚀 Deploy no EasyPanel — 3E Instalação e Manutenção Elétrica

Este site é **estático** (HTML/CSS/JS). Publicação no **EasyPanel** usando Nginx + HTTPS automático (Let's Encrypt).

---

## 📋 Situação atual

- ✅ Site pronto em `c:\guilda\eletro-seguranca\`
- ✅ Arquivos de deploy criados (`Dockerfile`, `nginx.conf`, `easypanel.json`)
- ❌ **Domínio ainda não registrado**
- ✅ Repositório no GitHub disponível

---

## 1️⃣ ETAPA 1 — Registrar o domínio

Sugestões de domínio disponíveis para registro:

| Domínio sugerido | Onde registrar |
|------------------|----------------|
| `3einstalacoes.com.br` | [registro.br](https://registro.br) (~R$ 40/ano) |
| `3eeletrica.com.br` | registro.br |
| `3einstalacaoeletrica.com.br` | registro.br |
| `3eseguranca.com.br` | registro.br |

> ⚠️ **O `easypanel.json` já está configurado para `3einstalacoes.com.br`.**
> Se registrar outro domínio, atualize estes 2 arquivos:
> - `easypanel.json` (bloco `domains`)
> - `nginx.conf` (linha `server_name`)

---

## 2️⃣ ETAPA 2 — Apontar o DNS para o VPS

No painel do seu registrador de domínio, crie os registros:

| Tipo | Nome | Valor | TTL |
|------|------|-------|-----|
| A | `@` | `IP_DO_SEU_VPS` | 3600 |
| A | `www` | `IP_DO_SEU_VPS` | 3600 |

> 💡 Substitua `IP_DO_SEU_VPS` pelo IP do servidor onde o EasyPanel está instalado.
> A propagação do DNS pode levar de 5 minutos até algumas horas.

---

## 3️⃣ ETAPA 3 — Subir o código para o GitHub

Na pasta `c:\guilda\eletro-seguranca`, execute no PowerShell:

```powershell
cd c:\guilda\eletro-seguranca
git init
git add .
git commit -m "Site 3E Instalacao e Manutencao Eletrica"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/3e-instalacoes.git
git push -u origin main
```

> 💡 Substitua `SEU_USUARIO` pelo seu usuário do GitHub.

---

## 4️⃣ ETAPA 4 — Criar o serviço no EasyPanel

1. Acesse o painel: `http://IP_DO_SEU_VPS:3000`
2. Clique em **Create Project**
   - **Name:** `3e-instalacoes-eletrica`
3. Dentro do projeto: **Create Service** → **App**
   - **Name:** `3e-instalacoes`
   - **Source:** GitHub
   - **Repository:** `SEU_USUARIO/3e-instalacoes`
   - **Branch:** `main`
   - **Build:** Dockerfile
   - **Dockerfile path:** `Dockerfile`
4. Clique em **Deploy**

---

## 5️⃣ ETAPA 5 — Configurar Domínio & HTTPS

1. No serviço criado, vá em **Domains**
2. **Add Domain:**
   - Host: `3einstalacoes.com.br` → Port `80`
   - Host: `www.3einstalacoes.com.br` → Port `80`
3. Ative **HTTPS** em cada domínio
4. O EasyPanel emite o certificado **Let's Encrypt** automaticamente

> 💡 O EasyPanel cuida do proxy reverso e do redirect `http` → `https`.
> **Não** adicione regras de `rewrite` no Nginx para isso.

---

## 6️⃣ ETAPA 6 — Validar

- [ ] `https://3einstalacoes.com.br` carrega com cadeado 🔒
- [ ] `https://www.3einstalacoes.com.br` também funciona
- [ ] Botão flutuante do WhatsApp abre o link `wa.me/5583982234468`
- [ ] Formulário de orçamento abre o WhatsApp com os dados preenchidos
- [ ] Site abre corretamente no celular

---

## 🔧 Comandos úteis no servidor (SSH)

```bash
# Ver logs do container
docker logs -f $(docker ps --filter name=3e-instalacoes -q)

# Reiniciar o serviço
cd /etc/easypanel/projects/3e-instalacoes-eletrica/3e-instalacoes
docker compose restart
```

---

## 📁 Arquivos de deploy deste projeto

| Arquivo | Função |
|---------|--------|
| `Dockerfile` | Build da imagem Nginx com os arquivos do site |
| `nginx.conf` | Config Nginx (gzip, cache, rotas, domínio) |
| `.dockerignore` | Evita enviar arquivos desnecessários para a imagem |
| `easypanel.json` | Definição do serviço para import no EasyPanel |
| `robots.txt` | Indexação dos buscadores |
| `sitemap.xml` | Mapa do site para SEO |
| `.htaccess` | Alternativa para hospedagem Apache (cPanel) |

---

## ❗ Solução de problemas

| Problema | Causa / Solução |
|----------|-----------------|
| Certificado não emite | DNS não propagou. Teste com `nslookup 3einstalacoes.com.br` e aguarde. |
| Healthcheck vermelho | Container não responde na porta 80. Confira o `EXPOSE 80` no Dockerfile. |
| Site mostra página padrão do Nginx | `nginx.conf` não foi copiado. Rebuild a imagem. |
| Erro 502 | Serviço não está rodando. Verifique os logs no painel. |
| Domínio não resolve | Faltou o registro DNS tipo A apontando para o IP do VPS. |

---

## 📞 Contato do site

- WhatsApp: **(83) 98223-4468**
- Link: `https://wa.me/5583982234468`
