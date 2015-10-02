class RunsController < ApplicationController
  before_filter :require_user
  expose(:run, attributes: :run_params)
  expose(:new_run) { current_user.runs.build(run_params) }

  def create
    # @run = current_user.runs.build(run_params)

    if new_run.save
      redirect_to :root, notice: "Run successfully added."
    else
      run.valid?
      render :new
    end
  end

  private

  def run_params
    params.require(:run).permit(:ran_on, :distance)
  end
end
