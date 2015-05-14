require 'spec_helper'

describe Submission do

	before do
		@job = FactoryGirl.create :job
		@filter_1 = FactoryGirl.create :filter, form_type: "Job", form_id: @job.id, a_type: "Integer", a_int: 5
		@filter_2 = FactoryGirl.create :filter, form_type: "Job", form_id: @job.id, a_type: "Integer", a_int: 3
		@filter_3 = FactoryGirl.create :filter, form_type: "Job", form_id: @job.id, a_type: "String", a_string: "[4,3,8]"
		Submission.any_instance.stub(:content_type).and_return(true)
		@submission = FactoryGirl.create :submission
	end

	subject { @submission }
	it { should respond_to :id }
	it { should respond_to :content }
	it { should respond_to :from_email }
	it { should respond_to :job_id }
	it { should respond_to :name }
	it { should respond_to :subject }

	describe :passed_filter? do
		it "pass if greater than Job filter" do
			submission = FactoryGirl.create :submission
			answer_1   = FactoryGirl.create :filter, form_type: "Submission",
			                                         form_id: submission.id,
			                                         a_type: "Integer",
			                                         a_int: 6,
			                                         parent_id: @filter_1.id
			answer_2     = FactoryGirl.create :filter, form_type: "Submission",
			                                         form_id: submission.id,
			                                         a_type: "Integer",
			                                         a_int: 3,
			                                         parent_id: @filter_2.id
			answer_3     = FactoryGirl.create :filter, form_type: "Submission",
			                                         form_id: submission.id,
			                                         a_type: "String",
			                                         a_int: 4,
			                                         parent_id: @filter_3.id
			submission.should be_valid
			submission.passed_filter?.should == true
		end

		it "not pass filter if greater than Job filter" do
			submission = FactoryGirl.create :submission
			answer_1   = FactoryGirl.create :filter, form_type: "Submission",
			                                         form_id: submission.id,
			                                         a_type: "Integer",
			                                         a_int: 4,
			                                         parent_id: @filter_1.id
			answer_2     = FactoryGirl.create :filter, form_type: "Submission",
			                                         form_id: submission.id,
			                                         a_type: "Integer",
			                                         a_int: 3,
			                                         parent_id: @filter_2.id
			answer_3     = FactoryGirl.create :filter, form_type: "Submission",
			                                         form_id: submission.id,
			                                         a_type: "String",
			                                         a_string: [4, 3, 8].to_json,
			                                         parent_id: @filter_3.id
			submission.should be_valid
			submission.passed_filter?.should == false
		end


	end

end
# == Schema Information
#
# Table name: submissions
#
#  id                  :integer         not null, primary key
#  job_id              :integer
#  from_email          :string(255)
#  name                :string(255)
#  subject             :string(255)
#  content             :text
#  resume_file_name    :string(255)
#  resume_content_type :string(255)
#  resume_file_size    :integer
#  resume_updated_at   :datetime
#  status              :string(255)
#

