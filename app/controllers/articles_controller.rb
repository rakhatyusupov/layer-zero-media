class ArticlesController < ApplicationController
  # Devise: требуем вход в систему перед любыми действиями
  before_action :authenticate_user!

  # CanCanCan: автоматически загружает ресурс и проверяет права
  load_and_authorize_resource

  # Если прав нет — перенаправляем
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  # GET /articles
  def index
    # @articles загружается автоматически из load_and_authorize_resource
    # Если хочешь фильтровать, можешь добавить:
    # @articles = Article.accessible_by(current_ability)
  end

  # GET /articles/1
  def show; end

  # GET /articles/new
  def new; end

  # GET /articles/1/edit
  def edit; end

  # POST /articles
  def create
    # load_and_authorize_resource создаёт @article
    @article.user = current_user # если у статьи есть автор

    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    redirect_to articles_path, notice: "Article was successfully destroyed.", status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
