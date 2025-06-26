#!/bin/bash

# Скрипт для получения обновлений шаблонов из основного репозитория
# Использовать из корневой папки проекта (где есть папка site)

REPO_URL="https://github.com/popskraft/koriphey-pw-template.git"
TEMPLATES_PATH="site/templates"

echo "🔄 Синхронизация шаблонов ProcessWire..."
echo "📥 Получение обновлений из $REPO_URL"

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

# Выполняем subtree pull
if git subtree pull --prefix=$TEMPLATES_PATH $REPO_URL main --squash; then
    echo "✅ Шаблоны успешно обновлены!"
    echo "📋 Проверьте изменения и протестируйте функциональность"
else
    echo "❌ Ошибка при обновлении шаблонов"
    echo "🔧 Возможно, есть конфликты, которые нужно разрешить вручную"
    exit 1
fi 