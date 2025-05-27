# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Limpia la tabla de libros existente
Book.destroy_all

books_data = [
  {
    title: 'El síndrome de Ulises',
    author: 'Santiago Gamboa',
    year: 2005,
    description: 'La historia sigue a un joven colombiano que emigra a París en busca de una vida mejor, pero se encuentra atrapado en una existencia marginal, sumido en la soledad y la nostalgia por su país. Viviendo experiencias que lo atraviesan por completo. Como el amor, el sexo, las drogas y la amistad.',
    historic_context: 'Refleja la realidad de los migrantes en Europa, especialmente latinoamericanos, a principios del siglo XXI, luchando con la alienación y la búsqueda de identidad.',
    author_details: 'Santiago Gamboa es un escritor colombiano conocido por sus obras sobre la migración y las experiencias de los colombianos en el extranjero. Ha trabajado como periodista y diplomático, y sus obras exploran temas como la identidad, la globalización y la soledad en la modernidad.'
  },
  {
    title: 'La mujer rota',
    author: 'Simone de Beauvoir',
    year: 1967,
    description: 'Tres relatos sobre mujeres enfrentadas a la crisis de identidad, la soledad y el envejecimiento. Cada protagonista sufre un tipo de "ruptura" que la empuja a cuestionar su rol en la vida.',
    historic_context: 'Escrito en plena segunda ola feminista, cuando las mujeres comenzaban a cuestionar los roles tradicionales en la familia y el matrimonio, y a luchar por sus derechos en el ámbito laboral y personal.',
    author_details: 'Simone de Beauvoir fue una filósofa, escritora y feminista francesa, una de las principales figuras del existencialismo y del pensamiento feminista. Sus obras han tenido una enorme influencia en los debates sobre la libertad, el género y la opresión.'
  },
  {
    title: 'Esta herida llena de peces',
    author: 'Lorena Salazar',
    year: 2021,
    description: 'En Quibdó, una joven madre blanca se embarca en una canoa con su niño negro de cinco años. Empiezan un largo viaje hacia el norte por el Atrato. Las preguntas de los demás viajeros – y el viaje interior de la madre- nos revelan un dato desgarrador: la mujer que ha criado al niño casi desde su nacimiento, debe ahora entregárselo a su madre biológica, que vive en un pueblo lejano, río abajo. En el camino, enfrentan la violencia y el abandono de una tierra marcada por el conflicto armado.',
    historic_context: 'El contexto de esta novela se sitúa en la Colombia contemporánea, en medio de la violencia del conflicto armado y las realidades sociales de las zonas más marginadas del país.',
    author_details: 'Lorena Salazar es una escritora colombiana que explora temas como la maternidad, el desplazamiento y la violencia en sus obras. Se ha destacado por su estilo poético y su capacidad para abordar realidades complejas con una gran sensibilidad narrativa.'
  },
  {
    title: 'Lo que no tiene nombre',
    author: 'Piedad Bonnett',
    year: 2013,
    description: 'Relato profundamente íntimo y desgarrador sobre la historia de su hijo Daniel, un joven brillante y talentoso que luchaba con la esquizofrenia y cuya vida terminó trágicamente. La autora abre su corazón para compartir el duelo, la impotencia y el amor que sintió a lo largo de los años mientras veía a su hijo enfrentarse a la enfermedad mental.',
    historic_context: 'La obra fue escrita en un contexto donde la salud mental empezaba a recibir mayor atención en América Latina, pero aún cargaba un fuerte estigma. Refleja una experiencia íntima que pone en relieve el dolor familiar ante la pérdida.',
    author_details: 'Piedad Bonnett es una poeta, novelista y dramaturga colombiana. Su trabajo aborda temas como el dolor, la pérdida y la fragilidad de la condición humana. Es una de las voces más importantes de la literatura contemporánea colombiana.'
  },
  {
    title: 'La metamorfosis',
    author: 'Franz Kafka',
    year: 1915,
    description: 'La historia de Gregorio Samsa, un hombre que se despierta un día convertido en un insecto gigante. A medida que su condición se agrava, su familia lo rechaza y él experimenta una creciente alienación. Viendo como todo lo que era importante para él, se desvanece, incluyendo el amor de su familia.',
    historic_context: 'Escrita en plena era industrial europea, donde los cambios sociales y económicos crearon tensiones sobre la identidad, el trabajo y la alienación. También refleja la angustia personal de Kafka ante el autoritarismo y la burocracia.',
    author_details: 'Franz Kafka fue un escritor checo de origen judío, cuya obra, marcada por el absurdo, la alienación y el miedo a la autoridad, ha tenido una profunda influencia en la literatura moderna.'
  }
]

# Crear libros solo si no existen
books_data.each do |book_data|
  Book.find_or_create_by!(title: book_data[:title], author: book_data[:author]) do |book|
    book.year = book_data[:year]
    book.description = book_data[:description]
    book.historic_context = book_data[:historic_context]
    book.author_details = book_data[:author_details]
  end
end

# Crear admin solo si no existe
unless User.exists?(email: 'admin@dahia.com')
  User.create!(email: 'admin@dahia.com', password: 'dahicitap123', admin: true)
end

puts "Seed completado. Hay #{Book.count} libros y #{User.count} usuarios en la base de datos."