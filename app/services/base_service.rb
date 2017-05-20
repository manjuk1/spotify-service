class BaseService

  attr_accessor :error

  def initialize
    @error = {}
    @response_status = nil
  end

  def response_status
    @response_status
  end

  private

  def build_error err_message
    @error[:message] = err_message
  end

  def build_validation_error model
    build_error(model.errors.full_messages.join(";"))
  end

  def build_exception_error exception
    build_error("Some thing went wrong while reading the data ( #{exception.message} )")
  end

  def set_response_status status
    @response_status = status || :ok
  end

end