require 'http'
require 'aws-sigv4'

# https://webservices.amazon.com/paapi5/documentation/common-request-parameters.html
module Paapi
  module AwsRequest
    def do_request(op:,  payload:)
      raise ArguemntError unless Paapi::OPERATIONS.keys.include?(op)

      operation = OPERATIONS[op]

      headers = {
        'X-Amz-Target' => "com.amazon.paapi5.v1.ProductAdvertisingAPIv1.#{operation.target_name}",
        'Content-Encoding' => 'amz-1.0',
      }

      default_payload = {
        'PartnerTag' => partner_tag,
        'PartnerType' => partner_type,
        'Marketplace' => marketplace.site
      }

      payload = default_payload.merge(payload)

      endpoint =  "https://#{marketplace.host}/paapi5/#{operation.endpoint_suffix}"

      signer = Aws::Sigv4::Signer.new(
        service: operation.service,
        region: marketplace.region,
        access_key_id: access_key,
        secret_access_key: secret_key,
        http_method: operation.http_method,
        endpoint: marketplace.host
      )

      signature = signer.sign_request(http_method: operation.http_method, url: endpoint, headers: headers, body: payload.to_json)

      headers['Host'] = marketplace.host
      headers['X-Amz-Date'] = signature.headers['x-amz-date']
      headers['X-Amz-Content-Sha256']= signature.headers['x-amz-content-sha256']
      headers['Authorization'] = signature.headers['authorization']
      headers['Content-Type'] = 'application/json; charset=utf-8'

      HTTP.headers(headers).post(endpoint, json: payload )
    end
  end
end