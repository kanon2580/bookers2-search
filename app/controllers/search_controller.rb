class SearchController < ApplicationController

  def search
    @book = Book.new

    if params[:genre] == "user"
      if params[:direction] == "完全一致"
        @users = User.where(name: "#{params[:word]}")
      elsif params[:direction] == "前方一致"
        @users = User.where('name LIKE ?', "#{params[:word]}%")
      elsif params[:direction] == "後方一致"
        @users = User.where('name LIKE ?', "%#{params[:word]}")
      elsif params[:direction] == "部分一致"
        @users = User.where('name LIKE ?', "%#{params[:word]}%")
      end

    elsif params[:genre] == "book"
      if params[:direction] == "完全一致"
        @books = Book.where(title: "#{params[:word]}", body: "#{params[:word]}")
      elsif params[:direction] == "前方一致"
        @books = Book.where('title LIKE ? OR body LIKE ?', "#{params[:word]}%", "#{params[:word]}%")
      elsif params[:direction] == "後方一致"
        @books = Book.where('title LIKE ? OR body LIKE ?', "%#{params[:word]}", "#{params[:word]}%")
      elsif params[:direction] == "部分一致"
        @books = Book.where('title LIKE ? OR body LIKE ?', "%#{params[:word]}%", "%#{params[:word]}%")
      end
    end
  end

end
