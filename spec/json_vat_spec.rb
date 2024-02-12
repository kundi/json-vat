require 'json_vat'


describe JSONVAT do
    it "Slovenia's VAT is 22%" do
      expect(
        (JSONVAT.country("SI")&.rate || 0).to_f
      ).to eql(22.0)
    end

    it "XX's VAT is 0" do
      expect(
        (JSONVAT.country("XX")&.rate || 0).to_f
      ).to eql(0.0)
    end
  end
