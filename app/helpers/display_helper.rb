module DisplayHelper
  def link_with_icon(link, action, id, description, confirm="", turbo=true)	
    case action 
    when "show"
      a_tag = <<-HTML
      <a href="#{link}" id="#{id}" >
      <i class="far fa-file-alt fa-2x trunfo-main" 
      aria-hidden="true" 
      data-html = "true" 
      data-toggle="tooltip" 
      title="#{description}" 
      data-placement="right">
      </i>
      </a>
      HTML
    when "edit"
      a_tag = <<-HTML
      <a data-turbolinks="#{turbo}" 
      href="#{link}" id="#{id}">
      <i class="fas fa-edit fa-2x trunfo-main" 
      aria-hidden="true" 
      data-html = "true" 
      data-toggle="tooltip" 
      title="#{description}" 
      data-placement="right">
      </i>
      </a>
      HTML

    when "delete" 
      a_tag = <<-HTML
      <a data-confirm="#{confirm}" rel="nofollow" data-method="delete" 
      href="#{link}" id="#{id}">
      <i class="far fa-trash-alt fa-2x trunfo-main" 
      aria-hidden="true" 
      data-html = "true" 
      data-toggle="tooltip" 
      title="#{description}" 
      data-placement="right">
      </i>
      </a>
      HTML

    when "manage"  
      a_tag = <<-HTML
      <a data-turbolinks="#{turbo}" 
      href="#{link}" id="#{id}" >
      <i class="far fa-folder fa-2x trunfo-main" 
      aria-hidden="true" 
      data-html = "true" 
      data-toggle="tooltip" 
      title="#{description}" 
      data-placement="right">
      </i>
      </a>
      HTML

    end 
    a_tag.html_safe
  end

end           