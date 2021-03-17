module LogsHelper
    def self.create(description = "", user_id)
        logs = Log.new(description: description, user_id: user_id)
        logs.save!
    end    
end
