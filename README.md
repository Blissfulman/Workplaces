# Приложение Workplaces

**Краткое описание**:

1. Реализована слоистая сервис-ориентированная архитектура.
2. Реализовано сетевое взвимодействие с сервером с использованием библиотеки Apexy.
3. Архитектура - MVC.
4. UI выполнен в соответствии с дизайном.
5. Там, где это было необходимо, реализован потокобезопасный доступ к данным.
6. Установлена защита входа для выполнения требований безопасности.
7. Написаны Unit-тесты, покрывающие бизнес-логику.

**Что не было реализовано**:

1. Защита пароля биометрией (не стал делать, т.к. нет возможности тестировать на реальном устройстве).
2. Выбор геолокации при публикации поста, отображение геолокации в постах (не успел).

**Что можно доработать**:

1. Больше кода покрыть тестами.
2. Обновление таблиц при изменении содержимого выполянть без полной перезагрузки данных там, где это целесообразно.
3. Более полноценно использовать подход с кастомными классами элементов UI.