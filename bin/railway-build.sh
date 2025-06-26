#!/usr/bin/env bash
# exit on error
set -o errexit

echo "🚀 Starting Railway build for Rails app..."

echo "📦 Installing gems..."
bundle install

echo "🎨 Precompiling assets..."
bundle exec rake assets:precompile
bundle exec rake assets:clean

echo "🗄️ Running database migrations..."
bundle exec rake db:migrate

echo "🌱 Seeding database (if needed)..."
# Ejecutar seeds solo si no hay registros en la tabla de libros
bundle exec rails runner "exit(Book.count > 0 ? 0 : 1)" || bundle exec rake db:seed

echo "✅ Railway build completed successfully!"