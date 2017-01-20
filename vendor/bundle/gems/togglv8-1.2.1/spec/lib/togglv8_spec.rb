require 'fileutils'

describe 'TogglV8' do
  it 'initializes with api_token' do
    toggl = TogglV8::API.new(Testing::API_TOKEN)
    me = toggl.me
    expect(me).to_not be nil
    expect(me['api_token']).to eq Testing::API_TOKEN
    expect(me['email']).to eq Testing::EMAIL
  end

  it 'initializes with username and password' do
    toggl = TogglV8::API.new(Testing::EMAIL, Testing::PASSWORD)
    me = toggl.me
    expect(me).to_not be nil
    expect(me['api_token']).to eq Testing::API_TOKEN
    expect(me['email']).to eq Testing::EMAIL
  end

  it 'does not initialize with bogus api_token' do
    toggl = TogglV8::API.new('4880nqor1orr9n241sn08070q33oq49s')
    expect { toggl.me }.to raise_error(RuntimeError, "HTTP Status: 403")
  end

  context '.toggl file' do
    before :each do
      @tmp_home = mktemp_dir
      @original_home = Dir.home
      ENV['HOME'] = @tmp_home
    end

    after :each do
      FileUtils.rm_rf(@tmp_home)
      ENV['HOME'] = @original_home
    end

    it 'initializes with .toggl file' do
      toggl_file = File.join(@tmp_home, '.toggl')
      File.open(toggl_file, 'w') { |file| file.write(Testing::API_TOKEN) }

      toggl = TogglV8::API.new
      me = toggl.me
      expect(me).to_not be nil
      expect(me['api_token']).to eq Testing::API_TOKEN
      expect(me['email']).to eq Testing::EMAIL
    end

    it 'raises error if .toggl file is missing' do
      expect{ toggl = TogglV8::API.new }.to raise_error(RuntimeError)
    end
  end

  context 'handles errors' do
    before :all do
      @toggl = TogglV8::API.new(Testing::API_TOKEN)
    end

    it 'surfaces an HTTP Status Code in case of error' do
      expect(@toggl.conn).to receive(:get).once.and_return(
        MockResponse.new(400, {}, 'body'))
      expect { @toggl.me }.to raise_error(RuntimeError, "HTTP Status: 400")
    end

    it 'retries a request up to 3 times if a 429 is received' do
      expect(@toggl.conn).to receive(:get).exactly(3).times.and_return(
        MockResponse.new(429, {}, 'body'))
      expect { @toggl.me }.to raise_error(RuntimeError, "HTTP Status: 429")
    end

    it 'retries a request after 429' do
      expect(@toggl.conn).to receive(:get).twice.and_return(
        MockResponse.new(429, {}, 'body'),
        MockResponse.new(200, {}, nil))
      expect(@toggl.me).to eq({})   # response is {} in this case because body is nil
    end
  end
end