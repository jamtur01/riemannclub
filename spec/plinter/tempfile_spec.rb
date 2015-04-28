require File.dirname(__FILE__) + '/../spec_helper'
require 'riemannclub/tempfile'

describe RiemannClub::Tempfile do

      before do
       @file = mock('file')
       @tempfile = RiemannClub::Tempfile.new(@file)
     end

      it "should have a create method" do
        @tempfile.should respond_to :create
     end

     it "should create a new instance" do
       RiemannClub::Tempfile.should respond_to :new
     end

end
