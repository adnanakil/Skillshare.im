class ProposalsController < ApplicationController
  include ProposalsHelper

  skip_before_action :authorize, only: %i[index home show]
  before_action :set_categories, only: %i[create new edit update]
  before_action :set_offer, only: %i[edit update destroy]

  def index
    respond_to do |format|
      format.html do
        @klass = params[:type].constantize
        @proposals = @klass.filter_by_tag(params[:category]).page(params[:page]).per(30).decorate
      end

      format.atom do
        @proposals = Proposal.recent
        @updated_at = @proposals.maximum(:updated_at)
      end
    end
  end

  def home
    @offers = Offer.filter_by_tag(params[:category]).recent(10).decorate
    @wanteds = Wanted.filter_by_tag(params[:category]).recent(10).decorate
  end

  def show
    # untested
    @proposal = Proposal.find(params[:id]).decorate
    @user = @proposal.user.decorate
  end

  def new
    @proposal = current_user.public_send(type_of_proposal).new.decorate
    @user = current_user
  end

  def edit
    @user = @proposal.user
  end

  def create
    @proposal = current_user.public_send(type_of_proposal).build(proposal_params).decorate
    if @proposal.save
      redirect_back_or user_url(current_user), success: "Created."
    else
      @user = current_user
      render :new
    end
  end

  def update
    if @proposal.update(proposal_params)
      redirect_back_or @proposal, success: "Updated."
    else
      @user = current_user
      render :edit
    end
  end

  def destroy
    @proposal.destroy
    redirect_back_or user_url(current_user), success: "Deleted."
  end

  private

  def set_categories
    @categories = ApplicationHelper::CATEGORIES
  end

  def set_offer
    @proposal = current_user.proposals.find(params[:id])
  end

  def proposal_params
    attrs = %i[title description location category_list]
    params.require(params[:type].downcase).permit(attrs)
  end

  def type_of_proposal
    params[:type].underscore.pluralize
  end
end
