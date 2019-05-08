class Cloverly::Purchase
  include Cloverly::Base

  def self.retrieve(slug)
    self.parse(Cloverly.default, Cloverly.default.get("/2019-03-beta/purchases/#{slug}"))
  end

  def cancel!
    self.attributes = @cloverly_instance.delete("/2019-03-beta/purchases/#{slug}")
  end

  class << self

    def retrieve(slug)
      Cloverly::Purchase.parse(Cloverly.default, Cloverly.default.get("/2019-03-beta/purchases/#{slug}"))
    end

    def list
      Cloverly::Purchase.parse(Cloverly.default, Cloverly.default.get("/2019-03-beta/purchases/#{slug}"))
    end

    def shipping(args)
      Cloverly.default.offset("shipping", args)
    end

    def carbon(args)
      Cloverly.default.offset("carbon", args)
    end

    def vehicle(args)
      Cloverly.default.offset("vehicle", args)
    end

  end

end
