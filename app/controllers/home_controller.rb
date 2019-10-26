class HomeController < ApplicationController
    def index
        today = Date.current
        @this_year = Book.where(:finished => Date.new(today.year,1,1)..today)
        @this_month_count = @this_year.where(:finished => Date.new(today.year,today.month,1)..today).count 
        @this_year_count = @this_year.count
        
        if @this_year_count > 0
            @women_this_year = (100*@this_year.where(gender: "F").count/@this_year_count).round
        else
            @women_this_year = 0
        end

        @all_time_count = Book.where.not(finished: nil).count
        @chart1 = Book.where(finished: "2011-01-01"..).group_by_year(:finished, format: "%Y").count

    end

    
end
