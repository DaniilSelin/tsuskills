# TSU Skills

Университетская платформа для поиска вакансий, стажировок и подбора кандидатов по навыкам.

## Архитектура

```
                     ┌─────────────────────┐
                     │   Flutter Frontend   │
                     │  (Web/Android/iOS)   │
                     └──────────┬──────────┘
                                │ :8000
                     ┌──────────▼──────────┐
                     │    API Gateway       │
                     │  JWT, CORS, proxy    │
                     └──┬───────┬───────┬──┘
                        │       │       │
              ┌─────────▼┐  ┌──▼────┐  ┌▼──────────┐
              │  users    │  │  db   │  │  skills    │
              │  :8081    │  │manager│  │  :8082     │
              │           │  │ :8080 │  │            │
              │ Auth      │  │       │  │ Skills     │
              │ Profiles  │  │Vacancy│  │ Resumes    │
              │ JWT       │  │ CRUD  │  │ Orgs       │
              └─────┬─────┘  │Search │  │ Apps       │
                    │        └┬────┬─┘  └──────┬─────┘
                    ▼         ▼    ▼           ▼
              ┌─────────┐ ┌─────┐┌────────┐┌───────┐
              │Postgres │ │ PG  ││OpenSrch││  PG   │
              │ users   │ │vacnc││ :9200  ││skills │
              │ :5433   │ │:5434│└────────┘│ :5435 │
              └─────────┘ └─────┘          └───────┘
```

## Сервисы

| Сервис | Порт | Описание | Стек |
|--------|------|----------|------|
| **gateway** | 8000 | API Gateway — JWT, CORS, routing | Go, gorilla/mux |
| **users** | 8081 | Auth, профили, JWT access/refresh | Go, pgx, bcrypt |
| **dbmanager** | 8080 | Вакансии CRUD + полнотекстовый поиск | Go, pgx, OpenSearch |
| **skills** | 8082 | Навыки, резюме, организации, отклики | Go, pgx |
| **frontend** | — | Клиентское приложение | Flutter, BLoC |

## Быстрый старт

### Требования

- Docker 20+ и Docker Compose v2
- (для фронтенда) Flutter SDK 3.8+

### 1. Клонировать с сабмодулями

```bash
git clone --recurse-submodules https://github.com/DaniilSelin/tsuskills.git
cd tsuskills
```

Если уже клонировали без `--recurse-submodules`:

```bash
git submodule update --init --recursive
```

### 2. Поднять весь бэкенд

```bash
docker compose up --build -d
```

или:

```bash
make up
```

Дождитесь ~30 секунд, затем проверьте:

```bash
docker compose ps        # все healthy/running
curl localhost:8000/health   # все сервисы ok
```

### 3. Запустить фронтенд

```bash
cd frontend/tsu_skills
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d chrome
```

Фронтенд обращается к `http://localhost:8000` (gateway).

## API Reference

Единая точка входа — `http://localhost:8000`.

### Без авторизации

```
POST  /api/v1/users/register       Регистрация
POST  /api/v1/users/login          Вход
POST  /api/v1/users/refresh        Обновить токен
GET   /health                      Здоровье сервисов
```

### С авторизацией (`Authorization: Bearer <token>`)

**Users**
```
GET     /api/v1/users/auth         Проверка токена
GET     /api/v1/users/me           Мой профиль
GET     /api/v1/users/{id}         Профиль по ID
PUT     /api/v1/users/{id}         Обновить профиль
DELETE  /api/v1/users/{id}         Удалить аккаунт
```

**Vacancies**
```
POST    /api/v1/vacancies              Создать
GET     /api/v1/vacancies              Список (?employer_id= для своих)
GET     /api/v1/vacancies/{id}         По ID
PUT     /api/v1/vacancies/{id}         Обновить
DELETE  /api/v1/vacancies/{id}         Удалить
POST    /api/v1/vacancies/search       Полнотекстовый поиск
```

