class QueryResponse
  def initialize(consult_file, file_set)
    @word_counter = {}
    @consult_file = consult_file
    @file_set = file_set
    @query = []
    @files = []
  end

  def load_data
    load_word_counter
    load_query
    load_files
  end

  def process_query
    response = []
    aux1 = Array.new(@query.size, 0)
    aux = @query[0]

    if aux.include?(',')
      aux2 = aux.split(',')

      aux2.each { |word| response << word.strip }

      i = 0
      while i != response.size
        @word_counter.each do |word, files|
          if response[i] == word
            files.each do |file, _|
              aux1[file - 1] = 1
            end
          end
        end

        i += 1
      end

    elsif aux.include?(';')
      aux2 = aux.split(';')

      aux2.each { |word| response << word.strip }

      @word_counter.each do |word, files|
        if response.include?(word)
          files.each do |file, _|
            aux1[file - 1] = 1
          end
        end
      end
    end

    response.clear
    response << aux1.count(1).to_s

    aux1.each_with_index { |value, index| response << @files[index] if value == 1 }

    response
  end

  def save_result
    File.open('response.txt', 'w') do |file|
      file.puts process_query
    end
  end

  private

  def load_word_counter
    File.open('indice.txt', 'r') do |file|
      file.each_line do |line|
        word, occurrences_str = line.chomp.split(/[:,]/)
        occurrences = occurrences_str.split(' ').map { |occurrence| occurrence.split(',') }
        @word_counter[word] = occurrences.to_h { |file, _| [file.to_i, 1] }
      end
    end
  end

  def load_query
    File.open(@consult_file, 'r') do |file|
      @query = file.readlines.map(&:chomp)
    end
  end

  def load_files
    File.open(@file_set, 'r') do |file|
      @files = file.readlines.map(&:chomp)
    end
  end
end

response = QueryResponse.new('consulta.txt', 'conjunto.txt')
response.load_data
response.save_result
response.process_query
