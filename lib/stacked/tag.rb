module Stacked
  class Tag < Base
    attr_accessor :count,
                  :name

    collection :popular
    collection :name
    collection :recent

  end
end