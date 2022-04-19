# general
require "json"
require "uri"
require "faraday"
require "openssl"

# version
require "privacygate/version"

# client
require "privacygate/client"

# api response and errors
require "privacygate/api_errors"
require "privacygate/api_response"

# api base object
require "privacygate/api_resources/base/api_object"

# api resource base model
require "privacygate/api_resources/base/api_resource"

# api base operations
require "privacygate/api_resources/base/create"
require "privacygate/api_resources/base/update"
require "privacygate/api_resources/base/save"
require "privacygate/api_resources/base/list"
require "privacygate/api_resources/base/delete"

# api resources
require "privacygate/api_resources/checkout"
require "privacygate/api_resources/charge"
require "privacygate/api_resources/event"

# webhooks
require "privacygate/webhooks"

# utils
require "privacygate/util"

module PrivacyGate
end
