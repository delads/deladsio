module ApplicationHelper
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def gravatar_for(maker, options = {size: 80})
    gravatar_id = Digest::MD5::hexdigest(maker.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: maker.makername, class: "gravatar")
end
end
