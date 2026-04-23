class Security::InputValidator
  def self.sanitize(params)
    params.each do |key, value|
      if value.is_a?(String)
        params[key] = ActionController::Base.helpers.sanitize(value)
      elsif value.is_a?(Hash)
        sanitize(value)
      end
    end
    params
  end
end