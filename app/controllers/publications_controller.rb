# frozen_string_literal: true
class PublicationsController < ApplicationController
  before_action :set_publication, only: [:show]
  before_action :authorize!, only: [:show]
  before_action :set_publications_limit, only: [:index, :paginate]
  before_action :set_page_param, only: [:index, :paginate]

  helper_method :options_filter

  def index
    @publications = Publication.fetch_all(options_filter).
      limit(@publications_limit * @page)
    @content_types = ContentType.by_publication.order('LOWER(title) ASC')
    max = (Publication.maximum(:content_date) || Date.today).year
    min = (Publication.minimum(:content_date) || Date.today).year
    @years = (min..max).to_a.reverse
    @partners = Partner.order(:name)
    @tags = Tag.for_content('Publication')
    @section = SiteSection.where(section: "publications").first
    @status = Content::STATUS
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @publications.to_json }
    end
  end

  def show
    @users = @publication.users
  end

  def paginate
    @publications = Publication.fetch_all(options_filter)
                    .limit(@publications_limit)
                    .offset(@publications_limit * (@page - 1))
    respond_to do |format|
      if @publications.empty?
        head :no_content
      end
      format.js
    end
  end

  private
    def options_filter
      params.permit(:type, :partners, :tags, :year, :status)
    end

    def set_page_param
      @page = params[:page].present? ? params[:page].to_i : 1
    end

    def set_publication
      @publication = Publication.find(params[:id])
    end

    def authorize!
      if @publication.unpublished? && !current_user
        redirect_to publications_url
      end
    end

    def set_publications_limit
      @publications_limit = 15
    end
end
