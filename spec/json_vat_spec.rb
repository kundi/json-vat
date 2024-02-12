require 'json_vat'


describe JSONVAT do
    it "Checks Slovenia's VAT is 22%" do
      expect(
        (JSONVAT.country("SI")&.rate || 0).to_f
      ).to eql(22.0)
    end

    it "Checks Estonia's VAT is 0" do
      expect(
        (JSONVAT.country("EE")&.rate || 0).to_f
      ).to eql(22.0)
    end

    it "Checks non-existing country VAT is 0" do
      expect(
        (JSONVAT.country("XX")&.rate || 0).to_f
      ).to eql(0.0)
    end
  end

