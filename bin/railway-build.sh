#!/usr/bin/env bash
# exit on error
set -o errexit

echo "🚀 Starting Railway build for Rails app..."

# Verificar variables de entorno críticas
if [ -z "$DATABASE_URL" ]; then
  echo "⚠️  Warning: DATABASE_URL not set, using Rails default database configuration"
fi

echo "📦 Installing gems..."
bundle config set --local deployment 'true'
bundle config set --local without 'development test'
bundle install --jobs 4 --retry 3

echo "🎨 Precompiling assets..."
RAILS_ENV=production bundle exec rake assets:precompile
bundle exec rake assets:clean

# Solo ejecutar migraciones y seeds si DATABASE_URL está disponible
if [ -n "$DATABASE_URL" ]; then
  echo "🗄️ Running database migrations..."
  bundle exec rake db:migrate

  echo "🌱 Seeding database (if needed)..."
  # Ejecutar seeds solo si no hay registros en la tabla de libros
  bundle exec rails runner "exit(Book.count > 0 ? 0 : 1)" || bundle exec rake db:seed
else
  echo "⚠️  Skipping database operations - DATABASE_URL not available"
fi

echo "✅ Railway build completed successfully!"