require "rails_helper"

describe CodeExamplesController do
  let(:user) { create(:user) }

  xdescribe "GET /ex"
  xdescribe "GET /ex/:slug"

  describe "POST /ex" do
    it "accepts a remote git repository" do
      post :create, params: {
        git: "https://github.com/exloc/exloc-example",
        token: user.token
      }

      expect(response).to have_http_status(:created)
      expect(response.body).to include("New Exloc created @ http://")
    end

    it "requires token auth" do
      expect {
        post :create, params: {
          git: "https://github.com/exloc/exloc-example",
          token: ""
        }
      }.to raise_error(ActionController::RoutingError, "Not Found")
    end

    it "requires the git field" do
      post :create, params: {
        git: "",
        token: user.token
      }
      
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Error creating Exloc.")
    end
  end

  xdescribe "PATCH /ex/:slug"
  xdescribe "DELETE /ex/:slug"
end
