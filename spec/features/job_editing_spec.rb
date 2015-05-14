#coding: UTF-8
require 'spec_helper'

describe "Editing" do
	before do
		@job = FactoryGirl.create :job, active: true, title: "古い仕事", visa: true
		FactoryGirl.create :captcha
	end

	it "should update title" do
		visit "/jobs/#{@job.id}/edit?token=#{@job.token}"
		page.should have_content "広告編集"
		fill_in "job[title]", with: "新しい仕事"
		click_button "編集する"
		@job.reload
		@job.title.should == "新しい仕事"
		page.should have_content "新しい仕事"
	end

	it "should cancel back to show page" do
		visit "/jobs/#{@job.id}/edit?token=#{@job.token}"
		page.should have_content "広告編集"
		fill_in "job[title]", with: "新しい仕事"
		click_link "キャンセル"
		@job.title.should == "古い仕事"
		page.should have_content "古い仕事"
	end

	it "should update visa filter when visa status is updated" do
		@job.filters.first.a_int.should == 10
		visit "/jobs/#{@job.id}/edit?token=#{@job.token}"
		page.should have_content "広告編集"
		select "無", from: "job[visa]"
		click_button "編集する"
		@job.reload
		@job.visa.should == false
		@job.filters.first.a_int.should == 30
	end

end
