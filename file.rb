class Arqv
  def self.read_files(file)
    inconsiderate_words = []
    File.foreach(file) do |line|
      inconsiderate_words << line.strip.downcase
    end
    inconsiderate_words
  end

  def self.read(files, count_words, inconsiderate_words)
    count = 1
    files.each do |file|
      read_file(file, count_words, inconsiderate_words, count)
      count += 1
    end
  end

  def self.read_file(file, count_words, inconsiderate_words, document)
    File.foreach(file) do |line|
      words = line.strip.downcase.split(/\s+/)
      words.each do |word|
        next if inconsiderate_words.include?(word)

        count_words[word] ||= {}
        count_words[word][document] ||= 0
        count_words[word][document] += 1
      end
    end
  end
end
