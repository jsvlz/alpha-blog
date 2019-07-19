class ArticlesController < ApplicationController # < ApplicationController means from subclass...
  #this new method just initializes @article
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
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
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

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

end
