require_relative 'hello'

RSpec.describe Hello do
  it 'returns "Hello World!"' do
    greeting = Hello.say_hello
    expect(greeting).to eq 'Hello World!'
  end
end
