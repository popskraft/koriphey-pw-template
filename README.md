# ProcessWire Modern Template System

Современная система шаблонов для ProcessWire CMS с использованием передовых технологий и лучших практик веб-разработки.

## 🏗️ Архитектура

### Основные принципы

1. **Template-First подход** - каждая страница привязана к шаблону в `/site/templates/`
2. **Markup Regions** - гибкая система инъекции контента в HTML регионы
3. **Модульная архитектура** - разделение функциональности на компоненты
4. **Component-Based блоки** - переиспользуемые блоки контента
5. **Автоматическая загрузка функций** - все функции из `/functions/` загружаются автоматически

### Ключевые особенности

- **ProcessWire 3.x** с полной поддержкой API
- **Bootstrap 5.3** интеграция с настраиваемой системой сборки
- **Markup Regions** для гибкого управления выводом
- **SEO Maestro** интеграция для продвинутого SEO
- **Многоязычность** с автоматическим переключением
- **Модульная система блоков** для создания контента
- **Responsive Design** с мобильной оптимизацией

## 📁 Структура проекта

```
/site/templates/
├── _init.php                 # Инициализация и глобальные переменные
├── _main.php                 # Главный HTML шаблон с Markup Regions
├── home.php                  # Шаблон главной страницы  
├── page-default.php          # Шаблон обычных страниц
├── category-*.php            # Шаблоны категорий
├── admin.php                 # Административный шаблон
├── form-builder.php          # Шаблон для форм
│
├── functions/                # PHP функции (автозагрузка)
│   ├── system-*.php          # Системные утилиты
│   ├── Blocks*.php           # Система блоков
│   ├── Header-*.php          # Функции заголовков
│   ├── Menu*.php             # Функции меню
│   ├── *-section.php         # Секции контента
│   └── *-row.php             # Строки/компоненты
│
├── includes/                 # Включаемые файлы
│   ├── blocks/               # Блоки контента
│   ├── contact-form.php      # Контактная форма
│   ├── search-page.php       # Поиск по сайту
│   └── schemaOrg.JSON.php    # Schema.org разметка
│
├── src/                      # Исходные файлы для сборки
│   ├── css/                  # SCSS файлы
│   │   ├── bootstrap.scss    # Главный SCSS (с PurgeCSS)
│   │   ├── bootstrap-nopurge.scss # Полная версия Bootstrap
│   │   ├── theme-*.scss      # Тематические стили
│   │   └── _*.scss           # Компоненты стилей
│   ├── js/                   # JavaScript файлы
│   │   └── main.js           # Главный JS файл
│   └── bootstrap/            # Bootstrap исходники
│
├── dist/                     # Скомпилированные файлы (автогенерация)
│   ├── css/                  # Готовые CSS файлы
│   └── js/                   # Готовые JS файлы
│
└── plugins/                  # Сторонние плагины
    ├── aos/                  # Animate On Scroll
    ├── flickity/             # Карусель
    ├── slider/               # Слайдер
    └── spotlight/            # Лайтбокс галерея
```

## 🎯 Система Markup Regions

Проект использует ProcessWire Markup Regions для гибкого управления выводом:

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

### Шаблоны страниц
Заполняют регионы контентом:

```php
<region pw-prepend="main">
  <?= pageHeaderSecondary() ?>
</region>

<region pw-prepend="pageContent">
  <?= sectionContacts() ?>
</region>
```

### Доступные действия
- `pw-replace` - заменить содержимое (по умолчанию)
- `pw-append` - добавить в конец
- `pw-prepend` - добавить в начало
- `pw-before` - вставить перед
- `pw-after` - вставить после

## 🧩 Система блоков

### Основная функция блоков
```php
function blocks($infoBlocks="") {
  $infoBlocks = $infoBlocks ?: page("blocks");
  if (isset($infoBlocks) && count($infoBlocks)) {
    foreach ($infoBlocks as $bID) {
      $bID = ($bID->blocks_selectblock) ? $bID->blocks_selectblock : $bID;
      include "includes/blocks/{$bID->blocks_type->value}.php";
    }
  }
}
```

