def parse_source_data
  file = Rails.root.join('db/seeds', 'categories.yml')
  YAML.load_file(file)
end

def find_or_create_category(name, parent)
  Category.find_or_create_by(name: name) do |category|
    category.parent = parent
  end
end

def find_or_create_categories(categories, parent = nil)
  categories.each do |name, childs|
    category = find_or_create_category(name, parent)

    if childs.is_a?(Hash) || childs.is_a?(Array)
      find_or_create_categories(childs, category)
    end
  end
end

categories = parse_source_data
find_or_create_categories(categories)
