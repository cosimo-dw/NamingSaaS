# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Wrappers are used by the form builder to generate a
  # complete input. You can remove any component from the
  # wrapper, change the order or even add your own to the
  # stack. The options given below are used to wrap the
  # whole input.
  config.wrappers :ext, class: 'ext-default-form',
    hint_class: :field_with_hint, error_class: :error do |b|
    ## Extensions enabled by default
    # Any of these extensions can be disabled for a
    # given input by passing: `f.input EXTENSION_NAME => false`.
    # You can make any of these extensions optional by
    # renaming `b.use` to `b.optional`.

    # Determines whether to use HTML5 (:email, :url, ...)
    # and required attributes
    b.use :html5

    # Calculates placeholders automatically from I18n
    # You can also pass a string as f.input placeholder: "Placeholder"
    b.use :placeholder

    ## Optional extensions
    # They are disabled unless you pass `f.input EXTENSION_NAME => :lookup`
    # to the input. If so, they will retrieve the values from the model
    # if any exists. If you want to enable the lookup for any of those
    # extensions by default, you can change `b.optional` to `b.use`.

    # Calculates maxlength from length validations for string inputs
    b.optional :maxlength

    # Calculates pattern from format validations for string inputs
    b.optional :pattern

    # Calculates min and max from length validations for numeric inputs
    b.optional :min_max

    # Calculates readonly automatically from readonly attributes
    b.optional :readonly

    b.wrapper 'div_label', tag: 'div', layout: 'label' do |ba|
      ba.use :label
    end
    ## Inputs
    b.wrapper 'input', tag: 'div', layout: 'input' do |ba|
      ba.use :input
      ba.use :error, wrap_with: {tag: 'p', class: 'help-block'}
      ba.use :hint, wrap_with: {tag: 'p', class: 'help-block'}
    end
  end

  config.label_class = 'ext-form-label'
  config.collection_value_methods = [:id, :to_value, :to_s]
  # config.default_wrapper = :ext
end

ExtForm.setup do |e|
  # Layout manager, default value: 'DefaultLayout'
  # e.layout = 'BootstrapLayout'
  e.layout = 'DefaultLayout'
  e.default_wrapper = :ext
  e.default_layout = {
      layout: '1:1',
      spacing: '10',
      label_width: '15',
      max_width: '100',
      measure: '%'
  }
end
