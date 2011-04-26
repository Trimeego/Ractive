class VotesController < ApplicationController

  caches_action :index, :expires_in => 10.seconds
  caches_action :graph, :expires_in => 10.seconds
  
  # GET event/id/votes
  # GET /votes.xml
  def index
    @event = Event.find(params[:event_id])
    @votes = @event.votes.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @votes }
      format.json { render :json => @votes }
    end
  end

  def graph
    @event = Event.find(params[:event_id])
    @votes = @event.vote_histogram
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @votes }
      format.json { render :json => @votes }
    end
  end

  # GET /votes/new
  # GET /votes/new.xml
  def new
    @event = Event.find(params[:event_id])
    @vote = Vote.new
  
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vote }
    end
  end


  # POST /votes
  # POST /votes.xml
  def create
    @event = Event.find(params[:event_id])
    @vote = @event.votes.new(params[:vote])
    respond_to do |format|
      if @vote.save
        #write the pusher even now.  TODO:  look into another method for doing this like socket IO
        Pusher.app_id = '1863'
        Pusher.key = 'b98047814c02f83dc79d'
        Pusher.secret = '0a4ab0e502e339070ddd'

        Pusher[@event.id.to_s].trigger('vote_event', {:data => {:user => @vote.nickname, :rating => @vote.rating}})
        
        format.html { redirect_to(@vote, :notice => 'Vote was successfully created.') }
        format.xml  { render :xml => @vote, :status => :created, :location => event_vote_url(@event, @vote) }
        format.json  { render :json => @vote, :status => :created, :location => event_vote_url(@event, @vote) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vote.errors, :status => :unprocessable_entity }
      end
    end
  end

end
