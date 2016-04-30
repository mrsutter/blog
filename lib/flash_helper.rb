module FlashHelper
  def bootstrap_class(flash_type)
    bootstrap_classes = {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }
    bootstrap_classes.fetch(flash_type.to_sym)
  end

  def flash_translate(key, options = {})
    scope = [:flash, :controllers]
    scope += params[:controller].split('/')
    scope << params[:action]

    t(key, { scope: scope }.merge(options))
  end
end
