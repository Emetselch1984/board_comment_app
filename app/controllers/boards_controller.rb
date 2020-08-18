class BoardsController < ApplicationController
  before_action :set_user, only: %i[edit update]
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: t('defaults.message.created', item: Board.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Board.model_name.human)
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def destroy
    @board = current_user.boards.find(params[:id])
    @board.destroy!
    redirect_to boards_path,success: t('.success')
  end

  def edit ;end

  def update
    if @board.update(board_params)
     redirect_to boards_path, success: t('.success')
    else
     flash.now['danger'] = t('.fail')
     render :edit
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end

  def set_user
    @board = current_user.boards.find(params[:id])
  end
end
