class Query
  def initialize(collection)
    @collection = collection
  end

  def grouped_by_attribute(attr)
    @collection.group_by { |item| item[attr] }
  end

  def grouped_by_two_attributes(attr1, attr2)
    hash = {}
    
    grouped_by_attribute(attr1).each do |key, value|
      hash[key] = value.group_by { |item| item[attr2] }
    end

    hash
  end

  def with_attribute_values(attr, *values)
    @collection.select do |item|
      values.map do |value|
        item[attr].include? value
      end.all?
    end
  end
end