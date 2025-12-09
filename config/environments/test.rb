Rails.application.configure do
  config.cache_classes = false
  config.action_view.cache_template_loading = true
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{1.hour.to_i}"
  }
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection = false
  config.active_support.deprecation = :stderr
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
end

