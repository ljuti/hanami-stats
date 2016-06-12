require_relative '../../../../apps/web/controllers/stats/show'

RSpec.describe Web::Controllers::Stats::Show do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
