require "rails_helper"

describe CodeExamplesController do
  let(:user) { create(:user) }

  xdescribe "GET /ex" do

  end

  describe "GET /ex/:slug" do
    let(:ex) do
      CodeExample.create({
        name: "JavaScript print to console example",
        git: "https://github.com/exloc/js-console-log",
        content: "```js\nconsole.log('Hello World')\n```",
        user: user
      })
    end

    it "defaults to the html representation of the code example" do
      get :show, params: { slug: ex.slug, token: user.token }
      expect(response.content_type).to eq("text/html")
    end

    it "redirects to the .tarball" do
      get :show, params: { slug: ex.slug, format: "tarball", token: user.token }
      expect(response).to have_http_status(:redirect)
    end

    it "redirects to the .zip" do
      get :show, params: { slug: ex.slug, format: "zip", token: user.token }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "POST /ex" do
    before { allow(CodeExampleImportJob).to receive(:perform_later).and_return(true) }

    it "accepts a remote git repository" do
      post :create, params: {
        git: "https://github.com/exloc/example",
        token: user.token
      }

      expect(response).to have_http_status(:created)
      expect(response.body).to include("New Exloc created @ http://")
    end

    it "requires token auth" do
      expect {
        post :create, params: {
          git: "https://github.com/exloc/example",
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

    it "creates a new CodeExampleImportJob" do
      post :create, params: {
        git: "https://github.com/exloc/example",
        token: user.token
      }

      expect(CodeExampleImportJob).to have_received(:perform_later)
    end
  end

  xdescribe "PATCH /ex/:slug"
  xdescribe "DELETE /ex/:slug"
end
