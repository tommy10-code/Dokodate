class DiagnosesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def result
    diagnoses = params[:answer].to_s
    if diagnoses == "0"
      render "result_type_a"
    elsif diagnoses == "1"
      render "result_type_b"
    elsif diagnoses == "2"
      render "result_type_c"
    else
      redirect_to diagnoses_new_path, alert: "診断を選択してください"
    end
  end
end
