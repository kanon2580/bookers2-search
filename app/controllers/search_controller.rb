class SearchController < ApplicationController

  def search
    @book = Book.new
    if params[:genre] == "user"
      @users = User.where('name LIKE ?', "%#{params[:word]}%")
    elsif params[:genre] == "book"
      @books = Book.where('title LIKE ? OR body LIKE ?', "%#{params[:word]}%", "%#{params[:word]}%" )
    end
  end

end
