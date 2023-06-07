require_relative 'index'
require_relative 'response'

Index.new(ARGV[0], ARGV[1])
response = QueryResponse.new(ARGV[2], ARGV[0])
response.load_data
response.save_result
response.process_query
