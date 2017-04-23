require "rails_helper"

describe CodeExample do
  describe "#create" do
    let(:user) { create(:user) }

    it "generates a slug for git examples" do
      example = CodeExample.new({ git: "https://github.com/exloc/example", user: user })
      example.save
      expect(example.slug).to eq("exloc-example")
    end

    it "adds the id to the slug if the slug is already taken" do
      example = CodeExample.create({ git: "https://github.com/exloc/example", user: user })
      ex2 = CodeExample.create({ git: "https://github.com/exloc/example", user: user })
      expect(ex2.slug).to eq("exloc-example-#{ex2.id}")
    end

    it "generates a slug for local examples" do
      example = CodeExample.create({
        name: "Sample Jasmine Tests",
        content: "require('jasmine')",
        user: user
      })

      expect(example.slug).to eq("sample-jasmine-tests")
    end
  end
end
