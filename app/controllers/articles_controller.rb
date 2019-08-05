class ArticlesController < ApplicationController # < ApplicationController means from subclass...
  #this new method just initializes @article
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @article = Article.new
  end

  #this method saves article then the attributes are passed to the below params method
  def create
    #debugger
    @article = Article.new(article_params)
    @article.user = current_user
    #@article.save

    if @article.save
      flash[:success] = "Article was successfully created" #handle view in application.html.erb
      redirect_to article_path(@article)
    else
      render 'new'
    end

  end

  def show
    #@article = set_article #don't need to call here since specifying above in the before action
  end

  def edit
    #@article = set_article #don't need to call here since specifying above in the before action
  end

  def update
    @article =
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated" #handle view in application.html.erb
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

def index
  #@articles = Article.all #will show all articles
  @articles = Article.paginate(page: params[:page], per_page: 5) #uses pagiate ruby gem to automatically paginate
end

def destroy
  #@article = set_article #don't need to call here since specifying above in the before action
  @article.destroy
  redirect_to articles_path
  flash[:danger] = "Article deleted"
end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end

    def require_same_user
      if current_user != @article.user and !current_user.admin?
        flash[:danger] = "You can only edit or delete your own article"
        redirect_to root_path
      end
    end

end
