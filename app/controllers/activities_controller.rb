# frozen_string_literal: true
class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show]
  before_action :authorize!, only: [:show]

  before_action :set_activities_limit, only: [:index, :paginate]
  before_action :set_page_param, only: [:index, :paginate]

  helper_method :options_filter

  def index
    @activities = Activity.fetch_all(options_filter)
    @content_types = ContentType.by_activity.order('LOWER(title) ASC')
    @programmes = Activity.programmes
    @partners = Partner.order(:name)
    @tags = Tag.for_content('Activity')
    @section = SiteSection.where(section: "activities").first
    @status = Content::STATUS
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @activities.to_json }
    end
  end

  def show
    @related_activities = if @activity.is_programme?
                            @activity.programme_activities.
                              order_by_title
                          elsif @activity.programme
                            Activity.where(programme_id: @activity.programme_id).
                              where.not(id: @activity.id).
                              randomize.limit(6)
                          else
                            []
                          end
  end

  def paginate
    @activities = Activity.fetch_all(options_filter)
                    .limit(@activities_limit)
                    .offset(@activities_limit * (@page - 1))
    respond_to do |format|
      if @activities.empty?
        head :no_content
      end
      format.js
    end
  end

  private
    def options_filter
      params.permit(:type, :partners, :tags, :programme, :status)
    end

    def set_page_param
      @page = params[:page].present? ? params[:page].to_i : 1
    end

    def set_activity
      @activity = Activity.find(params[:id])
    end

    def authorize!
      if @activity.unpublished? && !current_user
        redirect_to activities_url
      end
    end

    def set_activities_limit
      @activities_limit = 100
    end
end
