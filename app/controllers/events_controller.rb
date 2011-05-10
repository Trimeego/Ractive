class EventsController < ApplicationController
  caches_action :index, :expires_in => 15.minutes
  caches_action :show, :expires_in => 15.minutes
  
  before_filter :authenticate_user!, :except => [:index, :show] 
  before_filter :admin_user?, :except => [:index, :show] 
  
  layout 'mobile'
  
  # GET /events
  # GET /events.xml
  def index
    @events = Event.all
    @admin_mode = params[:admin]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @email = cookies[:last_email] || ''
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
  
  def build_all
    if params[:confirm]=='yes'
      Event.delete_all
      Event.create :featured => true, :start_time_utc => DateTime.parse('2011-5-11 2:15pm'), :end_time_utc => DateTime.parse('2011-5-11 3:15pm'), :location => 'Miami 3', :title => 'Know the Numbers', :description =>  'Easy to Use Dashboards and Reporting Tools to Help You Manage Your AP Operation'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Daytona 2', :title => 'Changing the Face of AP through e-Invoicing and Cloud Automation'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Sanibel 3', :title => 'How to Use Technology to Make Your One-Card Program a Success'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Tallahassee 2', :title => 'Intervention for Accounts Payable'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Destin 2', :title => 'Reducing Invoice Processing Costs with Advanced Recognition'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Sanibel 1', :title => 'Using Invoice Automation to Maximize Working Capital'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Tallahassee 3', :title => 'Best Practices Strategies for Non-PO Transactions'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Tallahassee 1', :title => 'Do You Have What it Takes to be a Star', :description =>  'Five Years of Accounts Payable Best Practices'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Miami 6', :title => 'Must Have Metrics'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Osceola 6', :title => 'E Invoicing Eases the Collector\'s Mounting Burden'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Tampa 2', :title => 'Inside Job/Outside Job', :description =>  'Embezzlement and Check Fraud'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Tampa 3', :title => 'The Benefits of an Enterprise Approach to Fraud Prevention'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Destin 1', :title => 'The Case for Intelligent Enterprise Capture'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Miami 2', :title => 'Best Practices of Effective Leaders'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Naples 1', :title => 'IAPP Certification Programs'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Naples 3', :title => 'From Fargo to India', :description =>  'Microsoft\'s Journey into Off shoring US AP Operations'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Naples 2', :title => 'Creating Value Through a P-Card Program'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Gainsville 1', :title => 'Triad of Payments', :description =>  'Costs, Security, & Operations'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Osceola 4', :title => 'Creating a More Efficient, Expansive Purchasing Card Program that Works'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Osceola 5', :title => 'Bridging the Gap Between Banks and Corporations:  The New Landscape for Connectivity'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Osceola 2', :title => 'Case Study', :description =>  'Strategies for Successful Vendor Card Payments'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Sarasota 3', :title => 'Expand Your Processing Vision', :description =>  'How to Optimize Multiple Business Process Inside SAP'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Sarasota 2', :title => 'Managing the End-to-End \'Source to Settle Process\' to Maximize Business Value'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Captiva 1', :title => 'Optimizing Your Payment s Organization'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Osceola 3', :title => 'State of the Lockbox Market'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Daytona 1', :title => 'The Future of Transaction Processing'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Osceola 1', :title => 'What\'s So Special About Specialty Audits?'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Sarasota 1', :title => 'Payments to Foreign Individuals and Entities', :description =>  'Complying with IRS Requirements for Services, Rents, Royalties, and Interest'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Captiva 2', :title => 'Why Aren\'t You Using the IRS TIN Matching System (Part 2 of 2)'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Tampa 1', :title => 'T&E Compliance', :description =>  'Avoiding a Tax Trap'
      Event.create :start_time_utc => DateTime.parse('2011-5-11 3:30pm'), :end_time_utc => DateTime.parse('2011-5-11 4:30pm'), :location => 'Miami 1', :title => 'Building a System of Trust', :description =>  'A Critical Component of an Effective P2P Practice (Part 2 of 2)'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Gainsville 1', :title => 'Between Wrong and Right (sourcing)', :description =>  'Breaking Through the Bottlenecks of AP Automation'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Daytona 2', :title => 'Beyond the Mist', :description =>  'Your Future in the Coming AP Cloud'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Tallahassee 2', :title => 'eInvoice Victory!', :description =>  'Simple Secrets to Your Supplier Adoption Plan'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Tallahassee 3', :title => 'How to Automate Contract Matching and Recurring Invoices'
      Event.create :featured => true, :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Tallahassee 1', :title => 'Payables Portals', :description =>  'Taking Your AP Operation to the Next Level'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Sanibel 1', :title => 'Supplier Discounts', :description =>  'Show Me the Money!  An Eli Lilly Case Study on Optimizing Supplier Discounts'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Miami 3', :title => 'Squeaky Clean', :description =>  'Vendor Master Cleansing'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Osceola 6', :title => 'International Invoicing', :description =>  'VAT and Mandatory Compliance Issues'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Miami 1', :title => 'The Evolution of Fraud Prevention'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Destin 1', :title => 'Payment Fraud', :description =>  'What Every Company Needs to Do to Protect Itself'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Captiva 1', :title => 'Revolutionize Your Organization\'s Flow of Business-Critical Information'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Osceola 4', :title => 'Hire the Best and Avoid the Rest', :description =>  'How to Interview and Hire Top People Every Time'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Tampa 3', :title => 'Future of Retail Recovery Audit'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Osceola 1', :title => 'What I Wish I Knew About P-cards Before I Launched my Companies Program'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Osceola 5', :title => 'Payment Terms and Disbursement Strategies'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Captiva 2', :title => 'Optimizing Business Intelligence', :description =>  'Meeting Client Expectations and Breaking Down Information Silos'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Miami 2', :title => 'An Introduction to 1099 Reporting'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Osceola 3', :title => 'Prepare Your Department for Upcoming 1099 Reporting Changes'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 8:30am'), :end_time_utc => DateTime.parse('2011-5-12 9:30am'), :location => 'Destin 2', :title => 'The System as a Key Player in the P2P Process - An Ariba Case Study'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Gainsville 1', :title => 'E-Invoicing Strategies for PO and Non-PO Invoices'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Miami 3', :title => 'E-Invoicing:   The Buyer AP Perspective'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Captiva 2', :title => 'Your AP Portal', :description =>  'Window or Wall?'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Captiva 1', :title => 'Process Transformation', :description =>  'Moving from a Transactional Center to a Value Center'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Osceola 6', :title => 'Survey Says?', :description =>  'Receivables Frustrations Abound, But Clearer Skies Ahead'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Destin 1', :title => 'Assessment of Fraud Vulnerabilities', :description =>  'Pcard vs. Traditional AP Use in Varied Situations'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Sanibel 2', :title => 'How Gulfstream Improved Accuracy and Supplier Satisfaction with Data Capture and Workflow'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Tallahassee 3', :title => 'The Changing Automation Landscape in Financial Operations'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Sanibel 1', :title => 'The Planting of Trees Shows Faith in the Future'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Miami 1', :title => 'Are You Ready to be a Leader?'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Destin 2', :title => 'The Business Benefits of Expense Management Outsourcing'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Tallahassee 2', :title => 'Deciding Not to Outsource', :description =>  'A Complex Cost Benefit Analysis'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Osceola 2', :title => 'Game Changing P-Card Trends', :description =>  'The Growth of P-Cards in Treasury Management'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Tampa 3', :title => 'Purchasing Card Best Practices'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Osceola 1', :title => 'Objections Overruled', :description =>  'Overcoming the Top 5 Barriers to Expanding Electronic Payments'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Osceola 4', :title => 'What are the Biggest Benefits of Lockbox?', :description =>  '(here\'s a hint - reduced float isn\'t one of them)'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Daytona 2', :title => 'What\'s Next in Mobile Banking'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Osceola 5', :title => 'Where are the Real Opportunities in Business Payments'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Miami 2', :title => 'The New World of 1099 Reporting', :description =>  'Get the Latest Updates'	
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Daytona 1', :title => 'What You Need to Know About State Reporting'
      Event.create :start_time_utc => DateTime.parse('2011-5-12 9:45am'), :end_time_utc => DateTime.parse('2011-5-12 10:45am'), :location => 'Tallahassee 1', :title => 'Withholding Tax from Vendor Payments', :description =>  'Your New Risk Exposure and How to Control It'
      
    end
    
    redirect_to :action => 'index'
  end
  
end
