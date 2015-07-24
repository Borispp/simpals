Все интересное в /resources/article/article.coffee

Генерация CoffeeScript: из /resources/: coffee -o ../built/js/app/ -bcw ./

**Использую:**
- CoffeeScript (ООП на JS без него совсем грустный)
- Jquery (просто нравится)
- RequireJS, что бы при добавлении новых модулей не было каши.
- Handlebars для создания view каждой статьи.
- Text.js - плагин, что бы Require мог читать файлы с произвольным расширением


При инициализации загружает js/app/app.js, который грузит все указанные модули. Пока это только один модуль Article.
В модуле Article создается экземпляр класса с привязкой к блоку #posts.
И в самом классе есть методы для:
  - Отображения (через заготовленный шаблон Handlebars).
  - Добавления
  - Удаления
  - И потенциального сохранения (при сохранении отдает в console.log текущий localStorage articles)

Валидация идет через required и через JS проверку.

Можно было бы ещё все на gulp поставить, вьюшку articles.html в resources задавать, и gulp-таском переносить в built.

Можно на время подгрузки .json поставить блок loading'а, и в случае success его удалять. Можно на on.keyup 13 добавить валидацию.

Скрипты православно через bower подключать.

Можно добавить .gitignore для генерируемого js из built

Можно работать с localStorage.articles как с нормальным объектом (http://habrahabr.ru/post/144998/)

Возможно придумать что-то более элегантное нежели удаление статей по существующим id, а в противном случае по ключу объекта.
Ну и наверное много чего ещё можно придумать для построения архитектуры на будущее или текущего функционала. Главное, что сейчас работает :)

Хотя мне кажется, что даже текущий вариант для этой задачи овер-инжиниринг =)
