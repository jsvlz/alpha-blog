class ArticlesController < ApplicationController # < ApplicationController means from subclass...
  #this new method just initializes @article
  def new
    @article = Article.new
  end

  #this method saves article then the attributes are passed to the below params method
  def create
    #render plain: params[:article].inspect # this displays what's being passed into controller
    @article = Article.new(article_params)
    @article.save
    #redirect_to articles_show(@article)
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

end
