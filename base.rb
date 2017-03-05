class Base
  def ceil_to_2(number)
    (number * 10**2).ceil.to_f / 10**2
  end

  def root_path
    File.expand_path File.dirname(__FILE__)
  end
end
