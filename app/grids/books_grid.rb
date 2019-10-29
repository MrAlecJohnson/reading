class BooksGrid < BaseGrid

  scope do
    Book
  end

  convert = {'F': 'Female', 'M': 'Male', 'O': 'Other'}
  
  filter(:lastname, :string, header: "Author's last name")
  filter(:rating, :enum, select: [1,2,3,4,5], checkboxes: true)
  filter(:finished, :date, range: true, default: proc {[Date.today.beginning_of_year, Date.today]})

  column(:title)
  column(:firstname, header: "Author's first name")
  column(:lastname, header: "Author's last name")
  column(:gender, header: "Author's gender")
  column(:rating)
  column(:published, header: 'Year published')
  date_column(:finished, header: 'Date finished') 
  column(:series)
  column(:owned) { owned ? 'Yes' : 'No'}
  column(:actions, html: true, header: 'Edit') do |b|
    link_to 'Edit', edit_book_path(b)
  end
  column(:actions, html: true, header: 'Delete') do |b|
    link_to 'Destroy', book_path(b),
                method: :delete,
                data: { confirm: 'Are you sure you want to delete this book?' }
  end


end

=begin
<table>
    <tr>
        <th>Title</th>
        <th>Author's first name</th>
        <th>Author's last name</th>
        <th>Rating</th>
        <th>Author's gender</th>
        <th>Year published</th>
        <th>Date finished</th>
        <th>Series</th>
        <th>Owned</th>
        <th colspan="2"></th>
    </tr>

    <% @books.each do |b| %>
        <tr>
            <td><%= b.title %></td>
            <td><%= b.firstname %></td>
            <td><%= b.lastname %></td>
            <td><%= b.rating %></td>
            <td><%= b.gender %></td>
            <td><%= b.published %></td>
            <td><%= b.finished ? b.finished.strftime("%-d %B %Y") : nil %></td>
            <td><%= b.series %></td>
            <td><%= b.owned %></td>
            <td><%= link_to 'Edit', edit_book_path(b) %></td>
            <td><%= link_to 'Destroy', book_path(b),
                method: :delete,
                data: { confirm: 'Are you sure?' } %></td>

        </tr>
    <% end %>
=end