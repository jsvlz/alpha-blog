class ArticlesController < ApplicationController # < ApplicationController means from subclass...
  #this new method just initializes @article
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def new
    @article = Article.new
  end

  #this method saves article then the attributes are passed to the below params method
  def create
    @article = Article.new(article_params)
    #@article.save

    if @article.save
      flash[:notice] = "Article was successfully created" #handle view in application.html.erb
      redirect_to article_path(@article)
    else
      render 'new'
    end

  end

  def show
    @article = set_article
  end

  def edit
    @article = set_article
  end

  def update
    @article =
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated" #handle view in application.html.erb
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

def index
  @all_articles = Article.all
end

def destroy
  @article = set_article
  @article.destroy
  redirect_to articles_path
  flash["notice"] = "Article deleted"
end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end

end
