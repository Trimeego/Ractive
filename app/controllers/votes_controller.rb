class VotesController < ApplicationController
  # GET event/id/votes
  # GET /votes.xml
  def index
    @event = Event.find(params[:event_id])
    @votes = Vote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @votes }
    end
  end

  # GET /votes/1
  # GET /votes/1.xml
  def show
    @event = Event.find(params[:event_id])
    @vote = Vote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vote }
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

  # GET /votes/1/edit
  def edit
    @event = Event.find(params[:event_id])
    @vote = @event.votes.find(params[:id])
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

  # PUT /votes/1
  # PUT /votes/1.xml
  def update
    @event = Event.find(params[:event_id])
    @vote = Vote.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to(@vote, :notice => 'Vote was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.xml
  def destroy
    @event = Event.find(params[:event_id])
    @vote = Vote.find(params[:id])
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to(votes_url) }
      format.xml  { head :ok }
    end
  end
end