### Доступные блоки
- `content` - Текстовый контент
- `cover` - Обложка с изображением
- `features` - Список особенностей
- `gallery` - Фото галерея
- `testimonials` - Отзывы
- `timeline` - Временная шкала
- `faq` - Вопросы и ответы
- `logos` - Логотипы партнёров

### Структура блока
Каждый блок состоит из:
1. **Header** (`blockHeader()`) - заголовок и описание
2. **Content** - основное содержимое
3. **Footer** (`blockFooter()`) - завершение блока

## 🎨 Система стилей

### Двойная система CSS

**bootstrap.css** (с PurgeCSS)
- Оптимизированная версия для продакшена
- Автоматическое удаление неиспользуемых стилей
- Уменьшение размера на ~75%

**bootstrap-nopurge.css** (полная версия)
- Все компоненты Bootstrap
- Для специальных страниц и отладки

### Кастомизация

**theme-variables.scss**
```scss
// Переопределение переменных Bootstrap
$primary: #007bff;
$secondary: #6c757d;
$font-family-base: 'Raleway', sans-serif;
```

**theme-mixins.scss**
```scss
// Пользовательские миксины
@mixin button-variant-custom($color) {
  // Кастомная стилизация кнопок
}
```

## 📱 JavaScript архитектура

### Главный файл (`main.js`)
```javascript
// Bootstrap загружается из CDN
// CodeKit сборка с директивами @codekit-append
// @codekit-append "scroll-detection.js";
// @codekit-append "carousel-init.js";
```

### Компоненты
- `scroll-detection.js` - Обнаружение прокрутки
- `scroll-to-top.js` - Кнопка "Наверх"
- `carousel-init.js` - Инициализация каруселей

## 🔧 Функциональность

### Автозагрузка функций (`_init.php`)
```php
$funDirectory = 'functions/';
if ($handle = opendir($funDirectory)) {
  while (false !== ($file = readdir($handle))) {
    if ('.' === $file || '..' === $file) continue;
    include_once $funDirectory . $file;
  }
  closedir($handle);
}
```

### Системные функции

**Навигация**
- `menuHeader()` - Главное меню
- `menuFooter()` - Меню подвала
- `langSwitcher()` - Переключатель языков
- `breadcrumb()` - Хлебные крошки

**Контент**
- `caption()` - Переводы текста
- `summarize()` - Создание сводки
- `fieldExplode()` - Разбор полей
- `phone()` - Форматирование телефонов

**Изображения**
- `image()` - Вывод изображений
- `logo()` - Логотипы сайта
- `galleryLightbox()` - Галерея с лайтбоксом

### SEO и метаданные

**SEO Maestro интеграция**
```php
$seoMaestro = page("seo_maestro");

// Хук для модификации SEO данных
$wire->addHookAfter("SeoMaestro::renderSeoDataValue", function (HookEvent $event) {
  // Автоматическое заполнение описаний
  // Управление OG изображениями
});
```

**Schema.org разметка**
- Автоматическая генерация JSON-LD
- Поддержка организации, веб-сайта, статей
- Интеграция с настройками сайта

## 🌐 Многоязычность

### Поддержка языков
```php
// Генерация альтернативных ссылок
foreach ($languages as $language) {
  $langIndex = ($language->title == "ru") ? "" : $language->title;
  $alternateLinks .= '<link rel="alternate" hreflang="' . $language->title . '" href="' . $rootUrl . $langIndex . '">';
}
```

### Переводы
```php
// Система переводов через caption()
echo caption('contacts_title_address'); // Получить перевод
echo caption('email'); // Системный перевод
```

## 🔍 Поиск по сайту

### Функциональность поиска
```php
// Поиск по шаблонам
$selectorAll = "template=page-news|page-articles|page-default, 
                title|text_longtitle|text_summary|text_body~|%=$q, 
                sort=-sort, limit=$limit";

// Рендеринг результатов
function renderList(PageArray $items) {
  // Форматированный вывод результатов
}
```

## ⚙️ Настройки сайта

### Глобальные переменные
```php
// Настройки из страницы /settings/
$siteSettings = pages('/settings/');
$siteData = $siteSettings->site_data;
$menuHeader = $siteSettings->menu_header;
$socials = $siteSettings->socials;
```

