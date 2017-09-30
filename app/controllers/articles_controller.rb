class ArticlesController < ApplicationController
  before_action :require_login
  def index
    @articles = Article.all
  end
  
  def show
    @article = Article.find(params[:id])
  end
 
  def new
    @article = current_user.articles.build
  end
 
  def edit
    begin
      @article = current_user.articles.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @article = nil
      redirect_to articles_path
    end
  end
 
  def create
    @article = current_user.articles.build(article_params)
 
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end
 
  def update
    @article = current_user.articles.find(params[:id])
 
    if @article.update_attributes(article_params)
      redirect_to @article, notice: "Article Updated"
    else
      render 'edit'
    end
  end
 
  def destroy
    begin
      @article = current_user.articles.find(params[:id])
      @article.destroy
      redirect_to articles_path
    rescue ActiveRecord::RecordNotFound => e
      @article = nil
      redirect_to articles_path
    end
  end
 
  private
    def article_params
      params.require(:article).permit(:title, :description, :summaryDetails)
    end
end