# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rapporto/version'

Gem::Specification.new do |spec|
  spec.name          = "rapporto"
  spec.version       = Rapporto::Version.to_s
  spec.authors       = ["Fokin Eugene"]
  spec.email         = ["e.fokin@revoup.ru"]
  spec.description   = %q{This library helps to send sms via Rapporto service}
  spec.summary       = %q{Send sms via Rapporto service}
  spec.homepage      = "https://github.com/RevoTechnology/rapporto"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.require_paths = ["lib"]

  spec.add_dependency 'russian', '0.6.0'
end
