require "rails_helper"

describe "technology" do
  xdescribe "create" do
    # As a exloc admin,
    # I want to add a technology,
    # So that users can categorize code examples.

    # [ ] User adds a technology name, and a list of synonyms.
    # [ ] Upon creation, user is shown a successful message.
    # [ ] Form is re-rendered with errors if creation is unsuccessful.
    # [ ] Constraint: a new technology name must not match an existing synonym.
  end

  xdescribe "update" do
    # As a exloc admin,
    # I want to edit a technology,
    # So that the most relevant and correct information is displayed.
  end

  xdescribe "delete" do
    # As a exloc user,
    # I want to remove a technology,
    # So that other exloc users aren't shown frivolous tech.
  end
end
