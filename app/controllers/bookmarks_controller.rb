class BookmarksController < ApplicationController
  def create
    board = Board.find(prams[:board_id])
    current_user.bookmark(board)
    redirect_back fallback_location: root_path, success: t('.success')
  end
  def destroy
    board = Board.find(prams[:board_id])
    current_user.unbookmark(board)
    redirect_back fallback_location: root_path, danger: t('.danger')
  end
end
