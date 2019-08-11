require 'rails_helper'

RSpec.describe Event, type: :model do

  subject {
    Event.new({
      title: "Philadelphia maki Fest", 
      start_time: "2019-01-18 10:45:11 +0530", 
      end_time: "2019-01-18 08:45:11 +0530", 
      description: "Milk", 
      all_day: "true"
    })
  } 

  context "when saved" do
    it "end time must be ignored if event is a all day event" do
      subject.save 
      expect(subject.end_time).to be(nil)
    end

    it "all_day must be boolean even if string is passed in params" do
      subject.save
      expect(subject.all_day).to be_in([true, false])
    end
  end
end
