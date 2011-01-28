def aliases(methods)
  methods.each do |original, new|
    it "#{original} is available as #{new}" do
      subject.send(original).should eql(subject.send(new))
    end
  end
end