require 'rails_helper'

RSpec.describe Services::PageGetter do

  before(:each) do
    stub_const(
      'Services::PageGetter::PAGE_URL',
      "file://#{File.join(Rails.root, 'spec', 'support', 'PMI Online Registry.html')}"
    )
    @pmi_parser = Services::PageGetter.new
  end

  after(:each) do
    PmiCredential.delete_all
    PmiUser.delete_all
  end

  it 'creates credentials' do
    expect { @pmi_parser.call }.to change { PmiCredential.count }.by(83)
  end

  it 'creates credentials when name line is empty' do
    @pmi_parser.call
    expect(PmiUser.find_by_name('Alexey Abramov').pmi_credentials.count).to eq(2)
  end
end