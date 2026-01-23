# 🔄 Diagrama Visual del Workflow N8N - VIVETORI

```
                        📱 BACKEND PYTHON
                              │
                              │ POST webhook
                              ▼
                    🎯 Webhook - Ticket Procesado
                         (ID: 5ec1e629-d6db-...)
                              │
                              │ Recibe datos del ticket
                              ▼
                    🤔 ¿Sentimiento Negativo?
                         (if sentiment === "Negativo")
                              │
                    ┌─────────┼─────────┐
                    │         │         │
                SI  │         │         │  NO
                    ▼         ▼         ▼
          📧 Email     💬 Slack    ✅ Ticket OK
             │          │           │
             │          │           ▼
             │     📱 Telegram  🎮 Discord
             │          │       (Log normal)
             │          │
             └────┬─────┘
                  │
                  ▼
            📊 Log en Supabase
           (Registra notificación)
```

## 🔌 Conexiones Específicas

### **Nodo 1: 🎯 Webhook - Ticket Procesado**
- **Tipo**: Webhook Trigger
- **URL**: `/webhook/5ec1e629-d6db-4290-a81d-61a71b3b7883`
- **Conecta a**: `🤔 ¿Sentimiento Negativo?`

### **Nodo 2: 🤔 ¿Sentimiento Negativo?**
- **Tipo**: Condicional (IF)
- **Condición**: `{{ $json.sentiment }} === "Negativo"`
- **Salida TRUE conecta a**:
  - `📧 Enviar Email de Alerta`
  - `💬 Notificar Slack (Opcional)`
  - `📱 Notificar Telegram (Opcional)`
- **Salida FALSE conecta a**:
  - `✅ Ticket OK - Sin Alerta`

### **Nodo 3: 📧 Enviar Email de Alerta**
- **Tipo**: Email Send
- **Para**: support@vivetori.com
- **Conecta a**: `📊 Log en Supabase`

### **Nodo 4: 💬 Notificar Slack (Opcional)**
- **Tipo**: HTTP Request
- **URL**: Webhook de Slack
- **Conecta a**: `📊 Log en Supabase`

### **Nodo 5: 📱 Notificar Telegram (Opcional)**
- **Tipo**: HTTP Request  
- **URL**: API de Telegram
- **Conecta a**: `📊 Log en Supabase`

### **Nodo 6: 📊 Log en Supabase**
- **Tipo**: Supabase Insert
- **Tabla**: ticket_logs
- **Fin del flujo para tickets negativos**

### **Nodo 7: ✅ Ticket OK - Sin Alerta**
- **Tipo**: Set Values
- **Para**: Tickets neutros/positivos
- **Conecta a**: `🎮 Log Discord (Opcional)`

### **Nodo 8: 🎮 Log Discord (Opcional)**
- **Tipo**: Discord Webhook
- **Para**: Log de tickets normales
- **Fin del flujo para tickets normales**

## 📨 Datos que Recibe el Webhook

```json
{
  "ticket_id": "uuid-del-ticket",
  "message": "Ticket requires attention - Negative sentiment detected",
  "severity": "high",
  "timestamp": "2026-01-22T23:45:00.000Z",
  "category": "Técnico|Soporte|Facturación",
  "sentiment": "Negativo|Neutral|Positivo", 
  "confidence": 0.85,
  "processing_time": "0.02s",
  "description": "Texto completo del ticket...",
  "notification_sent": true,
  "workflow_trigger": "ai_support_copilot",
  "source": "vivetori_backend"
}
```

## 🚦 Flujo de Decisión

1. **Webhook recibe datos** → Ticket procesado por IA
2. **Evalúa sentimiento** → ¿Es "Negativo"?
3. **SI Negativo** → Envía notificaciones urgentes (Email + Slack + Telegram)
4. **NO Negativo** → Solo registra como OK (Discord opcional)
5. **Log final** → Registra en Supabase o Discord según el caso

## 🎯 Resultado

- **Tickets Negativos**: Notificación inmediata multi-canal
- **Tickets Normales**: Procesado silencioso con log opcional
- **100% Automatizado**: Sin intervención manual requerida