### Контактная информация
- Телефоны (основной, дополнительный)
- Email адреса
- Мессенджеры (WhatsApp, Telegram)
- Адрес и карта
- Социальные сети

## 🚀 Производительность

### Оптимизации
- **PurgeCSS** - удаление неиспользуемых стилей
- **Lazy Loading** - отложенная загрузка изображений
- **CDN Bootstrap** - загрузка из внешнего CDN
- **Минификация** - сжатие CSS и JS
- **Кэширование** - ProcessWire кэш страниц

### Метрики
- CSS с PurgeCSS: ~84KB
- CSS без PurgeCSS: ~327KB
- Экономия: ~75% размера

## 🛠️ Разработка

### Рекомендации по кодированию

1. **Пространства имён** - всегда используйте `namespace ProcessWire;`
2. **Функции vs переменные** - предпочитайте `page('title')` вместо `$page->title`
3. **Безопасность** - всегда санитизируйте ввод пользователей
4. **Markup Regions** - используйте для управления выводом
5. **Модульность** - создавайте переиспользуемые функции

### Структура функций
```php
<?php namespace ProcessWire;

function functionName($param = "", $class = "") {
  $param = $param ?: page();
  $class = $class ?: "default-class";
  
  $out = "<div class='$class'>";
  // Логика функции
  $out .= "</div>";
  
  return $out;
}
```

### Безопасность
```php
// Санитизация входных данных
$q = $sanitizer->text($input->get->q);
$id = $sanitizer->int($input->post->id);

// Экранирование вывода
echo $sanitizer->entities($userInput);
```

## 📋 Структура страниц

### Типы шаблонов
- `home` - Главная страница
- `page-default` - Обычные страницы
- `page-contacts` - Страница контактов
- `page-news` - Новостные статьи
- `page-person` - Персональные страницы
- `category-*` - Категории (новости, FAQ, работа)

### Поля страниц
- `title` - Заголовок
- `text_longtitle` - Расширенный заголовок
- `text_summary` - Краткое описание
- `text_body` - Основной текст
- `images_main` - Главные изображения
- `blocks` - Блоки контента
- `date_start` - Дата начала (события)

## 🎨 Компоненты интерфейса

### Навигация
- Адаптивное главное меню
- Мобильная навигация с гамбургером
- Переключатель языков
- Социальные сети

### Контент блоки
- Обложки с изображениями
- Галереи с лайтбоксом
- Карусели и слайдеры
- Временные шкалы
- FAQ аккордеоны

### Формы
- Контактные формы
- Модальные окна
- Валидация полей
- Защита от спама

## 📱 Адаптивность

### Breakpoints
```scss
// Bootstrap 5.3 breakpoints
$grid-breakpoints: (
  xs: 0,
  sm: 576px,
  md: 768px,
  lg: 992px,
  xl: 1200px,
  xxl: 1400px
);
```

### Мобильные функции
- Мобильное меню
- Фиксированная нижняя навигация
- Адаптивные изображения
- Touch-friendly интерфейс

## 🔧 Настройка и развёртывание

### Требования
- ProcessWire 3.x
- PHP 7.4+
- Apache/Nginx с mod_rewrite
- MySQL/MariaDB

### Установка
1. Разместить файлы в `/site/templates/`
2. Настроить конфигурацию ProcessWire
3. Создать необходимые поля и шаблоны
4. Настроить страницу `/settings/` с данными сайта

### Конфигурация ProcessWire
```php
// В config.php
$config->useMarkupRegions = true;
$config->appendTemplateFile = '_main.php';
```

## 📚 Документация ProcessWire

- [Markup Regions](https://processwire.com/docs/front-end/output/markup-regions/)
- [Template System](https://processwire.com/docs/tutorials/how-to-structure-your-template-files/)
- [API Reference](https://processwire.com/api/ref/)
- [Field Types](https://processwire.com/docs/fields/)

---

*Этот шаблон создан для эффективной разработки современных веб-сайтов на ProcessWire с использованием лучших практик и современных технологий.* 