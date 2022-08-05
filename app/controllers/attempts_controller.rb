class AttemptsController < ApplicationController
  def index
    matching_attempts = Attempt.all

    @list_of_attempts = matching_attempts.order({ :created_at => :desc })

    render({ :template => "attempts/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_attempts = Attempt.where({ :id => the_id })

    @the_attempt = matching_attempts.at(0)

    render({ :template => "attempts/show.html.erb" })
  end

  def create
    self.load_current_user

    the_attempt = Attempt.new
    
    the_attempt.started_at = params.fetch("query_started_at")
    the_attempt.finished_at = params.fetch("query_finished_at")
    the_attempt.submission = params.fetch("query_submission")
    
    the_attempt.user_id = session.fetch(:user_id)
    the_attempt.exercise_id = params.fetch("query_exercise_id")
    the_attempt.round_id = params.fetch("query_round_id")
    the_attempt.correct = (if the_attempt.submission == the_attempt.exercise.answer then true else false end)

    
    if the_attempt.valid?
      the_attempt.save
      redirect_to("/attempts", { :notice => "Attempt created successfully." })
    else
      redirect_to("/attempts", { :alert => the_attempt.errors.full_messages.to_sentence })
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
