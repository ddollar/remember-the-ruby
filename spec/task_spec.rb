it "should be findable by id" do
  if task = @api.tasks.first
    id = task.id
    id.should_not be_nil
    @api.tasks.find(id.to_s).should == task
    @api.tasks.find(id.to_i).should == task
  end
end
