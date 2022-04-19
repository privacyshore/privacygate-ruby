# frozen_string_literal: true

require 'spec_helper'

describe PrivacyGate::APIResources::Base::APIObject do
  describe "#respond_to" do
    it "should implement respond_to method" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from(id: 1, foo: "bar")
      expect(obj.respond_to?(:foo)).to be true
      expect(obj.respond_to?(:baz)).to be false
    end
  end

  describe "#serialize params" do
    it "should serialize params on an empty object" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from({})
      expect({}).to eq obj.serialize_params
    end

    it "should serialize params on a new object with a sub object" do
      obj = PrivacyGate::APIResources::Base::APIObject.new
      obj.metadata = {foo: "bar"}
      expect({metadata: {foo: "bar"}}).to eq obj.serialize_params
    end

    it "should serialize params on a basic object" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from(foo: nil)
      obj.update_attributes(foo: "bar")
      expect({foo: "bar"}).to eq obj.serialize_params
    end

    it "should serialize params on a complex object" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from(
          foo: PrivacyGate::APIResources::Base::APIObject.create_from(bar: nil, baz: nil))
      obj.foo.bar = "newbar"
      expect({foo: {bar: "newbar"}}).to eq obj.serialize_params
    end

    it "should serialize params on an array" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from(foo: nil)
      obj.foo = ["new-value"]
      expect({foo: ["new-value"]}).to eq obj.serialize_params
    end

    it "should serialize params on an array that shortens" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from(foo: ["0-index", "1-index", "2-index"])
      obj.foo = ["new-value"]
      expect({foo: ["new-value"]}).to eq obj.serialize_params
    end

    it "should serialize params on an array of hashes" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from(foo: nil)
      obj.foo = [
          PrivacyGate::APIResources::Base::APIObject.create_from(bar: nil),
      ]
      obj.foo[0].bar = "baz"
      expect({foo: [{bar: "baz"}]}).to eq obj.serialize_params
    end

    it "should serialize params doesn't include unchanged values" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from(foo: nil)
      expect({}).to eq obj.serialize_params
    end

    it "should serialize params with a APIObject" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from({})
      obj.metadata = PrivacyGate::APIResources::Base::APIObject.create_from(foo: "bar")
      serialized = obj.serialize_params
      expect({foo: "bar"}).to eq serialized[:metadata]
    end

    it "should serialize params with APIObject that's been replaced" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from(
          source: PrivacyGate::APIResources::Base::APIObject.create_from(bar: "foo"))

      obj.source = PrivacyGate::APIResources::Base::APIObject.create_from(baz: "foo")

      serialized = obj.serialize_params
      expect({baz: "foo"}).to eq serialized[:source]
    end

    it "should serialize params with an array of APIObjects" do
      stub_request(:post, "#{@api_base}charges").to_return(body: {data: mock_item}.to_json)
      obj = PrivacyGate::APIResources::Base::APIObject.create_from({})
      obj.metadata = [
          PrivacyGate::APIResources::Base::APIObject.create_from(foo: "bar"),
      ]

      serialized = obj.serialize_params
      expect([{foo: "bar"}]).to eq serialized[:metadata]
    end

    it "should serialize params with embed API resources" do
      charge = PrivacyGate::APIResources::Charge.create_from(id: "charge_id")
      obj = PrivacyGate::APIResources::Base::APIObject.create_from({})
      obj.charge = charge
      expect(obj.charge).is_a? PrivacyGate::APIResources::Charge
    end

    it "should serialize params and not include API resources that have not been set" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from(id: "cus_123")
      obj2 = PrivacyGate::APIResources::Base::APIObject.create_from(obj: obj)
      serialized = obj2.serialize_params
      expect({}).to eq serialized
    end

    it "should serialize params takes a push option" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from(
          id: "id", metadata: PrivacyGate::APIResources::Base::APIObject.create_from(foo: "bar"))
      serialized = obj.serialize_params(push: true)
      expect({id: "id", metadata: {foo: "bar"}}).to eq serialized
    end
  end

  describe "update attributes" do
    it "should update attributes with a hash" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from({})
      obj.update_attributes(metadata: {foo: "bar"})
      expect(obj.metadata.class).to eq PrivacyGate::APIResources::Base::APIObject
    end

    it "should assign question mark accessors for booleans added after initialization" do
      obj = PrivacyGate::APIResources::Base::APIObject.new
      obj.bool = true
      expect(obj.respond_to?(:bool?)).to be true
      expect(obj.bool?).to be true
    end

    it "should assign question mark accessors for booleans" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from(id: 1, bool: true, not_bool: "bar")
      expect(obj.respond_to?(:bool?)).to be true
      expect(obj.respond_to?(:not_bool)).to be true
      expect(obj.bool?).to be true
    end

    it "should create accessors when update attributes is called" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from({})
      expect(obj.send(:metaclass).method_defined?(:foo)).to eq false
      obj.update_attributes(foo: "bar")
      expect(obj.send(:metaclass).method_defined?(:foo)).to eq true
    end

    it "should update attributes with a hash" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from({})
      obj.update_attributes(metadata: {foo: "bar"})
      expect(PrivacyGate::APIResources::Base::APIObject).to eq obj.metadata.class
    end

    it "should create accessors when update attributes is called" do
      obj = PrivacyGate::APIResources::Base::APIObject.create_from({})
      expect(obj.send(:metaclass).method_defined?(:foo)).to be false
      obj.update_attributes(foo: "bar")
      expect(obj.send(:metaclass).method_defined?(:foo)).to be true
    end
  end
end
