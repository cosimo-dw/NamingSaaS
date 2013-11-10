# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.wrappers :ext_bootstrap, tag: 'div', class: 'control-group ext-form-group', error_class: 'error' do |b|
    b.use :html5
    b.use :placeholder

    b.wrapper 'div_label', tag: 'div', layout: 'label' do |bb|
      bb.use :label, class: 'ext-form-label'
    end
    b.wrapper 'input', tag: 'div', layout: 'input' do |bb|
      bb.use :input
      bb.use :error, wrap_with: {tag: 'span', class: 'help-inline'}
      bb.use :hint, wrap_with: {tag: 'p', class: 'help-block text-info'}
    end

  end

  config.wrappers :ext_datetimepicker, tag: 'div', class: 'control-group ext-form-group', error_class: 'error' do |b|
    b.use :html5
    b.use :placeholder

    b.wrapper 'div_label', tag: 'div', layout: 'label' do |bb|
      bb.use :label, class: 'ext-form-label'
    end
    b.wrapper 'input', tag: 'div', layout: 'input' do |bb|
      bb.wrapper tag: 'div', class: 'input-append' do |append|
        append.use :input
        append.use :input_addon
      end
      bb.use :error, wrap_with: {tag: 'span', class: 'help-inline'}
      bb.use :hint, wrap_with: {tag: 'p', class: 'help-block text-info'}
    end
  end
  # Wrappers for forms and inputs using the Twitter Bootstrap toolkit.
  # Check the Bootstrap docs (http://twitter.github.com/bootstrap)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  # config.default_wrapper = :ext_bootstrap

  config.input_mappings = {/_date$/ => :date_picker,
                           /_time$/ => :dt_picker,
                           /_at$/ => :dt_picker}

end

ExtForm.setup do |e|
  e.layout = 'BootstrapLayout'
  e.default_wrapper = :ext_bootstrap
  e.default_layout = {
      layout: '1:1',
      spacing: '1',
      label_width: '2',
      max_width: '12'
  }
end