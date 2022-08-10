class RoundsController < ApplicationController

  def index
    matching_rounds = Round.all

    @list_of_rounds = matching_rounds.order({ :created_at => :desc })

    render({ :template => "rounds/index.html.erb" })
  end

  def complete
    render({ :template => "rounds/round_complete.html.erb" })
  end


  def stats

    this_user_id = session.fetch(:user_id)
    
    matching_rounds = Round.where( :user_id => this_user_id )

    @list_of_rounds = matching_rounds.order({ :created_at => :desc })

    render({ :template => "rounds/stats.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_rounds = Round.where({ :id => the_id })

    @the_round = matching_rounds.at(0)

    render({ :template => "rounds/show.html.erb" })
  end

  def create
    the_round = Round.new
    the_round.user_id = session.fetch(:user_id)

    
    
    round_length = params.fetch("query_round_length")
    cookies.store(:attempts_left, round_length)

    if the_round.valid?
      the_round.save
      redirect_to("/attempts", { :notice => "Round started!" })
    else
      redirect_to("/rounds", { :alert => the_round.errors.full_messages.to_sentence })
    end

    cookies.store(:user_level, 0)
    cookies.store(:streak_counter, 0)
    cookies.store(:current_round, the_round.id)
  end

  def update
    the_id = params.fetch("path_id")
    the_round = Round.where({ :id => the_id }).at(0)

    the_round.user_id = params.fetch("query_user_id")
    the_round.attempts_count = params.fetch("query_attempts_count")

    if the_round.valid?
      the_round.save
      redirect_to("/rounds/#{the_round.id}", { :notice => "Round updated successfully."} )
    else
      redirect_to("/rounds/#{the_round.id}", { :alert => the_round.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_round = Round.where({ :id => the_id }).at(0)

    the_round.destroy

    redirect_to("/rounds", { :notice => "Round deleted successfully."} )
  end
end
