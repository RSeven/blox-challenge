class AfterValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if record[attribute].blank?

    time = Time.now if options[:with] == :now
    time ||= record[options[:with]]

    return if time.blank?

    if !(record[attribute] > time)
      record.errors.add attribute, "should be a time after #{time}!"
    end
  end
end