module RolloutUi
  class Feature
    User = Struct.new(:id)

    attr_reader :name

    def initialize(name)
      @wrapper = Wrapper.new
      @name = name
    end

    def percentage
      percentage_key(name) || 0
    end

    def groups
      groups_key(name) || []
    end

    def user_ids
      users_key(name) || []
    end

    def percentage=(percentage)
      rollout.activate_percentage(name, percentage)
    end

    def groups=(groups)
      groups_key(name).each do |group|
        rollout.deactivate_group(name, group) unless group.to_s.empty?
      end
      groups.each { |group| rollout.activate_group(name, group) unless group.to_s.empty? }
    end

    def user_ids=(ids)
      users_key(name).each do |id|
        rollout.deactivate_user(name, User.new(id))
      end
      ids.each { |id| rollout.activate_user(name, User.new(id)) unless id.to_s.empty? }
    end

  private

    def redis
      @wrapper.redis
    end

    def rollout
      @wrapper.rollout
    end

    [:percentage_key, :groups_key, :users_key].each do |method_name|
      define_method(method_name) do |name|
        key_name = method_name.to_s.gsub("_key", "").to_sym
        rollout.get(name).to_hash[key_name]
      end
    end


  end
end
