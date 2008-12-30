# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def icon(icon, options={})
    image_tag "icons/#{icon}.gif", options
  end
  
  def flash_message
    if flash[:notice]
      %{<div id="flash" class="notice">#{flash[:notice]} [#{hide_me}]</div>}
    elsif flash[:warning]
      %{<div id="flash" class="warning">#{flash[:warning]} [#{hide_me}]</div>}
    elsif flash[:note]
      %{<div id="flash" class="note">#{flash[:note]} [#{hide_me}]</div>}
    elsif flash[:alert]
      %{<div id="flash" class="alert">#{flash[:alert]} [#{hide_me}]</div>}
    elsif flash[:error]
      %{<div id="flash" class="error">#{flash[:error]} [#{hide_me}]</div>}
    end
  end
  
  def hide_me
    link_to_function "hide", "Element.hide('flash')"
  end
end
