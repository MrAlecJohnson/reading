class BooksController < ApplicationController

    auth = IO.readlines("auth.env", chomp: true)
    USER = auth[0]
    PASS = auth[1]
    http_basic_authenticate_with name: USER, password: PASS, except: [:index]

    def index
        @books = Book.all
    end

    def show
        @book = Book.find(params[:id])
    end

    def new
        @book = Book.new
    end

    def edit
        @book = Book.find(params[:id])
    end      

    def create
        @book = Book.new(book_params)
       
        if @book.save
            redirect_to @book
        else
            render 'new'
        end
    end

    def update
        @book = Book.find(params[:id])

        if @book.update(book_params)
            redirect_to @book
        else
            render 'edit'
        end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy

        redirect_to books_path
    end

    def import
        Book.my_import(params[:file])
        redirect_to books_path, notice: "Added new books"
    end

    def empty
        Books.delete_all    
        redirect_to books_path, notice: "Removed all books"
    end


    private
    def book_params
        params.require(:book).permit(
            :title, 
            :firstname, 
            :lastname, 
            :rating,
            :sex,
            :published, 
            :finished, 
            :series,
            :owned)
    end
end
