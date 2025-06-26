# ProcessWire Templates - Koriphey Sync System

Система шаблонов ProcessWire для синхронизации между несколькими проектами с современной архитектурой и лучшими практиками.

## 🚀 Быстрый старт

### Для нового проекта:
```bash
# Используйте скрипт автоматической настройки
curl -O https://raw.githubusercontent.com/popskraft/koriphey-pw-template/main/scripts/setup-new-project.sh
chmod +x setup-new-project.sh
./setup-new-project.sh
```

### Для существующего проекта:
```bash
# В корневой папке проекта
cd /path/to/your/project/
git subtree add --prefix=site/templates https://github.com/popskraft/koriphey-pw-template.git main --squash
```

## 📦 Возможности

### 🏗️ Архитектура
- **ProcessWire 3.x** с полной поддержкой API
- **Markup Regions** для гибкого управления выводом
- **Bootstrap 5.3** интеграция с кастомизацией
- **Component-Based блоки** - переиспользуемые блоки контента
- **Автоматическая загрузка функций** из папки `/functions/`

### 🎨 Дизайн и стили
- **Responsive дизайн** с мобильной оптимизацией
- **Двойная система CSS** (с PurgeCSS и без)
- **SCSS модульная архитектура**
- **Кастомные компоненты** Bootstrap

### 🔄 Синхронизация
- **Автоматическая синхронизация** между проектами
- **Исключения** для проект-специфичных файлов
- **Скрипты автоматизации** для удобной работы
- **Git Subtree** интеграция

## 🔄 Синхронизация

### Получение обновлений:
```bash
# Из корневой папки проекта
./scripts/sync-pull.sh
```

### Отправка изменений:
```bash
# Из корневой папки проекта
./scripts/sync-push.sh
```

## 📁 Структура

```
templates/
├── functions/              # PHP функции (автозагрузка)
│   ├── system-*.php        # Системные утилиты
│   ├── Blocks*.php         # Система блоков
│   ├── Header-*.php        # Функции заголовков
│   ├── Menu*.php           # Функции меню
│   ├── *-section.php       # Секции контента
│   └── *-row.php           # Строки/компоненты
├── includes/               # Включаемые файлы
│   ├── blocks/             # Блоки контента
│   ├── contact-form.php    # Контактная форма
│   ├── search-page.php     # Поиск по сайту
│   └── schemaOrg.JSON.php  # Schema.org разметка
├── src/                    # Исходные файлы (SCSS, JS)
│   ├── css/                # SCSS файлы
│   ├── js/                 # JavaScript файлы
│   └── bootstrap/          # Bootstrap исходники
├── plugins/                # JavaScript плагины
│   ├── aos/                # Animate On Scroll
│   ├── flickity/           # Карусель
│   ├── slider/             # Слайдер
│   └── spotlight/          # Лайтбокс галерея
├── scripts/                # Скрипты автоматизации
│   ├── sync-pull.sh        # Получение обновлений
│   ├── sync-push.sh        # Отправка изменений
│   └── setup-new-project.sh # Настройка нового проекта
├── _init.php               # Инициализация ProcessWire
├── _main.php               # Основной шаблон (Markup Regions)
└── *.php                   # Шаблоны страниц
```

## 🎯 Система Markup Regions

### Главный шаблон (`_main.php`)
Определяет базовую HTML структуру с регионами:

```html
<main id="main">
  <div id="mainContainer" pw-optional>
    <div id="pageContent" pw-optional></div>
    <div id="pageBody" pw-optional></div>
  </div>
  <div id="blocks"></div>
</main>
```

### Шаблоны страниц заполняют регионы:
```php
<region pw-prepend="main">
  <?= pageHeaderSecondary() ?>
</region>

<region pw-prepend="pageContent">
  <?= sectionContacts() ?>
</region>
```

### Доступные действия:
- `pw-replace` - заменить содержимое (по умолчанию)
- `pw-append` - добавить в конец
- `pw-prepend` - добавить в начало
- `pw-before` - вставить перед
- `pw-after` - вставить после

## 🧩 Система блоков

### Доступные блоки:
- **Content** - Текстовый контент с заголовками
- **Cover** - Обложка с изображением и CTA
- **Features** - Список особенностей с иконками
- **Gallery** - Фото галерея с лайтбоксом
- **Testimonials** - Отзывы клиентов
- **Timeline** - Временная шкала событий
- **FAQ** - Вопросы и ответы
- **Logos** - Логотипы партнёров

### Использование:
```php
// В шаблоне страницы
<div id="blocks">
  <?= blocks() ?>
</div>

// Или конкретные блоки
<?= blocks($page->custom_blocks) ?>
```

## 🎨 Система стилей

### Двойная система CSS:

**bootstrap.css** (оптимизированная)
- С PurgeCSS для удаления неиспользуемых стилей
- Уменьшение размера на ~75%
- Для продакшена

