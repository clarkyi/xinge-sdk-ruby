class Xinge::Base
  attr_accessor :ur, :app_id, :secret_id

  def initialize app_id, secret_id, uri
    @url = "#{Xinge::XingeApiUrl}#{uri}"
    @app_id = app_id
    @secret_id = secret_id
  end

  def is_blank? object
    return true if object.nil?
    if object.is_a?(Array)
      return object.size <= 0
    end
    if object.is_a?(Hash)
      return object.length <= 0
    end
    object == ""
  end

  def execute json
    Xinge::Client.do_post(json, @url, sign_auth)
  end

  def validate_lenght tag, size, text
    raise "#{text} length can not more than #{size}" if tag.length > size
  end

  def validate_is_blank object, text
    raise "#{text} can not be nil" if is_blank? object
  end

  def validate_is_array object, text
    raise "#{text} should be Array" if !object.is_a?(object)
  end
  
  private
    def sign_auth
      Base64.encode64("#{@app_id}:#{@secret_id}")
    end

end