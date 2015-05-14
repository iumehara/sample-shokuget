#coding: UTF-8
require 'spec_helper'

describe "Index Page" do
	before do
		@job = FactoryGirl.create :job
		@filter_1 = FactoryGirl.create(:filter, select_options: (0..10).to_a.to_json,
		                                        form_type: "Job",
		                                        form_id: @job.id,
		                                        a_type: "Integer",
		                                        a_int: 5)
		@filter_2 = FactoryGirl.create(:filter, select_options: LANGUAGE_LEVEL_OPTIONS.to_json,
		                                        form_type: "Job",
		                                        form_id: @job.id,
		                                        a_type: "Integer",
		                                        a_int: 2)
		@filter_3 = FactoryGirl.create(:filter, select_options: MAJORS_OPTIONS.to_json,
		                                        form_type: "Job",
		                                        form_id: @job.id,
		                                        a_type: "String",
		                                        a_string: [5, 6].to_json)
		FactoryGirl.create :captcha
		@default_filters_count = 3
		visit job_path(@job.id)
	end

	it "should create submission with Engineering=5" do
		click_link "このポジションに応募する"
		fill_in "submission[name]", with: "ももたろう　たけし"
		fill_in "submission[from_email]", with: "momo@taro.com"
		fill_in "submission[content]", with: "この仕事にとても興味があります。よろしくお願いします！"
		select "可能", from: "filter[2][a_int]"
		select "5", from: "filter[#{@default_filters_count + 0}][a_int]"
		select "ビジネス", from: "filter[#{@default_filters_count + 1}][a_int]"
		select "エンジニアリング/技術系", from: "filter[#{@default_filters_count + 2}][a_int]"
		SubmissionsMailer.stub_chain(:new_submission, :deliver).and_return(true)
		file_path = Rails.root + 'spec/support/attachments/resume.docx'
		attach_file 'submission[resume]', file_path
		fill_in "submission[captcha_name]", with: "ashitahare"
		click_button "応募する"
		Submission.count.should == 1
		submission = Submission.first
		submission.name.should       == "ももたろう　たけし"
		submission.from_email.should == "momo@taro.com"
		submission.content.should    == "この仕事にとても興味があります。よろしくお願いします！"
		submission.status.should     == "passed"
		page.should have_content "応募が完了しました。"
	end

	it "should create submission with Math=6" do
		click_link "このポジションに応募する"
		fill_in "submission[name]", with: "ももたろう　たけし"
		fill_in "submission[from_email]", with: "momo@taro.com"
		fill_in "submission[content]", with: "この仕事にとても興味があります。よろしくお願いします！"
		select "5", from: "filter[#{@default_filters_count + 0}][a_int]"
		select "ビジネス", from: "filter[#{@default_filters_count + 1}][a_int]"
		select "数学/物理学/科学系", from: "filter[#{@default_filters_count + 2}][a_int]"
		SubmissionsMailer.stub_chain(:new_submission, :deliver).and_return(true)
		file_path = Rails.root + 'spec/support/attachments/resume.docx'
		attach_file 'submission[resume]', file_path
		fill_in "submission[captcha_name]", with: "ashitahare"
		click_button "応募する"
		Submission.count.should == 1
		submission = Submission.first
		submission.name.should       == "ももたろう　たけし"
		submission.from_email.should == "momo@taro.com"
		submission.content.should    == "この仕事にとても興味があります。よろしくお願いします！"
		submission.status.should     == "passed"
		page.should have_content "応募が完了しました。"
	end

	it "should reject submission with no visa" do
		click_link "このポジションに応募する"
		fill_in "submission[name]", with: "ももたろう　たけし"
		fill_in "submission[from_email]", with: "momo@taro.com"
		fill_in "submission[content]", with: "この仕事にとても興味があります。よろしくお願いします！"
		select "No Visa", from: "filter[0][a_int]"
		select "5", from: "filter[#{@default_filters_count + 0}][a_int]"
		select "ビジネス", from: "filter[#{@default_filters_count + 1}][a_int]"
		select "数学/物理学/科学系", from: "filter[#{@default_filters_count + 2}][a_int]"
		SubmissionsMailer.should_not_receive(:deliver)
		file_path = Rails.root + 'spec/support/attachments/resume.docx'
		attach_file 'submission[resume]', file_path
		fill_in "submission[captcha_name]", with: "ashitahare"
		click_button "応募する"
		Submission.count.should == 1
		submission = Submission.first
		submission.name.should       == "ももたろう　たけし"
		submission.from_email.should == "momo@taro.com"
		submission.content.should    == "この仕事にとても興味があります。よろしくお願いします！"
		submission.status.should_not == "passed"
		page.should have_content "応募が完了しました。"
	end

	it "should reject submission with Design=2" do
		click_link "このポジションに応募する"
		fill_in "submission[name]", with: "ももたろう　たけし"
		fill_in "submission[from_email]", with: "momo@taro.com"
		fill_in "submission[content]", with: "この仕事にとても興味があります。よろしくお願いします！"
		select "5", from: "filter[#{@default_filters_count + 0}][a_int]"
		select "ビジネス", from: "filter[#{@default_filters_count + 1}][a_int]"
		select "建築/デザイン系", from: "filter[#{@default_filters_count + 2}][a_int]"
		SubmissionsMailer.should_not_receive(:deliver)
		file_path = Rails.root + 'spec/support/attachments/resume.docx'
		attach_file 'submission[resume]', file_path
		fill_in "submission[captcha_name]", with: "ashitahare"
		click_button "応募する"
		Submission.count.should == 1
		submission = Submission.first
		submission.name.should       == "ももたろう　たけし"
		submission.from_email.should == "momo@taro.com"
		submission.content.should    == "この仕事にとても興味があります。よろしくお願いします！"
		submission.status.should_not == "passed"
		page.should have_content "応募が完了しました。"
	end

	it "should reject incomplete submissions" do
		click_link "このポジションに応募する"
		select "5", from: "filter[#{@default_filters_count + 0}][a_int]"
		select "ビジネス", from: "filter[#{@default_filters_count + 1}][a_int]"
		select "エンジニアリング/技術系", from: "filter[#{@default_filters_count + 2}][a_int]"
		SubmissionsMailer.stub_chain(:new_submission, :deliver).and_return(true)
		click_button "応募する"
		Submission.count.should == 0
		page.should_not have_content "応募が完了しました。"
		page.should have_content "お名前 を読み取ることができませんでした。確認して再度入力してください。"
		page.should have_content "Eメール を読み取ることができませんでした。確認して再度入力してください。"
		page.should have_content "志望動機 を読み取ることができませんでした。確認して再度入力してください。"
	end
