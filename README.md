# Backend Users Service — Node.js

Servicio REST para la gestión de usuarios, desarrollado con Node.js y Express. Forma parte del proyecto **Innovatech Chile** desplegado en AWS ECS.

## Tecnologías

- **Runtime:** Node.js 18
- **Framework:** Express 4
- **Base de datos:** MySQL 8.0
- **Contenedor:** Docker (imagen base `node:18-alpine`)
- **CI/CD:** GitHub Actions → Amazon ECR → Amazon ECS

## Endpoints

| Método | Ruta | Descripción |
|---|---|---|
| POST | `/api/users/register` | Registrar nuevo usuario |
| GET | `/api/users` | Obtener todos los usuarios |
| GET | `/api/users/:id` | Obtener usuario por ID |
| GET | `/api/users/username/:username` | Obtener usuario por username |
| DELETE | `/api/users/:id` | Eliminar usuario |

## Variables de entorno

```env
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=tu_password
DB_NAME=users_db
PORT=8081
```

## Ejecución local (sin Docker)

```bash
npm install
cp .env.example .env
# edita .env con tus credenciales
node server.js
```

## Ejecución con Docker

```bash
docker build -t backend-users .
docker run -p 8081:8081 --env-file .env backend-users
```

## Ejecución completa con Docker Compose

Desde la carpeta raíz del proyecto:

```bash
docker-compose up --build
```

El servicio estará disponible en `http://localhost:8081`

## Pipeline CI/CD

Cada `push` a la rama `main` dispara el workflow `.github/workflows/deploy.yml` que:

1. **Test** — ejecuta las pruebas disponibles
2. **Build** — construye la imagen Docker
3. **Push** — publica la imagen en Amazon ECR con tag del commit
4. **Deploy** — actualiza el servicio en Amazon ECS Fargate

Los secretos de AWS y base de datos se gestionan mediante **GitHub Secrets**, sin exposición en el código.

## Arquitectura en la nube

El servicio corre en **Amazon ECS Fargate** dentro de una VPC privada, detrás de un **Application Load Balancer** en el puerto 8081. Los logs se envían automáticamente a **Amazon CloudWatch** en el grupo `/ecs/backend-users`.
