require 'spec_helper'

describe Lita::Handlers::OnewheelFredsSoundOfMusic, lita_handler: true do
  it 'will list the items' do
    mock_fixture('freds')
    send_command 'freds '
    expect(replies.last).to eq('Yamaha CT-1010 was $385.00, now $299.95')
  end
end
