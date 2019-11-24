require 'csv'
require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'

class Book < ApplicationRecord

    validates :title, presence: true
    validates :firstname, presence: true
    validates :lastname, presence: true
    validates :gender, inclusion: { 
        in: 0..2}
    validates :published, length: {
        is: 4, 
        message: '- this must be a 4-digit year'}
    validates :rating, inclusion: {
        in: 1..5,
        message: '- this must be from 1 to 5'}

    enum gender: [:Female, :Male, :Other]
   
    def owned_yn
        :owned ? 'Yes' : 'No'
    end

    def self.my_import(file)
        new_books = []
        converter = lambda { |header| header.downcase }
        CSV.foreach(file.path, headers: true, header_converters: converter) do |row|
            new_books << Book.new(row.to_h)
        end
        Book.import new_books, recursive: true
    end

    #TAGS
    has_many :taggings
    has_many :tags, through: :taggings
  

end
