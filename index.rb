require_relative 'file'
require_relative 'remove'

class Index
  def initialize(set, disregarded)
    cont_words = {}

    file_set = set
    file_not_considered = disregarded
    file_index = 'indice.txt'

    words_disregarded = Arqv.read_files(file_not_considered)
    files = Arqv.read_files(file_set)

    Remove.remove_spec_char(files)

    Arqv.read(files, cont_words, words_disregarded)

    printIndex(file_index, cont_words)
  end

  def printIndex(file_index, cont_words)
    File.open(file_index, "w") do |file|
      cont_words.each do |word, mapa_document|
        records = mapa_document.map { |document, amount| "#{document},#{amount}" }.join(" ")
        file.puts "#{word}: #{records}"
      end
    end
  end
end

Index.new('conjunto.txt', 'desconsideradas.txt')