**Skills**
```
GET     /api/v1/skills?q=              Поиск навыков
POST    /api/v1/skills                 Создать
DELETE  /api/v1/skills/{id}            Удалить
```

**Organizations**
```
POST    /api/v1/organizations          Создать
GET     /api/v1/organizations/my       Моя организация (?director_id=)
GET     /api/v1/organizations/{id}     По ID
PUT     /api/v1/organizations/{id}     Обновить
DELETE  /api/v1/organizations/{id}     Удалить
```

**Resumes**
```
POST    /api/v1/resumes                Создать
GET     /api/v1/resumes                Мои резюме (?user_id=)
GET     /api/v1/resumes/{id}           По ID
PUT     /api/v1/resumes/{id}           Обновить
DELETE  /api/v1/resumes/{id}           Удалить
```

**Applications**
```
POST    /api/v1/applications           Откликнуться
GET     /api/v1/applications           Список (?vacancy_id= или ?user_id=)
GET     /api/v1/applications/{id}      По ID
```

### Пример

```bash
# Регистрация
curl -s -X POST localhost:8000/api/v1/users/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Иван","email":"ivan@tsu.ru","password":"secret123"}' | jq

# Логин
TOKEN=$(curl -s -X POST localhost:8000/api/v1/users/login \
  -H "Content-Type: application/json" \
  -d '{"email":"ivan@tsu.ru","password":"secret123"}' | jq -r .access_token)

# Создать вакансию
curl -s -X POST localhost:8000/api/v1/vacancies \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"employer_id":"...", "title":"Go Developer", ...}' | jq
```

## Структура репозитория

```
tsuskills/
├── docker-compose.yml       Оркестрация всего стека
├── Makefile                 Утилитарные команды
├── README.md
├── .gitmodules
├── gateway/          [submodule]  API Gateway
├── users/            [submodule]  Сервис пользователей
├── dbmanager/        [submodule]  Сервис вакансий
├── skills/           [submodule]  Навыки, резюме, орги, отклики
└── frontend/         [submodule]  Flutter-приложение
```

Внутри каждого Go-сервиса:

```
service/
├── cmd/server/main.go          Точка входа
├── config/                     YAML-конфиги (local + docker)
├── docker/Dockerfile
├── go.mod
└── internal/
    ├── delivery/               HTTP-слой
    │   ├── dto/                Request/Response модели
    │   ├── http/handler/       Обработчики
    │   ├── http/routes.go      Роутер
    │   ├── http/middleware.go  Middleware
    │   ├── mapper/             DTO ↔ Domain
    │   └── validator/          Валидация
    ├── domain/                 Бизнес-модели и ошибки
    ├── infra/postgres/         Подключение + миграции
    ├── repository/             Работа с БД
    ├── service/                Бизнес-логика
    └── logger/                 Zap-логгер
```

## Команды

```bash
make up       Поднять всё
make down     Остановить
make clean    Остановить + удалить данные
make build    Пересобрать образы
make logs     Логи всех сервисов
make log s=X  Логи сервиса X (gateway, users-service, ...)
make ps       Статус контейнеров
make health   Health check через gateway
make init     Инициализировать сабмодули
make pull     Обновить сабмодули
```

## Конфигурация

JWT secret должен совпадать в `users` и `gateway`:
- `users/config/config.*.yaml` → `jwt.secret_key`
- `gateway/config/config.*.yaml` → `jwt.secret_key`

Адрес gateway для фронтенда:
- `frontend/tsu_skills/lib/shared/lib/api/client/api_config.dart`

## Стек

**Backend:** Go 1.23 · gorilla/mux · pgx/v5 · OpenSearch 2.14 · JWT · bcrypt · zap · viper

**Frontend:** Flutter 3.8 · BLoC · auto_route · freezed · injectable · fpdart

**Infra:** Docker · PostgreSQL 16 · OpenSearch 2.14

## Авторы

- [DaniilSelin](https://github.com/DaniilSelin) — backend
- [Artvell3000](https://github.com/Artvell3000) — frontend
