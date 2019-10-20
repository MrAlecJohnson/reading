class Book < ApplicationRecord
    validates :title, presence: true
    validates :firstname, presence: true
    validates :lastname, presence: true
    validates :sex, inclusion: { 
        in: ['M', 'F', 'O'], 
        message: '- this must be M, F or O'}
    validates :published, length: {
        is: 4, 
        message: '- this must be a 4-digit year'}
    validates :rating, inclusion: {
        in: 1..5,
        message: '- this must be from 1 to 5'}
                
end
