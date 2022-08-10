class AttemptsController < ApplicationController
  def index
    matching_attempts = Attempt.all

    @list_of_attempts = matching_attempts.order({ :created_at => :desc })

    @starting_timestamp = DateTime.now.change(:offset => "+500")


    render({ :template => "attempts/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_attempts = Attempt.where({ :id => the_id })

    @the_attempt = matching_attempts.at(0)

    render({ :template => "attempts/show.html.erb" })
  end

  def create
    #self.load_current_user

    the_attempt = Attempt.new
    
    the_attempt.started_at = params[:starting_timestamp]
    the_attempt.finished_at = DateTime.now.change(:offset => "+500")
    the_attempt.submission = params.fetch("query_submission")
    
    the_attempt.user_id = session.fetch(:user_id)
    the_attempt.exercise_id = params.fetch("query_exercise_id")
    the_attempt.round_id = params.fetch("query_round_id")
    the_attempt.correct = (if the_attempt.submission == the_attempt.exercise.answer then true else false end)

    attempts_left = cookies.fetch(:attempts_left).to_i
    attempts_left -= 1
    cookies[:attempts_left] = attempts_left

    if the_attempt.valid? and (attempts_left != 0)
      the_attempt.save
      redirect_to("/attempts", { :notice => "Attempt recorded!" })
    elsif the_attempt.valid? and (attempts_left == 0)
      the_attempt.save
      redirect_to("/round_complete", { :notice => "Attempt recorded and round complete!" })
    else
      redirect_to("/attempts", { :alert => the_attempt.errors.full_messages.to_sentence })
    end

    # Adjusting user level here so that exercises are served at the right difficulty

    current_user_level = cookies.fetch(:user_level).to_i
    current_streak = cookies.fetch(:streak_counter).to_i
    
    
    if the_attempt.correct 
      if (current_user_level != Exercise.maximum(:difficulty)) and (current_streak == 2)
        current_user_level += 1
        cookies[:user_level] = current_user_level
      else
        current_streak += 1
        cookies[:streak_counter] = current_streak
      end

    else
      if current_user_level != Exercise.minimum(:difficulty)
        current_user_level -= 1
        cookies[:streak_counter] = 0
        cookies[:user_level] = current_user_level
      end
    end

  end

  def update
    the_id = params.fetch("path_id")
    the_attempt = Attempt.where({ :id => the_id }).at(0)

    the_attempt.correct = params.fetch("query_correct", false)
    the_attempt.started_at = params.fetch("query_started_at")
    the_attempt.finished_at = params.fetch("query_finished_at")
    the_attempt.submission = params.fetch("query_submission")
    the_attempt.user_id = params.fetch("query_user_id")
    the_attempt.exercise_id = params.fetch("query_exercise_id")
    the_attempt.round_id = params.fetch("query_round_id")

    if the_attempt.valid?
      the_attempt.save
      redirect_to("/attempts/#{the_attempt.id}", { :notice => "Attempt updated successfully."} )
    else
      redirect_to("/attempts/#{the_attempt.id}", { :alert => the_attempt.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_attempt = Attempt.where({ :id => the_id }).at(0)

    the_attempt.destroy

    redirect_to("/attempts", { :notice => "Attempt deleted successfully."} )
  end
end
