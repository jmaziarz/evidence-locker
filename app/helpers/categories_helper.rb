module CategoriesHelper
  def used_by(category)
    size = category.items.size
    
    if size.zero?
      content_tag(:span, "Not used by any items", :style => 'color: #999;')
    else
      content_tag(:span, "Used by #{link_to(pluralize(size, 'item'), category_items_path(category))}")
    end
  end
  
  def select_options(category)
    if category.child?
      return { :selected => category.parent.id }
    else
      return { :prompt => 'The top-level' }
    end
  end
  
  def nested_set_full_outline(item, options={})
    s = ''
    for it in item.self_and_ancestors
      s += it.name
      s += ' &gt ' unless it == item
    end
    s + h(item[options[:text_column]])
  end
end