end

describe "Job with no filter" do
	before do
		@job = FactoryGirl.create :job
		FactoryGirl.create :captcha
		visit job_path(@job.id)
	end
	it "should accept submissions" do
		click_link "このポジションに応募する"
		fill_in "submission[name]", with: "ももたろう　たけし"
		fill_in "submission[from_email]", with: "momo@taro.com"
		fill_in "submission[content]", with: "この仕事にとても興味があります。よろしくお願いします！"
		SubmissionsMailer.should_not_receive(:deliver)
		fill_in "submission[captcha_name]", with: "ashitahare"
		click_button "応募する"
		Submission.count.should == 1
		submission = Submission.first
		submission.name.should       == "ももたろう　たけし"
		submission.from_email.should == "momo@taro.com"
		submission.content.should    == "この仕事にとても興味があります。よろしくお願いします！"
		page.should have_content "応募が完了しました。"
		submission.status.should     == "passed"
	end
end

def page_should_have_header_content
  page.should have_content "職Getは企業の採用条件に合った人材を職Getフィルター* により自動的に選出し、求職者と企業様を瞬時にコネクトする全く新しいタイプの求人広告サービスです。"
end

def page_should_have_root_page_content
	page_should_have_header_content
  page.should have_link "今すぐ求人広告掲載"
  page_should_have_footer_content
end

def page_should_have_job_form_content
  page.should have_content "広告作成"
  page_should_have_footer_content
end

def page_should_have_review_page_content
  page.should have_content "広告内容の確認"
  page.should have_link "このポジションに応募する"
	page.should have_content "プロモーション期間につき現在プロモーションコード($100 Off)を発行しております。お持ちでない方は、下記赤い「プロモーションコード申請」ボタンにてご申請ください。"
  page_should_have_footer_content
end

def page_should_have_new_order_content
	page.should have_content "下記の内容でご注文を承ります。内容をご確認ください。"
  page_should_have_footer_content
end

def page_should_have_footer_content
	within('footer') do
		page.should have_content "2014 ShokuGet New York"
	end
end

def page_should_have_job_detail_content job
	page.should have_content job.title
	page.should have_content job.description
	page.should have_link job.url
end
