require 'nokogiri'
require 'json'
class SubmissionsController < ApplicationController
  

  def user_submissions
    @user = User.find(params[:id])
    @submissions = Submission.where(user_id: @user.id)
    
  end

    def index
      @exercise = Exercise.find(params[:exercise_id])
      @submissions = Submission.where(exercise_id: @exercise.id)
      @submission_links = @submissions.map do |submission|
        {
          id: submission.id,
          url: exercise_submission_path(@exercise, submission),
          user_email: submission.user.email,
          grade: submission.grade,
          created_at: submission.created_at
        }
      end
    end
 

  # GET /exercises/:id
  def show
    @submission = Submission.find(params[:id])  
    @file_name = "#{params[:id]}.json"

  end

 
  def create
    data = JSON.parse(request.body.read)
    render json: { message: data }
    progress =jff_to_json( data["progress"])
    grade = data["grade"]
   # @exercise = Exercise.find(params[:exercise_id])
    @submission =Submission.new(user_id: current_user.id, exercise_id: data['exerciseId'], grade: grade, solution: progress )
    if @submission.save
    file_name = "#{data['exerciseId']}.json"
    file_path = Rails.root.join('public', 'exercises_file', file_name)
    file_content = File.read(file_path)
    file_content = file_content[1..-2]
    submission_data = JSON.parse(file_content)
    submission_data['graph']= JSON.parse(progress)
    file_content = submission_data.to_json
    @submission_file_name = "#{@submission.id}.json"
    
   # render json: { message:  @submission_file_name }
    file_content = "[#{file_content}]"
     File.open(Rails.root.join('public', 'submissions', @submission_file_name), 'wb') do |file|
     file.write(file_content)
     end
    end 

    #redirect_to submissions_path, notice: 'Submission was successfully created.'
     
    #render json: { message: @submission.id }
    #render json: { message: current_user.id }
    #render json: { message: data }
    #render json: { message: grade }
  end


  private

  def jff_to_json(jff_string)
    # Parse the JFF string using Nokogiri
    doc = Nokogiri::XML(jff_string)
  
    # Extract the relevant information from the JFF string
    nodes = doc.xpath('//state').map.with_index do |state, index|
      {
        left: state.xpath('./x').text.to_f,
        top: state.xpath('./y').text.to_f,
        i: state.at_xpath('./initial') != nil,
        f: state.at_xpath('./final') != nil,
        name: state['name'] || "node#{index}"
      }
    end
  
    edges = doc.xpath('//transition').map do |transition|
      {
        start: transition.xpath('./from').text.to_i,
        end: transition.xpath('./to').text.to_i,
        weight: transition.xpath('./read').text
      }
    end
  
    # Create a hash containing the relevant information
    data = {
      
        nodes: nodes,
        edges: edges,
        names: (0...nodes.length).map { |i| nodes[i][:name] },
        shorthand: false
      
    }
  
    # Convert the hash to JSON and return it
    JSON.generate(data)
  end
end