require 'spec_helper'

describe Character do
  before do
    @character = Character.new(code: '4E00'.to_i(16),
                               structure: '独',
                               zongbihua: 1)
  end

  subject { @character }

  it { should respond_to(:code) }
  it { should respond_to(:structure) }
  it { should respond_to(:bushou) }
  it { should respond_to(:bihua) }
  it { should respond_to(:zongbihua) }
  it { should respond_to(:unichr) }
end
