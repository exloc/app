require "rails_helper"

RSpec.describe CodeExample do
  let(:user) { create(:user) }
  let(:ex) { CodeExample.create({ git: "https://github.com/exloc/example", user: user }) }

  describe "#git_example?" do
    it "returns true for an example with the git field present" do
      expect(ex.git_example?).to eq(true)
    end
  end

  describe "#local_example?" do
    it "returns false for a git example" do
      expect(ex.local_example?).to eq(false)
    end
  end
end
