# Инструкции по синхронизации ProcessWire Templates

Этот репозиторий предназначен для синхронизации шаблонов ProcessWire между несколькими проектами с использованием **Git Subtree**.

## Git Subtree - Основной метод синхронизации

### Настройка существующего проекта (как этот):
```bash
# В папке templates вашего проекта
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/popskraft/koriphey-pw-template.git
git branch -M main
git push -u origin main
```

### Подключение к новому проекту:
```bash
# В корневой папке нового проекта
cd /path/to/new/project/
git subtree add --prefix=site/templates https://github.com/popskraft/koriphey-pw-template.git main --squash
```

### Синхронизация изменений:

#### Получить обновления: кто был вообще что мы могли просто
```bash
git subtree pull --prefix=site/templates https://github.com/popskraft/koriphey-pw-template.git main --squash
```

#### Отправить изменения:
```bash
git subtree push --prefix=site/templates https://github.com/popskraft/koriphey-pw-template.git main
```

## Автоматизация с помощью скриптов

Для упрощения работы созданы готовые скрипты:

### Настройка нового проекта:
```bash
# Скачать и запустить скрипт настройки
curl -O https://raw.githubusercontent.com/popskraft/koriphey-pw-template/main/scripts/setup-new-project.sh
chmod +x setup-new-project.sh
./setup-new-project.sh
```

### Ежедневная работа:
```bash
# Получить обновления из основного репозитория
./scripts/sync-pull.sh

# Отправить ваши изменения в основной репозиторий
./scripts/sync-push.sh
```

## Исключения из синхронизации

Файл `.gitignore` автоматически исключает:
- Конфигурационные файлы (`config.codekit3`, `.env`)
- Скомпилированные файлы (`dist/`, `*.min.*`)
- Кэш и временные файлы
- IDE и системные файлы
- Страницы ошибок (специфичные для проекта)

## Рабочий процесс

1. **Внесите изменения** в любом подключенном проекте
2. **Отправьте изменения**: `./scripts/sync-push.sh`
3. **Получите обновления** в других проектах: `./scripts/sync-pull.sh`

## Решение конфликтов

Если возникают конфликты при синхронизации:
1. Git покажет файлы с конфликтами
2. Откройте файлы и разрешите конфликты вручную
3. Зафиксируйте изменения: `git add .` и `git commit`
4. Повторите команду синхронизации

## Важные примечания

- 🔒 **Безопасность**: Всегда делайте резервные копии
- 🧪 **Тестирование**: Проверяйте изменения локально
- 📝 **Документирование**: Описывайте изменения в коммитах
- 🌿 **Ветки**: Используйте отдельные ветки для экспериментов 