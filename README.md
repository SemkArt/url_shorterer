Используем:

* Ruby version - 3.0.1
* Rails 6.1.4.1

## Шаги установки:

* Склонировать репозиторий проекта

* Настройка бд:
  * Создать базы данных и выполнить миграции для development и test окружений:

    ```
    bundle exec rake db:create db:migrate
    RAILS_ENV=test bundle exec rake db:create db:migrate
    ```

* Запустить тесты, что бы убедиться что проект развернут правильно
  ```
  bundle exec rspec
  ```