require 'spec_helper'

describe RolloutUi::GroupsController, :type => :controller do
  let(:wrapper) { RolloutUi::Wrapper.new }

  context 'Engine' do
    describe '#create' do
      it 'defines a new group' do
        wrapper.groups.should == [:all]

        post :create, :name => 'group_test', :use_route => :rollout

        wrapper.groups.should == [:all, :group_test]
      end

      it 'redirects to the list of features' do
        post :create, :name => 'group_test', :use_route => :rollout

        response.should redirect_to(features_path)
      end
    end
  end
end
