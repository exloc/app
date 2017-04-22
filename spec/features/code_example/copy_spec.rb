describe "code example" do
  xdescribe "copy" do
    # As a exloc user,
    # I want to clone and modify a code example,
    # So that I may improve upon it.

    xit "allows users to clone an example using curl" do
      # curl --request GET -H "authToken: $EXLOC_TOKEN"` exloc.io/ex/slug
      # cd example-name
      # hub create (or http post to github api via curl, for consistency)
      #   `curl -H "authToken: $GITHUB_TOKEN"`
      # git push origin master
      # curl --request POST --data "git=github.com/username/example-name" -H "authToken: $EXLOC_TOKEN" exloc.io/examples
    end

  end
end
