require 'csv'

new_books = []

data = CSV.foreach("/Users/alec/Ruby/reading/books_csv_20191020.csv", 
    headers: true, 
    encoding: "UTF-8") do |row|
        unless row[1].nil? or row.nil?
            name = row[1].split(', ')
        end
        new_books << {
            title: row[0], 
            firstname: name[1],
            lastname: name[0],
            sex: row[2],
            series: row[3],
            rating: row[4],
            published: row[5],
            finished: row[6],
            owned: row[7]
        }
       
end

puts new_books[0].class
puts new_books[0]