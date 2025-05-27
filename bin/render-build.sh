#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate

# Ejecutar seeds solo si no hay registros en la tabla de libros
# Necesitamos usar rails runner para ejecutar código Ruby y verificar la base de datos
bundle exec rails runner "exit(Book.count > 0 ? 0 : 1)" || bundle exec rake db:seed