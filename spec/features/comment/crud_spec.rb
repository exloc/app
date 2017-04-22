require "rails_helper"

describe "comment" do
  xdescribe "create" do
    # As a exloc user,
    # I want to comment on a code example,
    # So that I can share my perspective with others.

    # [ ] Add a comment w/ a minimum number of characters (10).
    # [ ] Upon creation, user is shown a successful message and brought to the
    #   show page for the code example, highlighting their comment.
    # [ ] Form submission is prevented, with errors displayed if unsuccessful.
  end

  xdescribe "read" do
    # As a exloc contributor,
    # I want to read what people have to say about my code example,
    # So that I know what people think about my contribution.
  end

  xdescribe "update" do
    # As a exloc user,
    # I want to edit a comment I have created,
    # So that the most relevant and correct information is displayed.
  end

  xdescribe "delete" do
    # As a exloc user,
    # I want to remove a comment I have created,
    # So that other exloc users don't read my terrible opinion.
  end
end
