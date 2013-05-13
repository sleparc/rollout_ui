module RolloutUi
  class GroupsController < RolloutUi::ApplicationController
    before_filter :wrapper, :only => [:create]

    def create
      @wrapper.define_intersection_group(params[:name]) unless params[:name].blank?
      redirect_to features_path
    end

  private

    def wrapper
      @wrapper = RolloutUi::Wrapper.new
    end
  end
end
