# frozen_string_literal: true
require_dependency 'backend/application_controller'

module Backend
  class PublicationsController < ::Backend::ApplicationController
    load_and_authorize_resource

    before_action :set_objects, only: [:new, :edit]
    before_action :set_publications_limit, only: [:index, :edit, :new, :paginate]
    before_action :set_page_param, only: [:index, :edit, :new, :paginate]
    before_action :set_publications, only: [:index, :edit, :new]

    def index
    end

    def edit
      @publication = Publication.find(params[:id])
    end

    def new
      @publication = Publication.new
    end

    def update
      if @publication.update(publication_params)
        redirect_to edit_publication_url(@publication),
          notice: 'Publication updated'
      else
        set_objects
        set_publications_limit
        set_page_param
        set_publications
        render :edit
      end
    end

    def create
      @publication = Publication.create(publication_params)
      if @publication.save
        redirect_to edit_publication_url(@publication),
          notice: 'Publication created'
      else
        set_objects
        set_publications_limit
        set_page_param
        set_publications
        render :new
      end
    end

    def destroy
      @publication = Publication.find(params[:id])
      if @publication.destroy
        redirect_to publications_url
      end
    end

    def publish
      @item = @publication
      @item.try(:publish)
      respond_to do |format|
        format.js { render 'backend/shared/index_options' }
      end
    end

    def unpublish
      @item = @publication
      @item.try(:unpublish)
      respond_to do |format|
        format.js { render 'backend/shared/index_options' }
      end
    end

    def make_featured
      @item = @publication
      @item.try(:make_featured)
      respond_to do |format|
        format.js { render 'backend/shared/index_options' }
      end
    end

    def remove_featured
      @item = @publication
      @item.try(:remove_featured)
      respond_to do |format|
        format.js { render 'backend/shared/index_options' }
      end
    end

    def paginate
      @publications = Publication.order("content_date DESC")
                      .limit(@publications_limit)
                      .offset(@publications_limit * (@page - 1))
      @publication_id = params[:id].present? ? params[:id].to_i : nil
      respond_to do |format|
        if(@publications.empty?)
          head :no_content
        end
        format.js
      end
    end

    private

      def publication_params
        params.require(:publication).permit!
      end

      def set_objects
        @users    = User.order_by_fullname
        @partners = Partner.order_by_name
        @media_contents = MediaContent.albums_collections_and_videos.
          order(:title)
        @content_types = ContentType.
          where(for_content: ContentType::PUBLICATION).
          order(:title)
        @tags = Tag.order(:name)
        @photos = Photo.order("publication_date DESC").includes(:photo_sizes).
          limit(20)
        @news_articles = NewsArticle.order(:title)
        @activities = Activity.order(:title)
      end

      def set_publications
        @publications = Publication.order("content_date DESC").limit(@publications_limit)
      end

      def set_page_param
        @page = params[:page].present? ? params[:page].to_i : 1
      end

      def set_publications_limit
        @publications_limit = 30
      end

  end
end
