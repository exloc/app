## API to Schema Mapping

Use a class to define the mapping of:

* API JSON data to ActiveRecord objects
* ~Serialize AR objects to JSON data~ Let AMS take care of this.

```no-highlight
ObjectParams.new(params) -> object_hash
ObjectParams.new(params) -> ar_object
Object.from_params(params)
APIMapper
GitHubAPIUserMap.new(params).to_user
GitHubAPIRepositoryMap.new(params).to_code_example
BitBucketAPI::User.new(params).to_hash
```

## Names

service mapper
map to service
api map
api to object mapper
api object

GitHub Repo -> Repo JSON -> Params Hash -> [CodeExample Hash] -> CodeExample AR Object -> CodeExample DB Relation

Response body vs params

## Form Object

```no-highlight
class FormObject
  include ActiveModel::Model  # mix in methods from ActiveModel::Model

  attr_accessor :form_field_one, :form_field_two, :form_field_etc

  validates :form_field_two, presence: true
  validates :form_field_two, uniqueness: true

  def submit  # or post or something
    if valid?
      # create related object
    end
  end
end
```

## Service Objects

Perform a service.

* Authentication
* Authorization

```no-highlight
ServiceName.new(params).result
Authentication.new(user_params).user
```

## Lazily load code repos

Override the `find` method on the `CodeExample` model.

```no-highlight
if ex.git_example? && ex.never_updated?
  api_object = GitAPI.get(ex.git)
  ex.update_attributes = GitAPIObjectMap.new(api_object).to_code_example
end
```


## GET code example from CLI

* pass url of file to client?
* download file through exloc?
  - file hosting?
  - passthrough to github?


## exloc bash-cli as an exloc

Meta as hell. Create a cli in bash for exloc that you download and setup through exloc. People can duplicate this in other languages.
