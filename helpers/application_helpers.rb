module ApplicationHelpers
  def template(base, id)
    path = "#{base}/#{id.gsub('-', '/')}" 
    content_tag :script, type: "text/html", id: id do
      partial path
    end
  end

  def js_field_errors(namespace, field)
    content = "text: errors.#{namespace}().#{field}"
    visible = "visible: show_errors.#{namespace}().#{field}"
    content_tag :div, class: 'alert-box error radius', data: { alert: '', bind: visible } do
      content_tag :span, '', data: { bind: content }
    end
  end

  def check_circle(field, check_binding, on_icon, off_icon)
    content_tag :div, class: 'buttons-check round only-icon' do
      content_tag(:input, '', id: "check-#{field}", type: 'checkbox', data: { bind: "checked: #{check_binding}" }) <<
      content_tag(:label, for: "check-#{field}") do
        "<!-- ko if: #{check_binding}() -->" <<
        fa_icon(on_icon) <<
        "<!-- /ko -->" <<
        "<!-- ko if: !#{check_binding}() -->" <<
        fa_icon(off_icon) <<
        "<!-- /ko -->"
      end
    end
  end

  def ko(attribute, css = '')
    content_tag :span, '', class: css, data: { bind: "text: #{attribute}" }
  end

  def fa_icon(name)
    content_tag :i, nil, class: "fa fa-#{name}"
  end
end