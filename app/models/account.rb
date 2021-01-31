class Account < ApplicationRecord
  enum minor_indicator: { yes: 0, no: 1 }
end