**bootstrap-nopurge.css** (полная)
- Все компоненты Bootstrap
- Для специальных страниц и отладки

### Кастомизация:
```scss
// theme-variables.scss
$primary: #007bff;
$secondary: #6c757d;
$font-family-base: 'Raleway', sans-serif;

// theme-mixins.scss
@mixin button-variant-custom($color) {
  // Кастомная стилизация
}
```

## 📱 JavaScript архитектура

### Компоненты:
- `main.js` - Основной файл с Bootstrap CDN
- `scroll-detection.js` - Обнаружение прокрутки
- `scroll-to-top.js` - Кнопка "Наверх"
- `carousel-init.js` - Инициализация каруселей

### Плагины:
- **AOS** - Анимация при прокрутке
- **Flickity** - Карусели
- **Spotlight** - Лайтбокс галерея

## 🔧 Основные функции

### Автозагрузка (`_init.php`):
```php
// Все функции из папки functions/ загружаются автоматически
$funDirectory = 'functions/';
if ($handle = opendir($funDirectory)) {
  while (false !== ($file = readdir($handle))) {
    if ('.' === $file || '..' === $file) continue;
    include_once $funDirectory . $file;
  }
  closedir($handle);
}
```

### Системные функции:
- `page()` - Получение данных страницы
- `image()` - Обработка изображений
- `caption()` - Подписи к контенту
- `phone()` - Форматирование телефонов
- `fieldExplode()` - Разбор полей

### Компоненты интерфейса:
- Меню (Header/Footer)
- Навигация (Breadcrumb, Pagination)
- Социальные сети
- Контактные формы
- Новости и персоны

## 🌐 Многоязычность

Система готова к работе с несколькими языками:
- Автоматическое переключение языков
- Поддержка мультиязычных полей
- Локализация интерфейса

## 📚 Документация

- [Инструкции по синхронизации](SYNC-INSTRUCTIONS.md)
- [ProcessWire документация](https://processwire.com/docs/)
- [Bootstrap 5 документация](https://getbootstrap.com/docs/5.3/)
- [Markup Regions](https://processwire.com/docs/front-end/output/markup-regions/)

## 🤝 Участие в разработке

1. Внесите изменения в любом из подключенных проектов
2. Используйте `./scripts/sync-push.sh` для отправки изменений
3. Другие проекты получат обновления через `./scripts/sync-pull.sh`

## 🔧 Проект-специфичные настройки

### Конфигурация для разных проектов/доменов

Система поддерживает различные настройки для разных проектов или доменов. Например, в `home.php`:

```php
// Различные CSS классы в зависимости от домена
if (in_array('filipok.koriphey.ru', $config->httpHosts)) {
  $homeClass = "py-5 min-vh-20";
} else {
  $homeClass = "py-5 mb-5 mb-xl-6 min-vh-25";
}
```

### Рекомендуемый подход

Добавляйте проект-специфичную логику непосредственно в файл с помощью проверки домена:

```php
// В файле home.php или другом шаблоне
if (in_array('filipok.koriphey.ru', $config->httpHosts)) {
  $homeClass = "py-5 min-vh-20";
} elseif (in_array('another-domain.com', $config->httpHosts)) {
  $homeClass = "py-4 min-vh-30";
} else {
  $homeClass = "py-5 mb-5 mb-xl-6 min-vh-25"; // По умолчанию
}
```

Или для более сложной логики:

```php
// Определение настроек на основе домена
$domainSettings = [
  'filipok.koriphey.ru' => [
    'homeClass' => 'py-5 min-vh-20',
    'showSpecialHeader' => true
  ],
  'another-domain.com' => [
    'homeClass' => 'py-4 min-vh-30',
    'showSpecialHeader' => false
  ]
];

$currentHost = $config->httpHost;
$settings = $domainSettings[$currentHost] ?? [
  'homeClass' => 'py-5 mb-5 mb-xl-6 min-vh-25',
  'showSpecialHeader' => false
];

$homeClass = $settings['homeClass'];
```

### Файлы, исключаемые из синхронизации
- `src/css/theme-colors-branch.scss` - цвета темы проекта
- Любые файлы с проект-специфичной логикой

## ⚠️ Важные примечания

- **Резервные копии**: Всегда делайте бэкапы перед синхронизацией
- **Тестирование**: Проверяйте изменения на локальном окружении
- **Исключения**: Используйте `.gitignore` для проект-специфичных файлов
- **Документирование**: Описывайте изменения в коммитах

## 🔗 Связанные проекты

Этот репозиторий используется в:
- Kor-Clever Site
- *(добавьте ваши проекты сюда)*

## 📄 Лицензия

MIT License - см. файл LICENSE для деталей.

---

*Эта система создана для эффективной разработки современных веб-сайтов на ProcessWire с использованием лучших практик и возможностью синхронизации между проектами.* 