# frozen_string_literal: true

Rails.application.config.action_dispatch.default_headers = {
  # Prevent clickjacking
  'X-Frame-Options' => 'SAMEORIGIN',
  
  # XSS protection
  'X-XSS-Protection' => '1; mode=block',
  
  # Prevent MIME type sniffing
  'X-Content-Type-Options' => 'nosniff',
  
  # Referrer policy
  'Referrer-Policy' => 'strict-origin-when-cross-origin',
  
  # Permissions policy
  'Permissions-Policy' => 'camera=(), microphone=(), geolocation=(), payment=()'
} 