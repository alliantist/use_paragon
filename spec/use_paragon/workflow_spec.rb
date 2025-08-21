# frozen_string_literal: true

RSpec.describe UseParagon::Workflow do
  let(:workflow) { described_class.new(123) }
  let(:connection) { double("connection") }

  before do
    allow(connection).to receive(:headers).and_return({})
    allow(connection).to receive(:headers=)
    allow(connection).to receive(:post).and_return(true)
  end

  describe "#request" do
    it "calls the correct endpoint with post method" do
      expect(workflow).to receive(:path).with("sdk/triggers/789")
                                        .and_return("/projects/123/sdk/triggers/789")
      expect(workflow).to receive(:connection).and_return(connection).exactly(3).times
      workflow.request(789, {}, headers: {test: 'value'})
    end
  end

  describe "#event" do
    it "calls the correct endpoint with post method" do
      expect(workflow).to receive(:path).with("sdk/events/trigger")
                                        .and_return("/projects/123/sdk/events/trigger")
      expect(workflow).to receive(:connection).and_return(connection).exactly(3).times
      workflow.event("some_event", {}, headers: {test: 'value'})
    end
  end

  describe "#disable" do
    it "calls the correct endpoint with delete method" do
      expect(workflow).to receive(:path).with("sdk/workflows/abc")
                                        .and_return("/projects/123/sdk/workflows/abc")
      expect(workflow).to receive(:connection).and_return(double("connection", delete: true))
      workflow.disable("abc")
    end
  end
end
