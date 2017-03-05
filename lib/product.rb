require_relative '../base.rb'
class Product < Base

  attr_reader :name, :price, :exclusion, :imported

  def initialize(item)
    @name = get_name(item)
    @price = get_price(item)
    @exclusion = is_exclusion?(@name)
    @imported = is_import?(item)
  end

  def get_name(item)
    start_point = item.index(/[^\d]/) + 1
    end_point = (item.index "at ") - 1
    item[start_point..end_point].strip
  end

  def get_price(item)
    start_point = (item.index "at ") + 3
    end_point = item.size
    price = item[start_point..end_point]
    price.to_f
  end

  def is_exclusion?(name)
    return false unless name
    exclusions.any? { |i| @name.include?(i) }
  end

  def exclusions
    @exclusions ||= File.open(root_path + '/inputs/exclusions.txt').to_a.map! { |item| item.chomp.downcase }
  end

  def is_import?(item)
    return false unless item
    item.include?('imported')
  end
end