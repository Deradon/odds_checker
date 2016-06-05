module WebmockStubs
  def self.included(base)
    base.extend(ClassMethods)
    base.setup_stubbed_requests
  end

  def html_response_for(name)
    {
      status: 200,
      body: File.read("spec/fixtures/#{name}.html")
    }
  end

  module ClassMethods
    def setup_stubbed_requests
      before do
        stub_request(:get, "http://www.oddschecker.com/football/euro-2016/france-v-romania/correct-score/")
          .to_return(html_response_for("correct-score"))
      end
    end
  end
end
