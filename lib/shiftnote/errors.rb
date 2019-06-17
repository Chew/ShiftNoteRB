# Errors are cool.
module ShiftNote::Errors
  # Raised if the ShiftNote credentials are invalid.
  class InvalidCredentials < ArgumentError; end
end
