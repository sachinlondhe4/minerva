class CurrentYear < ActiveRecord::Base
 
  validate :one_id

  def one_id
    if CurrentYear.count > 1
      errors.add(:count, "Only 1 year allowed")
    end
  end
end

