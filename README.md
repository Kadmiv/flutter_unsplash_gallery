# flutter_unsplash_gallery

Пример работы с Unsplash


## Описание.

Архитектура приложения в основном MVP, кроме основного класса main_page (так как логики там и нет практически).
Для работы с Api есть одельный класс - api_helper
Так же используется DI

В приложении есть:

2 таба:
- Таб просмотра списка изображений, который подгружаются при load_more
(Использовал чей-то список, есть свои косяки - нет возможности расширения (нужно ковырять код), но в 
принципе работает наромально)
- Таб просмотра и поиска изображения по запросу - данного запроса на реализацию нету в ТЗ, но я решил 
немного поиграться, поексперементировал с search_view и пр.

3 скрина:
- список изображений (*- мини изображение с названием и автором* - я указываю автора и описание, навзание нет в json-e )
- изображение на весь экран (Думал добавить возможность пролистывать картинки, но не стал 
    заморачиваться - хоть и принципиально ничего сложного не дожно быть, 
    но пришлось бы добавлять список слушателей для дозагрузки данных не несколько скринов одновременно,
    ну или что-то в этом роде)
- список + поиск

Перед запросамы проводится проверка на наличия коннекта - корявая, но рабочая :)
Есть либа (подтянута) которая помогает понять, что из вариантов подключено для коннекта - но связи
то всё равно может не быть.


## * Также напишите какие (из списка ниже) и как технологии, подходы использовались в вашем тестовом задании*
- Printing to the console - хотел использовать логер (и использовал), но потом решил отказаться
- Asynchronous programming (Futures, async, await) - юзал, запросы и пр.
- reuse of a widget - переиспользую нескольк виджетов - connection_error_widget, image_item_widget
- assets - один ассет есть, картинка для ошибки соединения 
- load images over a network - использую CachedNetworkImage
- ThemeData class - вот ксати на счёт темы не подумал
- shared_preferences plugin - а он тут вообще нужен ?
- TabController - сам котроллер не писал - так как использовл стандартную штуку
- Drawer - не добавлял
- http package - юзал
- Animation, AnimationController, FadeTransition, Dismissible - на счёт анимации, ничего не использовал, 
    кроме стандартного перехода по Hero.

## Список того, что я думаю не стоит тут описывать (и так вроде понятно):
assigning variables
Checking for null or zero
StatefulWidget, StatelessWidget
widgets (Layout widgets, ListView)
TextStyle
Material library
widget tree
constructor
Route, Navigator
TabBar, Tab, TabBarView

## Бока которые я вижу здесь:
- это не очень красивая обработка и вывод ошибок связки и загрузки данных ( в некоторой степени, это 
сязано с виджетом дозагрузки данных)
- так себе дизайн ) ахах

## Что по времени?
В общей сложности усшло где-то 12 часов
Основную часть времени убил на основную логику с ТЗ где-то 8 часов ( пришлось повозиться с отображением изображениий в списке)
Остальыные 4 - это доделываине доп. логики (поиск) и обработка разного рода ошибок




