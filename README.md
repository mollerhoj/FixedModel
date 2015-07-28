Fixed Model
==========

Fixed Models act like ActiveRecord models, but they are immutable and read from data files.

Sometimes we need static data in our applications. It can often be modeled as models in the MVC pattern. Instead of storing such data in the database, it can be useful to store the data in simple datafiles.

This has several advantages:

- It makes it easier for developers to quickly inspect and edit the data.
- It is trivial to make sure the data is never modified.
- It makes it easier to make assumptions about what records exists.

Installing
-----------
Include `gem fixed_model` in your `Gemfile` and run `bundle install`

Usage
-----------

To use a FixedModel, inherit from `FixedModel::Base`:

```ruby
class Country < FixedModel::Base
  
end
```

The model will read from `config/fixed_models/countries.*`, an example of such a file could be `countries.yml`:

```yaml
---
- :name: Denmark
  :capital: Copenhagen

- :name: England
  :language: English
  :capital: London
  :center:
    - 53.562925
    - 1.806361
  :features:
    - :drive_on_left_side
  :cities:
    :london:
      :name: London
      :status: :capital
```

The file paths can be changed by setting `config.fixed_model.file_paths`:

```
config.fixed_model.file_paths = ['config/data']
```

Merge files from multiple file paths
------------------------------------

The default file paths depend on the environment. In the development environment, the data will be read from `config/fixed_models` and `config/fixed_models/development`.

The data in latter file paths will override values in the former. This makes it possible to set values specific to different environments. For example, the `countries.yml` file from the previous section might have different names in production. The file `config/fixed_models/production/countries.yml` can specify that:

```yaml
---
- :name: ENGLAND
```

In the case of arrays and hashes, the former files will be appended to the latter. So in the example below England would end up with both the `:rail_roads` and the `:drive_on_left_side` features. As well as the cities `:london` and `:manchester`:

```yaml
---
- :name: England
  :features:
    - :rail_roads
  :cities:
    :manchester:
      :name: Manchester
```

Supported file formats
----------------------
Fixed Models supports data files specied with the yaml of csv format.

- Example of a yml file:
```yaml
---
- :name: Denmark
  :capital: Copenhagen

- :name: England
  :language: English
```

- Example of a csv file:
```csv
name     , capital     , language
"Denmark", "Copenhagen",        
"Englang",             , "English"
```

TODO:
-----------
- Associations
- (Load csv files)
- Remove database dependency
