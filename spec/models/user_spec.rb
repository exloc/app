require "rails_helper"

describe User do
  describe ".from_omniauth" do
    it "populates all the fields for a github user" do
      json_file = Rails.root.join("docs", "authentication", "github.json")
      json = File.read(json_file)
      hash = JSON.parse(json)
      auth_hash = OmniAuth::AuthHash.new(hash)

      user = User.from_omniauth(auth_hash)

      expect(user.provider).to eq("github")
      expect(user.uid).to eq("1299034")
      expect(user.name).to eq("Richard Davis")
      expect(user.nickname).to eq("radavis")
      expect(user.email).to eq("rdavis.bacs@gmail.com")
      expect(user.image).to eq("https://avatars3.githubusercontent.com/u/1299034?v=3")
      expect(user.location).to eq("Boston, MA")
    end

    it "populates all the fields for a gitlab user" do
      json_file = Rails.root.join("docs", "authentication", "gitlab.json")
      json = File.read(json_file)
      hash = JSON.parse(json)
      auth_hash = OmniAuth::AuthHash.new(hash)

      user = User.from_omniauth(auth_hash)

      expect(user.provider).to eq("gitlab")
      expect(user.uid).to eq("1279823")
      expect(user.name).to eq("Example Lines of Code")
      expect(user.nickname).to eq("exloc")
      expect(user.email).to eq("rdavis.bacs+exloc@gmail.com")
      expect(user.image).to eq("https://secure.gravatar.com/avatar/3283fef4579bfdd507fa6e4b08205032?s=80&d=identicon")
      expect(user.location).to eq("Concord, NH")
    end
  end
end
