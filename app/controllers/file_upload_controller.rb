class FileUploadController < ApplicationController
  def index
  end

  def create
    uploaded_file = params[:file]
    file_type = params[:file_type]
  
    # Check if a file was selected
    if uploaded_file.nil?
      flash[:error] = "Please select a file to upload."
      render :index and return
    end
  
    # Check if a file type was selected
   
    if file_type.nil?
      flash[:error] = "Please select a file type."
      render :index and return
    end

    file_contents = uploaded_file.read
    data = JSON.parse(file_contents)
    description = data[0]["description"]
    @exercise = Exercise.new(user_id: current_user.id, title: description, exercise_type: file_type)
  
    if @exercise.save
      File.open(Rails.root.join('public', 'exercises_file',  "#{@exercise.id}.json"), 'wb') do |file|
        file.write( file_contents)
      end
      redirect_to exercise_path(@exercise)
    else
      flash[:error] = "An error occurred while uploading the file."
      render :index
    end 
  end
end