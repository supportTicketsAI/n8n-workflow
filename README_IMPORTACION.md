# 🚀 Importación del Workflow N8N - VIVETORI AI Support Co-Pilot

## 📋 Pasos para Importar en N8N

### 1. **Abrir N8N**
- Ve a tu instancia de N8N (ej: `http://localhost:5678`)
- Inicia sesión en tu cuenta

### 2. **Importar el Workflow**
1. Haz clic en **"+ Agregar Workflow"** o **"Import from file"**
2. Selecciona el archivo `Ticket-flow.json`
3. El workflow se importará con **8 nodos conectados**:

### 3. **Estructura del Workflow Importado**

```
🎯 Webhook - Ticket Procesado
    ↓
🤔 ¿Sentimiento Negativo? (Condicional)
    ├── SI (Sentimiento = "Negativo")
    │   ├── 📧 Enviar Email de Alerta
    │   ├── 💬 Notificar Slack (Opcional)
    │   ├── 📱 Notificar Telegram (Opcional)
    │   └── 📊 Log en Supabase
    └── NO (Otros sentimientos)
        ├── ✅ Ticket OK - Sin Alerta
        └── 🎮 Log Discord (Opcional)
```

### 4. **Configuraciones Requeridas**

#### 🎯 **Webhook (Ya configurado)**
- **URL**: `/webhook/5ec1e629-d6db-4290-a81d-61a71b3b7883`
- **Método**: POST
- **Estado**: Activo

#### 📧 **Email (Configurar)**
- Agregar credenciales de SMTP
- Email destino: `support@vivetori.com`

#### 💬 **Slack (Opcional)**
- Reemplazar: `REPLACE-WITH-YOUR-SLACK-WEBHOOK`
- Con tu webhook real de Slack

#### 📱 **Telegram (Opcional)**
- Reemplazar: `YOUR_BOT_TOKEN` y `YOUR_CHAT_ID`
- Con tus credenciales reales de Telegram

#### 📊 **Supabase**
- Agregar credenciales de Supabase
- Tabla: `ticket_logs`

#### 🎮 **Discord (Opcional)**
- Agregar webhook de Discord

### 5. **URL del Webhook para tu Backend**

Después de importar, copia la URL completa del webhook:

```
http://localhost:5678/webhook/5ec1e629-d6db-4290-a81d-61a71b3b7883
```

Y actualízala en tu archivo `.env` del backend:

```bash
N8N_WEBHOOK_URL=http://localhost:5678/webhook/5ec1e629-d6db-4290-a81d-61a71b3b7883
```

### 6. **Activar el Workflow**

1. Después de importar, haz clic en **"Activar"** (toggle en la parte superior derecha)
2. El webhook estará listo para recibir notificaciones

### 7. **Probar el Flujo**

1. Asegúrate de que el backend esté corriendo
2. Crea un ticket con sentimiento negativo:

```bash
curl -X POST "http://localhost:8080/api/v1/process-ticket" \
  -H "Content-Type: application/json" \
  -d '{
    "ticket_id": "test-001", 
    "description": "El servicio es terrible y horrible, estoy muy frustrado"
  }'
```

3. Verifica en N8N que el workflow se ejecutó correctamente

### 8. **Personalización**

- **Cambia emails**: Modifica `support@vivetori.com` por tu email
- **Ajusta mensajes**: Personaliza los textos de notificación
- **Agrega canales**: Conecta más servicios de notificación
- **Modifica lógica**: Ajusta las condiciones según tus necesidades

### 🎯 **Resultado Final**

Cuando importes el workflow:
- ✅ Todos los nodos estarán conectados automáticamente
- ✅ La lógica condicional funcionará
- ✅ Solo necesitarás agregar credenciales
- ✅ El flujo estará listo para producción

---

**💡 Tip**: El workflow está diseñado para ser modular. Puedes desactivar nodos opcionales (Slack, Telegram, Discord) si no los necesitas.