class Cloverly::Estimate
  include Cloverly::Base

  def purchase!
    Cloverly::Purchase.parse(@cloverly_instance, @cloverly_instance.post("/2019-03-beta/purchases", {estimate_slug: self.slug}))
  end

  def cancel!
    self.attributes = @cloverly_instance.delete("/2019-03-beta/estimates/#{slug}")
  end

  class << self

    def retrieve(cloverly_instance = nil, slug)
      Cloverly::Estimate.parse(Cloverly.default, Cloverly.default.get("/2019-03-beta/estimates/#{slug}"))
    end

    def list
      Cloverly::Estimate.parse(Cloverly.default, Cloverly.default.get("/2019-03-beta/estimates/#{slug}"))
    end

    def shipping(args)
      Cloverly.default.estimate_offset("shipping", args)
    end

    def carbon(args)
      Cloverly.default.estimate_offset("carbon", args)
    end

    def vehicle(args)
      Cloverly.default.estimate_offset("vehicle", args)
    end

  end
end
