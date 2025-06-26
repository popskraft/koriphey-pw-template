#!/bin/bash

# Скрипт для отправки изменений шаблонов в основной репозиторий
# Использовать из корневой папки проекта (где есть папка site)

REPO_URL="https://github.com/popskraft/koriphey-pw-template.git"
TEMPLATES_PATH="site/templates"

echo "🔄 Синхронизация шаблонов ProcessWire..."
echo "📤 Отправка изменений в $REPO_URL"

# Проверяем, находимся ли мы в правильной директории
if [ ! -d "site" ]; then
    echo "❌ Ошибка: Запустите скрипт из корневой папки проекта (где есть папка site)"
    exit 1
fi

# Проверяем, является ли это Git репозиторием
if [ ! -d ".git" ]; then
    echo "❌ Ошибка: Это не Git репозиторий. Инициализируйте Git сначала."
    exit 1
fi

# Проверяем, есть ли изменения для коммита
if git diff --quiet && git diff --cached --quiet; then
    echo "⚠️  Нет изменений для отправки"
    exit 0
fi

# Запрашиваем сообщение коммита
echo "💬 Введите сообщение коммита (или нажмите Enter для автоматического):"
read -r COMMIT_MSG

if [ -z "$COMMIT_MSG" ]; then
    COMMIT_MSG="Update templates from $(basename $(pwd)) - $(date '+%Y-%m-%d %H:%M')"
fi

# Коммитим изменения
echo "📝 Создание коммита: $COMMIT_MSG"
if git add . && git commit -m "$COMMIT_MSG"; then
    echo "✅ Изменения зафиксированы"
else
    echo "❌ Ошибка при создании коммита"
    exit 1
fi

# Выполняем subtree push
echo "🚀 Отправка в основной репозиторий..."
if git subtree push --prefix=$TEMPLATES_PATH $REPO_URL main; then
    echo "✅ Изменения успешно отправлены в основной репозиторий!"
    echo "🌐 Другие проекты могут получить обновления с помощью sync-pull.sh"
else
    echo "❌ Ошибка при отправке изменений"
    echo "🔧 Возможно, нужно сначала получить обновления с помощью sync-pull.sh"
    exit 1
fi 