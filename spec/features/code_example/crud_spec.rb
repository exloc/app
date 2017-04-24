require "rails_helper"

describe "code example" do
  xdescribe "create (from a git repo)" do
    # As a exloc user,
    # I want to add a code example from a git repository,
    # So that others can view it.

    # [ ] User adds a url to a git repository, and a title.
    # [ ] User selects at least one technology relevant to this example.
    # [ ] The following files must be present in the repo:
    #   - metadata.json
    #   - index.md
    # [ ] Upon creation, user is shown a successful message and brought to the
    #   show page for the code example.
    # [ ] Form is re-rendered with errors if unsuccessful.
  end

  xdescribe "create (from an external source)" do
    # As a exloc user,
    # I want to add a code example from an article or other source,
    # So that others can view it.

    # [ ] User adds an example using markdown and gives it a title.
    # [ ] User selects at least one technology relevant to this example.
    # [ ] User adds one or more URL sources for this example.
    # [ ] Upon creation, user is shown a successful message and brought to the
    #   show page for the code example.
    # [ ] Form is re-rendered with errors if unsuccessful.
  end

  describe "read" do
    it "shows an index page of code examples" do
      user = create(:user)
      ex = CodeExample.create(
        name: "Ruby",
        description: "An example in Ruby.",
        content: "puts 'Hello World'",
        user: user
      )

      ex2 = CodeExample.create(
        name: "JavaScript",
        description: "An example in JavaScript.",
        content: "console.log('Hello World')",
        user: user
      )
      
      ex3 = CodeExample.create(
        name: "Golang",
        description: "An example in Ruby.",
        content: "fmt.Println('Hello World')",
        user: user
      )

      visit ex_index_path
      expect(page).to have_content("Ruby")
      expect(page).to have_content("JavaScript")
      expect(page).to have_content("Golang")
    end
  end

  xdescribe "update" do
    # As a exloc user,
    # I want to edit a code example I have created,
    # So that the most relevant and correct information is displayed.
  end

  xdescribe "delete" do
    # As a exloc user,
    # I want to remove a code example I have created,
    # So that other exloc users aren't shown bad examples.
  end
end
