# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    # Default source whitelist
    policy.default_src :self, :https
    
    # Font sources includes Font Awesome and Bootstrap
    policy.font_src    :self, :https, :data, 'https://cdn.jsdelivr.net', 'https://cdnjs.cloudflare.com'
    
    # Image sources
    policy.img_src     :self, :https, :data
    
    # No plugins/embedded objects allowed
    policy.object_src  :none
    
    # JavaScript sources - includes Bootstrap and Font Awesome additionaly
    policy.script_src  :self, :https, 'https://cdn.jsdelivr.net', 'https://cdnjs.cloudflare.com'
    
    # Stylesheet sources - includes Bootstrap and Font Awesome additionaly
    policy.style_src   :self, :https, 'https://cdn.jsdelivr.net', 'https://cdnjs.cloudflare.com'
    
    # Form submissions only to our own server
    policy.form_action :self
    
    # Only allow frames from same origin
    policy.frame_ancestors :self
    
    # Allow connection to our own server only
    policy.connect_src :self
  end

  # Create nonces for permitted inline scripts and styles
  config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  config.content_security_policy_nonce_directives = %w(script-src style-src)

  # Report violations without enforcing the policy.
  # config.content_security_policy_report_only = true
end
