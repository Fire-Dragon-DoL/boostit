module Domain
  module Serial
    def self.random
      rand(0..9_223_372_036_854_775_807)
    end

    def self.one
      1
    end

    def self.two
      2
    end
  end
end
