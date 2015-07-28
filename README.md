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
denmark:
  name: Denmark
  capital: Copenhagen

england:
  name: England
  language: English
  capital: London
  center:
    - 53.562925
    - 1.806361
  features:
    - :drive_on_left_side
  cities:
    :london:
      :name: London
      :status: :capital
```

The outermost keys (in this case `denmark` and `england` will be discarded. They are only used as primary keys for merging multiple data files. (See the section "Merge files from multiple file paths").

Merge files from multiple file paths
------------------------------------

The file paths can be changed by setting `FixedModel.file_paths`. The default is:

```
FixedModel.file_paths = ['config/fixed_models']
```

The data in latter file paths will override values in the former. This makes it possible to set values specific to different environments. For example, the `countries.yml` file from the previous section might have different names in production. The file `config/fixed_models/production/countries.yml` can specify that:

```yaml
---
england:
  name: ENGLAND
```

In the case of arrays and hashes, the former files will be appended to the latter. So in the example below England would end up with both the `:rail_roads` and the `:drive_on_left_side` features. As well as the cities `:london` and `:manchester`:

```yaml
---
england:
  name: England
  features:
   - :rail_roads
  cities:
    :manchester:
      :name: Manchester
```

The default file paths depend on the environment. In the development environment, the data will be read from `config/fixed_models` and `config/fixed_models/development`. To change this behavior, set:

```ruby
FixedModel.use_environment_file_paths = false
```

Supported methods
-----------------

Fixed Models support the most common methods used on ActiveRecord models:

Class methods:
```
find, first, second, third, fourth, last, all, count, each, attribute_names
```

Dynamic class methods. (here, attribute name is `capital`)
```
find_by_capital, find_by_capital! 
```

Instance methods:
```
persisted?, new_record?, read_attribute
```

Dynamic instance methods:
```
capital, capital?, attribute_names
```
