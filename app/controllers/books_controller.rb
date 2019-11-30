class BooksController < ApplicationController
    include Pagy::Backend

    USER = ENV['CONTROLLER_USER']
    PASS = ENV['CONTROLLER_PASSWORD']    

    before_action :authenticate, except: [:index]
    
    helper_method :sort_column, :sort_direction, :null_order

    def index
        unlowered = "#{sort_column} #{sort_direction} #{null_order}"
        lowered = "lower(#{sort_column}) #{sort_direction} #{null_order}"
        @date_start ||= Date.new(Date.current.year,1,1)
        @date_finish = Date.new(params['date_end'].to_i)
        #test = Date.new(params['date_end'].to_i)
        @pagy, @books = pagy(Book.where(finished: @date_start..@date_end).order(['title', 'lastname', 'series'].include?(sort_column) ? lowered : unlowered), items: 50)
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

    def sort_column
        Book.column_names.include?(params[:sort]) ? params[:sort] : "finished"
    end
      
    def sort_direction
        ['asc', 'desc'].include?(params[:direction]) ? params[:direction] : "desc"
    end
    
    def null_order
        ['nulls first', 'nulls last'].include?(params[:null_order]) ? params[:null_order] : "nulls last"
    end

    def authenticate
        unless request.env['HTTP_HOST'] == 'localhost:3000'
            http_basic_authenticate_with name: USER, password: PASS, except: [:index]
        end
    end


end
