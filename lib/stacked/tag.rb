module Stacked
  class Tag < Base
    attr_accessor :count,
                  :name

    collection :popular, :name, :recent

  end
end