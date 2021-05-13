class FutureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if !record[attribute].try(:future?)
      record.errors.add attribute, "can't be in the past!"
    end
  end
end