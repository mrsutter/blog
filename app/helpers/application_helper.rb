module ApplicationHelper
  def category_tree_for_select
    category_options(Category.arrange(order: :name))
  end

  private

  def category_options(categories)
    result = []
    categories.map do |category, sub_categories|
      category_name = category.human_attribute_value(:name)
      result << [category_name, category.id, { depth: category.depth }]
      result += category_options(sub_categories)
    end
    result
  end
end
