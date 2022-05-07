class LeaseSerializer < ActiveModel::Serializer
  attributes :id, :rent, :tenant_id, :apartment_id
end
