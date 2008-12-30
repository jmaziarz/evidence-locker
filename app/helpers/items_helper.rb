module ItemsHelper
  def origin(object)
    origin = object.origin ||= object.root.origin
    origin.empty? ? "unknown source" : origin
  end
  
  def origin_date(object)
    origin_date = object.originated_at ||= object.root.originated_at
    origin_date.strftime("%B %d, %Y")
  end
  
  def stringification(object)
    object.class.to_s.downcase
  end
end
