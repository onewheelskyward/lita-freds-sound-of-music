require 'spec_helper'

describe Lita::Handlers::OnewheelFredsSoundOfMusic, lita_handler: true do
  it 'will list the items' do
    mock_fixture('freds')
    send_command 'freds '
    expect(replies.last).to eq('Yamaha CT-1010 was $385.00, now $299.95  https://google.com?q=Yamaha+CT-1010')
    expect(replies.length).to eq(176)
  end

  it 'will search for an item' do
    mock_fixture('freds')
    send_command 'freds mx130'
    expect(replies.length).to eq(1)
    expect(replies.last).to eq('Mcintosh MX130 was $4800.00, now $999.95  https://google.com?q=Mcintosh+MX130')
  end

  it 'will search for an item by brand' do
    mock_fixture('freds')
    send_command 'freds mci'
    expect(replies.length).to eq(3)
    expect(replies[0]).to eq('Mcintosh MX130 was $4800.00, now $999.95  https://google.com?q=Mcintosh+MX130')
    expect(replies[1]).to eq('Mcintosh MC502 was $1200.00, now $895.00  https://google.com?q=Mcintosh+MC502')
    expect(replies.last).to eq('Mcintosh MR80 was $2499.00, now $1295.00  https://google.com?q=Mcintosh+MR80')
  end
end
