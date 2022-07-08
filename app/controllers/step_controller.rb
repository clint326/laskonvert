class StepController < ApplicationController
  def new
    if params[:process_id] == "1" # step 1 uploads the text
      @process = ProcessFile.new(step: 1)
      @next_step = 2
    elsif params[:process_id] == "2" # step 2 reverse the text
      @previous_process = ProcessFile.find_by(step: 1)
      @process = ProcessFile.new(step: 2)
      @next_step = 3
      @label = "Transform Text - Reverse"
    elsif params[:process_id] == "3" # step 3 puts 42 in between each 5 word
      @previous_process = ProcessFile.find_by(step: 2)
      @process = ProcessFile.new(step: 3)
      @next_step = 4
      @label = "Transform Text - Add 42"
    else # final step allows user to download the file
      @previous_process = ProcessFile.find_by(step: 3)
    end
  end

  def create
    params[:process_file][:text] = params[:process_file][:text].reverse if params[:process_id] == "3" # reverse text
    params[:process_file][:text] = params[:process_file][:text].split(" ").each_slice(5).to_a.map {|x| x << "42"}.join(" ") if params[:process_id] == "4" # add 42 between each 5th word

    @process = ProcessFile.new(process_params)
    @process.step = params[:process_id].to_i - 1

    @process.save
    redirect_to new_process_step_path(params[:process_id])
  end

  private

  def process_params
    params.require(:process_file).permit(:text)
  end
end
