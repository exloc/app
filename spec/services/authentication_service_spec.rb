require "rails_helper"

describe AuthenticationService do
  describe "#user" do
    it "authenticates a github user" do
      json_file = Rails.root.join("docs", "authentication", "github.json")
      json = File.read(json_file)
      hash = JSON.parse(json)
      auth_hash = OmniAuth::AuthHash.new(hash)

      user = AuthenticationService.new(auth_hash).user

      expect(user.provider).to eq("github")
      expect(user.uid).to eq("1299034")
      expect(user.name).to eq("Richard Davis")
      expect(user.nickname).to eq("radavis")
      expect(user.email).to eq("rdavis.bacs@gmail.com")
      expect(user.image).to eq("https://avatars3.githubusercontent.com/u/1299034?v=3")
      expect(user.location).to eq("Boston, MA")
      expect(user.persisted?).to eq(false)
    end

    it "authenticates a gitlab user" do
      json_file = Rails.root.join("docs", "authentication", "gitlab.json")
      json = File.read(json_file)
      hash = JSON.parse(json)
      auth_hash = OmniAuth::AuthHash.new(hash)

      user = AuthenticationService.new(auth_hash).user

      expect(user.provider).to eq("gitlab")
      expect(user.uid).to eq("1279823")
      expect(user.name).to eq("Example Lines of Code")
      expect(user.nickname).to eq("exloc")
      expect(user.email).to eq("rdavis.bacs+exloc@gmail.com")
      expect(user.image).to eq("https://secure.gravatar.com/avatar/3283fef4579bfdd507fa6e4b08205032?s=80&d=identicon")
      expect(user.location).to eq("Concord, NH")
      expect(user.persisted?).to eq(false)
    end

    it "populates all the fields for a twitter user" do
      json_file = Rails.root.join("docs", "authentication", "twitter.json")
      json = File.read(json_file)
      hash = JSON.parse(json)
      auth_hash = OmniAuth::AuthHash.new(hash)

      user = AuthenticationService.new(auth_hash).user

      expect(user.provider).to eq("twitter")
      expect(user.uid).to eq("855574946692702208")
      expect(user.name).to eq("exloc")
      expect(user.nickname).to eq("exlocApp")
      expect(user.email).to eq("rdavis.bacs+exloc@gmail.com")
      expect(user.image).to eq("http://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png")
      expect(user.location).to eq("Watertown, MA")
      expect(user.persisted?).to eq(false)
    end
  end
end
