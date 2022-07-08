class ProcessController < ApplicationController
  def destroy
    ProcessFile.delete_all
    redirect_to new_process_step_path(1)
  end
end
