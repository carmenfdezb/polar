# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: user_id.proto

require 'google/protobuf'

require 'types_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("user_id.proto", :syntax => :proto2) do
    add_message "polar_data.PbPasswordToken" do
      required :token, :bytes, 1
      required :encrypted, :bool, 2
    end
    add_message "polar_data.PbUserIdentifier" do
      optional :master_identifier, :uint64, 1
      optional :email, :string, 2
      optional :password_token, :message, 3, "polar_data.PbPasswordToken"
      optional :nickname, :string, 4
      optional :first_name, :string, 5
      optional :last_name, :string, 6
      optional :user_id_last_modified, :message, 100, "PbSystemDateTime"
    end
  end
end

module PolarData
  PbPasswordToken = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("polar_data.PbPasswordToken").msgclass
  PbUserIdentifier = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("polar_data.PbUserIdentifier").msgclass
end
