require_relative '../spec_helper'
require_relative '../../app/intent_actioner'

describe IntentActioner do
  let(:request) { double :request, intent: intent, parameters: parameters }
  let(:intent) { nil }
  let(:parameters) { nil }

  describe '.new' do
    subject { described_class.new(request) }

    it 'Returns an instance of itself' do
      expect(subject).to be_a IntentActioner
    end
  end

  describe '#call' do
    subject { described_class.new(request).call }

    context 'when request action is `forum_latest`' do
      let(:intent) { 'forum_latest' }
      let(:latest_action) { double :latest_action }

      before :each do
        allow(LatestAction).to receive(:call)
                                 .and_return(latest_action)
      end

      it 'returns return LatestAction class' do
        expect(subject).to eq latest_action
      end
    end

    context 'when request action is `forum_top`' do
      let(:intent) { 'forum_top' }
      let(:top_action) { double :top_action }

      before :each do
        allow(TopAction).to receive(:call)
                              .and_return(top_action)
      end

      it 'returns return TopAction class' do
        expect(subject).to eq top_action
      end
    end

    context 'when request action is `forum_search`' do
      let(:intent) { 'forum_search' }
      let(:parameters) { double :parameters }
      let(:search_action) { double :search_action }

      before :each do
        allow(SearchAction).to receive(:call)
                                 .with(parameters)
                                 .and_return(search_action)
      end

      it 'returns return SearchAction class' do
        expect(subject).to eq search_action
      end
    end
  end
end
