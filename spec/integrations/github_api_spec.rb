require "rails_helper"

RSpec.describe GitHub::API do
  describe "#get_attributes" do
    let(:options) { { owner: "exloc", repo: "example" } }

    it "returns data from the API" do
      attrs = GitHub::API.new(:files, options).get_attributes
      expect(attrs).to be_an(Array)
      expect(attrs.first).to be_a(Hash)
      expect(attrs.first["name"]).to eq("README.md")
      expect(attrs.last["name"]).to eq("hello.js")
    end
  end

  describe "#path" do
    let(:options) { { owner: "radavis", repo: "rails-example" } }

    it "returns the API path for the repo" do
      path = GitHub::API.new(:repo, options).path
      expect(path).to eq("/repos/radavis/rails-example")
    end

    it "returns the API path for a readme file" do
      path = GitHub::API.new(:readme, options).path
      expect(path).to eq("/repos/radavis/rails-example/readme")
    end

    it "returns the API path for files in a repo" do
      path = GitHub::API.new(:files, options).path
      expect(path).to eq("/repos/radavis/rails-example/contents")
    end

    it "returns the API path for a file in a repo" do
      path = GitHub::API.new(:file, options.merge({ file: ".ruby-version" })).path
      expect(path).to eq("/repos/radavis/rails-example/contents/.ruby-version")
    end
  end
end
