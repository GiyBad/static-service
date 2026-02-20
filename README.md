# ClassicBrawl Server on Render

Этот проект запускает сервер Brawl Stars с туннелем Playit.gg.

## Инструкция по запуску:
1. Дождитесь завершения сборки во вкладке **Logs**.
2. Найдите строку `Use this link to claim your agent`.
3. Перейдите по ссылке и настройте туннель на сайте Playit.gg:
   - **Type:** TCP
   - **Port:** 9339
4. После активации используйте IP туннеля для подключения в APK.

## Файлы:
- `main.py`: Основной код сервера.
- `Dockerfile`: Инструкция по сборке образа Ubuntu + Python + Playit.
- `requirements.txt`: Зависимости (tinydb, colorama).
