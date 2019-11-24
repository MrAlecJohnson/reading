class BooksController < ApplicationController
    USER = ENV['CONTROLLER_USER']
    PASS = ENV['CONTROLLER_PASSWORD']    

    before_action :authenticate, except: [:index]

    def index
        @books = Book.all.order(finished: :desc)
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
        if params[:file]
            before = Book.count
            Book.my_import(params[:file])
            added = Book.count - before
            flash[:notice] = "Added #{added} new books"
            redirect_to books_path 
        else
            flash[:notice] = "No file selected"
            redirect_to new_book_path
        end
    end

    private
    def book_params
        params.require(:book).permit(
            :title, 
            :firstname, 
            :lastname, 
            :rating,
            :gender,
            :published, 
            :finished, 
            :series,
            :owned)
    end

    def authenticate
        unless request.env['HTTP_HOST'] == 'localhost:3000'
            http_basic_authenticate_with name: USER, password: PASS, except: [:index]
        end
    end


end
