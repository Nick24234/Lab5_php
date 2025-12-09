json.extract! transfer, :id, :sender, :receiver, :amount, :created_at, :updated_at
json.url transfer_url(transfer, format: :json)
