(# n8n - Docker Compose + Railway Deployment

This project provides a Docker setup to run n8n with a Postgres database both locally and on Railway.

## Local Development

### Why this project

Running n8n via Docker Compose keeps your system clean and makes it easy to start/stop the full stack (n8n + Postgres) with a single command.

### Where to access n8n locally

Once the containers are running, open your browser at:

http://localhost:5678

**Credentials:**
- Username: admin
- Password: admin123

### How to run locally

Prerequisite: Install Docker and Docker Compose.

- On Linux:

	Install Docker (your distribution package manager or Docker documentation). Then run:

	```bash
	sudo docker compose up -d
	```

	Note: `sudo` is required unless your user is in the `docker` group. To avoid using `sudo` every time, add your user to the `docker` group and re-login:

	```bash
	sudo usermod -aG docker $USER
	newgrp docker
	```

- On Windows (Docker Desktop):

	Install Docker Desktop for Windows and enable WSL2 integration if prompted. Then open a PowerShell or CMD and run:

	```powershell
	docker compose up -d
	```

	On Windows you normally don't need `sudo`.

## Railway Deployment

### Prerequisites

1. **Railway Account**: Sign up at [railway.app](https://railway.app)
2. **Railway CLI** (optional): Install from [railway.app/cli](https://docs.railway.app/develop/cli)

### Step 1: Create Railway Project

1. Go to [railway.app](https://railway.app)
2. Click "New Project"
3. Connect your GitHub repository
4. Select this n8n-workflow folder

### Step 2: Add PostgreSQL Database

1. In your Railway project dashboard
2. Click "New Service" → "Database" → "PostgreSQL"
3. Railway will automatically create a PostgreSQL instance

### Step 3: Configure Environment Variables

In your Railway project, add these environment variables:

```bash
# Authentication
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=your-username
N8N_BASIC_AUTH_PASSWORD=your-secure-password

# Database (Railway will auto-fill these from PostgreSQL service)
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=${{Postgres.PGHOST}}
DB_POSTGRESDB_PORT=${{Postgres.PGPORT}}
DB_POSTGRESDB_DATABASE=${{Postgres.PGDATABASE}}
DB_POSTGRESDB_USER=${{Postgres.PGUSER}}
DB_POSTGRESDB_PASSWORD=${{Postgres.PGPASSWORD}}

# Application
N8N_HOST=0.0.0.0
N8N_PORT=5678
N8N_PROTOCOL=https
NODE_ENV=production

# External URLs (replace with your Railway app domain)
N8N_EDITOR_BASE_URL=https://your-app-name.railway.app
WEBHOOK_URL=https://your-app-name.railway.app
```

### Step 4: Deploy

1. Push your code to GitHub
2. Railway will automatically build and deploy your Docker container
3. Access your n8n instance at the provided Railway URL

### Step 5: Important Railway Considerations

- **Domain**: Railway provides a free `.railway.app` subdomain
- **Custom Domain**: You can add your own domain in Railway settings
- **Environment**: Make sure to use `N8N_PROTOCOL=https` for production
- **Webhooks**: Use your Railway domain for webhook URLs
- **Data Persistence**: PostgreSQL data is automatically persisted by Railway

### Railway CLI Commands (Optional)

If you install Railway CLI:

```bash
# Login to Railway
railway login

# Link to your project
railway link

# Deploy manually
railway up

# View logs
railway logs

# Open project in browser
railway open
```

## Local vs Railway Differences

| Feature | Local | Railway |
|---------|-------|---------|
| Database | Local PostgreSQL container | Railway PostgreSQL service |
| URL | http://localhost:5678 | https://your-app.railway.app |
| Protocol | HTTP | HTTPS |
| Auth | Basic (admin/admin123) | Your custom credentials |
| Data Persistence | Docker volumes | Railway database service |

## Troubleshooting

### Local Development

- If you get a permission error connecting to the Docker socket on Linux, it's usually because your user is not a member of the `docker` group. See the `usermod` command above.
- If the browser can't reach n8n, verify the containers are running:

	```bash
	docker compose ps
	docker compose logs -f n8n
	```

### Railway Deployment

- **Build fails**: Check that all files are committed to git
- **Database connection issues**: Verify environment variables are set correctly
- **n8n not accessible**: Check Railway logs and ensure PORT environment is set to 5678
- **Webhooks not working**: Make sure `WEBHOOK_URL` points to your Railway domain

## Security Notes

- Always change default credentials for production
- Use strong passwords for `N8N_BASIC_AUTH_PASSWORD`
- Consider enabling additional security features for production use
- Railway automatically provides HTTPS certificates

## Files Structure

```
n8n-workflow/
├── Dockerfile              # Docker image definition
├── docker-compose.yml      # Local development setup
├── railway.json            # Railway deployment config
├── start.sh                # Startup script
├── .env.example            # Environment variables template
├── flow.json               # Your n8n workflows (if exported)
└── README.md               # This file
```

Enjoy running n8n with Docker Compose — it's a simple way to try and develop with n8n without installing everything locally.
)
