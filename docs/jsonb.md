## JSONB

jsob support in Rails v4.2

```no-highlight
class AddJsonbColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :preferences, :jsonb, null: false, default: '{}'
    add_index  :users, :preferences, using: :gin
  end
end
```

## Resources

* [Using jsonb/postgres/rails](http://nandovieira.com/using-postgresql-and-jsonb-with-ruby-on-rails)
* [PSQL: JSON Functions and Operators](https://www.postgresql.org/docs/9.4/static/functions-json.html)
* [JSONb Accessor](https://github.com/devmynd/jsonb_accessor)
