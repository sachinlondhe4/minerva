class Event < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :nurse
  has_event_calendar
  
  validates_presence_of :name, :start_at, :end_at
  validates :all_day, :inclusion => {:in => [true, false]}

  validates_with Rules
  
  def self.all_display_columns
    ['start date', 'end date', 'Change vacation', '']
  end

  def self.read_only_display_columns
    ['start date', 'end date']
  end


  def color
    if self.pto
      "#791275"
    else
      "#7c7c7c" # gray
    end
  end

end
