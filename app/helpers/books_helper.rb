module BooksHelper
    def sortable(column, title = nil)
        title ||= column.titleize
        # the line below flips it if you click on the col you're already sorting by
        direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
        link_to title, sort: column, direction: direction
    end
    
end
