class Event < ApplicationRecord
    has_many :rsvps
    has_many :users, through: :rsvps

    before_save :filter_data
    
    def build_rsvp(rsvps)
        if rsvps.present?
            rsvs = rsvps.split(';')
            rsvs.each do |rsv|
                user_resp = rsv.split('#')
                if user_resp
                    user = User.find_by(username: user_resp.first)
                    self.rsvps.build({user_id: user.id, response: user_resp.last})
                end
            end
        end
    end

    private
    def filter_data
        all_day_event = ActiveModel::Type::Boolean.new.cast(self.all_day) || false        
        self.end_time = all_day_event ? nil : self.end_time
        self.all_day = all_day_event
    end
end
