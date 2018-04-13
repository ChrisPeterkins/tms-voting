class PollsController < ApplicationController
  include PollsHelper
  def index
      @poll = Poll.find_by(active: true)
  end

  def new
    @poll = Poll.new
  end

  def results
    @polls = Poll.all
  end
  
  def create
    @poll = Poll.new(poll_params)
    @poll.active = true
    if @poll.save
      flash[:success] = 'Poll was created!'
      redirect_to polls_path
    else
      render 'new'
    end
  end
  
  def edit
    @poll = Poll.find_by_id(params[:id])
  end

  def update
    @poll = Poll.find_by_id(params[:id])
    if @poll.update_attributes(poll_params)
      flash[:success] = 'Poll was updated!'
      redirect_to polls_path
    else
      render 'edit'
    end
  end

  def destroy
    @poll = Poll.find_by_id(params[:id])
    if @poll.destroy
      flash[:success] = 'Poll was destroyed!'
    else
      flash[:warning] = 'Error destroying poll...'
    end
    redirect_to polls_path
  end

  def show
    @poll = Poll.includes(:vote_options).find_by_id(params[:id])
    @vote = Vote.new
  end
  
  
  private

    def poll_params
      params.require(:poll).permit(:topic, :active, vote_options_attributes: [:id, :title, :_destroy])
    end
end
