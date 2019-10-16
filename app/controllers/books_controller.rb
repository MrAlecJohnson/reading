class BooksController < ApplicationController
    def index
        @books = Book.all
    end

    def show
        @book = Book.find(params[:id])
    end

    def new
        @book = Book.new
        #@book.finished ||= Date.today
    end

    def create
        @book = Book.new(book_params)
        @book.save!
        redirect_to @book
        
        #@read = Read.new(read_params)

        #if @read.save
        #    redirect_to @read
        #else
        #    render 'new'
        #end
    end

    private
    def book_params
        params.require(:book).permit(
            :title, 
            :firstname, 
            :lastname, 
            :published, 
            :finished, 
            :owned)
    end
end
