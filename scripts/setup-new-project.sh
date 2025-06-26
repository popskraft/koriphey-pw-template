#!/bin/bash

# Скрипт для подключения нового проекта к синхронизации шаблонов
# Запускать из корневой папки нового проекта

REPO_URL="https://github.com/popskraft/koriphey-pw-template.git"
TEMPLATES_PATH="site/templates"

echo "🚀 Настройка синхронизации шаблонов ProcessWire для нового проекта"
echo "📦 Репозиторий: $REPO_URL"

# Проверяем, находимся ли мы в правильной директории
if [ ! -d "site" ]; then
    echo "❌ Ошибка: Запустите скрипт из корневой папки проекта (где должна быть папка site)"
    echo "📁 Создать папку site? (y/n)"
    read -r CREATE_SITE
    if [ "$CREATE_SITE" = "y" ] || [ "$CREATE_SITE" = "Y" ]; then
        mkdir -p site
        echo "✅ Папка site создана"
    else
        exit 1
    fi
fi

# Инициализируем Git если нужно
if [ ! -d ".git" ]; then
    echo "🔧 Инициализация Git репозитория..."
    git init
    echo "✅ Git репозиторий инициализирован"
fi

# Проверяем, существует ли уже папка templates
if [ -d "$TEMPLATES_PATH" ]; then
    echo "⚠️  Папка $TEMPLATES_PATH уже существует"
    echo "🗑️  Удалить существующую папку и заменить на синхронизируемую? (y/n)"
    read -r REPLACE_TEMPLATES
    if [ "$REPLACE_TEMPLATES" = "y" ] || [ "$REPLACE_TEMPLATES" = "Y" ]; then
        echo "🔄 Создание резервной копии..."
        mv "$TEMPLATES_PATH" "${TEMPLATES_PATH}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "✅ Резервная копия создана"
    else
        echo "❌ Отменено пользователем"
        exit 1
    fi
fi

# Добавляем subtree
echo "📥 Добавление шаблонов как subtree..."
if git subtree add --prefix=$TEMPLATES_PATH $REPO_URL main --squash; then
    echo "✅ Шаблоны успешно добавлены!"
else
    echo "❌ Ошибка при добавлении шаблонов"
    exit 1
fi

# Копируем скрипты синхронизации
echo "📋 Копирование скриптов синхронизации..."
mkdir -p scripts
cp "$TEMPLATES_PATH/scripts/sync-pull.sh" scripts/
cp "$TEMPLATES_PATH/scripts/sync-push.sh" scripts/
chmod +x scripts/sync-pull.sh scripts/sync-push.sh

echo "✅ Настройка завершена!"
echo ""
echo "📚 Следующие шаги:"
echo "1. Настройте ProcessWire в папке site/"
echo "2. Используйте scripts/sync-pull.sh для получения обновлений"
echo "3. Используйте scripts/sync-push.sh для отправки изменений"
echo "4. Прочитайте $TEMPLATES_PATH/SYNC-INSTRUCTIONS.md для подробностей" 