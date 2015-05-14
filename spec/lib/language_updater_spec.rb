require 'spec_helper'
require 'language_updater'

describe LanguageUpdater do

	before do
		@job           = FactoryGirl.create :job
		@job_filter_e  = FactoryGirl.create :filter, form_type: "Job", form_id: @job.id, q_text: "英語の語学レベル", select_options: '[["日常会話程度",1],["ビジネス",2],["ネイティブ",3]]', a_int: 2
		@job_filter_j  = FactoryGirl.create :filter, form_type: "Job", form_id: @job.id, q_text: "日本語の語学レベル", select_options: '[["日常会話程度",1],["ビジネス",2],["ネイティブ",3]]', a_int: 3
		@job_filter_o  = FactoryGirl.create :filter, form_type: "Job", form_id: @job.id, q_text: "other", select_options: '[["apple",1],["banana",2],["cat",3]]', a_int: 1
		@sub1          = FactoryGirl.create :submission, job_id: @job.id
		@sub1_filter_e = FactoryGirl.create :filter, form_type: "Submission", form_id: @sub1.id, q_text: "英語の語学レベル", a_int: 1
		@sub1_filter_j = FactoryGirl.create :filter, form_type: "Submission", form_id: @sub1.id, q_text: "日本語の語学レベル", a_int: 2
		@sub2          = FactoryGirl.create :submission, job_id: @job.id
		@sub2_filter_e = FactoryGirl.create :filter, form_type: "Submission", form_id: @sub2.id, q_text: "英語の語学レベル", a_int: 2
		@sub2_filter_j = FactoryGirl.create :filter, form_type: "Submission", form_id: @sub2.id, q_text: "日本語の語学レベル", a_int: 3
		@sub3          = FactoryGirl.create :submission, job_id: @job.id
		@sub3_filter_e = FactoryGirl.create :filter, form_type: "Submission", form_id: @sub3.id, q_text: "英語の語学レベル", a_int: 3
		@sub3_filter_j = FactoryGirl.create :filter, form_type: "Submission", form_id: @sub3.id, q_text: "日本語の語学レベル", a_int: 3
	end

	it "should update all of the filters with the new select options" do
		LanguageUpdater.q_text_perform "英語の語学レベル"
		@job_filter_e.reload
		@job_filter_j.reload
		@job_filter_o.reload
		@sub1_filter_e.reload
		@sub1_filter_j.reload
		@sub2_filter_e.reload
		@sub2_filter_j.reload
		@sub3_filter_e.reload
		@sub3_filter_j.reload
		@job_filter_e.select_options.should == [["日常会話",1],["日常会話上級",2],["ビジネス",3],["ネイティブ",4]]
		@job_filter_j.select_options.should == [["日常会話程度",1],["ビジネス",2],["ネイティブ",3]]
		@job_filter_o.select_options.should == [["apple",1],["banana",2],["cat",3]]
		@sub1_filter_e.a_int.should == 1
		@sub1_filter_j.a_int.should == 2
		@sub2_filter_e.a_int.should == 3
		@sub2_filter_j.a_int.should == 3
		@sub3_filter_e.a_int.should == 4
		@sub3_filter_j.a_int.should == 3

		LanguageUpdater.q_text_perform "日本語の語学レベル"
		@job_filter_e.reload
		@job_filter_j.reload
		@job_filter_o.reload
		@sub1_filter_e.reload
		@sub1_filter_j.reload
		@sub2_filter_e.reload
		@sub2_filter_j.reload
		@sub3_filter_e.reload
		@sub3_filter_j.reload
		@job_filter_e.select_options.should == [["日常会話",1],["日常会話上級",2],["ビジネス",3],["ネイティブ",4]]
		@job_filter_j.select_options.should == [["日常会話",1],["日常会話上級",2],["ビジネス",3],["ネイティブ",4]]
		@job_filter_o.select_options.should == [["apple",1],["banana",2],["cat",3]]
		@sub1_filter_e.a_int.should == 1
		@sub1_filter_j.a_int.should == 3
		@sub2_filter_e.a_int.should == 3
		@sub2_filter_j.a_int.should == 4
		@sub3_filter_e.a_int.should == 4
		@sub3_filter_j.a_int.should == 4
	end

	it "should update all filters when perform is called" do
		LanguageUpdater.perform
		@job_filter_e.reload
		@job_filter_j.reload
		@job_filter_o.reload
		@sub1_filter_e.reload
		@sub1_filter_j.reload
		@sub2_filter_e.reload
		@sub2_filter_j.reload
		@sub3_filter_e.reload
		@sub3_filter_j.reload
		@job_filter_e.select_options.should == [["日常会話",1],["日常会話上級",2],["ビジネス",3],["ネイティブ",4]]
		@job_filter_j.select_options.should == [["日常会話",1],["日常会話上級",2],["ビジネス",3],["ネイティブ",4]]
		@job_filter_o.select_options.should == [["apple",1],["banana",2],["cat",3]]
		@sub1_filter_e.a_int.should == 1
		@sub1_filter_j.a_int.should == 3
		@sub2_filter_e.a_int.should == 3
		@sub2_filter_j.a_int.should == 4
		@sub3_filter_e.a_int.should == 4
		@sub3_filter_j.a_int.should == 4
	end

end
