module BooksHelper
    include Pagy::Frontend
    
    def sortable(column, title = nil)
        title ||= column.titleize
        # the lines below flip it if you click on the col you're already sorting by
        direction = (column == sort_column() && sort_direction() == "asc") ? "desc" : "asc"
        null_order = (column == sort_column() && null_order() == "nulls first") ? "nulls last" : "nulls first"
        link_to title, sort: column, direction: direction, null_order: null_order
    end
    
end
