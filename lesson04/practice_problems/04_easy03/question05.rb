class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new # Instantiate a Television object.
tv.manufacturer # => NoMethodError - `manufacturer` is a class method.
tv.model # => `tv` instance's `model` return value.

Television.manufacturer # Television class' `manufacturer` return value.
Television.model # NoMethodError - `model` is an instance method.
