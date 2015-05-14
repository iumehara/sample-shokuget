require 'spec_helper'

describe SubmissionsController do

	before do
		@job = FactoryGirl.create :job
		@filter_1 = FactoryGirl.create :filter, form_type: "Job", form_id: @job.id, a_type: "Integer", a_int: 5
		@filter_2 = FactoryGirl.create :filter, form_type: "Job", form_id: @job.id, a_type: "Integer", a_int: 3
		@filter_3 = FactoryGirl.create :filter, form_type: "Job", form_id: @job.id, a_type: "String", a_string: "[4,3,8]"
		Submission.any_instance.stub(:content_type).and_return(true)
		@submission = FactoryGirl.create :submission
	end

	describe :passed_filter? do
		it "pass if greater than Job filter" do
			SubmissionsMailer.should_receive(:new_submission).and_return(SubmissionsMailer)
			SubmissionsMailer.any_instance.should_receive(:deliver).and_return(true)
			submission = {
				content: "I want the job!",
				captcha_key: "match",
				captcha_name: "match",
				name: "bob",
				from_email: "bob@email.com"
			}
			filter = {
				1 => {
					"parent_id" => @filter_1.id,
					"q_text"    => "hello",
					"a_type"    => "Integer",
					"a_int"     => 6,
				},
				2 => {
					"parent_id" => @filter_2.id,
					"q_text"    => "hello",
					"a_type"    => "Integer",
					"a_int"     => 3,
				},
				3 => {
					"parent_id" => @filter_3.id,
					"q_text"    => "hello",
					"a_type"    => "String",
					"a_int"     => 4,
				}
			}
			post :create, id: @job.id, submission: submission, filter: filter
		end
	end

end