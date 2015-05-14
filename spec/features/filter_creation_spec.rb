#coding: UTF-8
require 'spec_helper'

describe "Job Form" do
	before do
		visit new_job_path
		FactoryGirl.create :captcha
		@default_filters_count = 3
	end

	context "Filter Creation" do

		it "should set visa filter correctly" do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(false)
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(false)
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(false)
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content

	    Filter.count.should == @default_filters_count
			filter = Filter.first
			filter.section.should        == "visa"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "現在のビザステータス"
	    filter.select_options.should == [["Citizen", 31],["Permanent Resident", 30],["H",22],["E", 21],["OPT", 20],["Student", 11],["Other (E, O, J, M, etc)", 10],["No Visa", 0]]
			filter.a_int.should          == 10

			page.should have_link "このポジションに応募する"
			page.should have_content "現在のビザステータス"
			select "Citizen", from: "filter[0][a_int]"
			select "Permanent Resident", from: "filter[0][a_int]"
			select "H", from: "filter[0][a_int]"
			select "E", from: "filter[0][a_int]"
			select "OPT", from: "filter[0][a_int]"
			select "Student", from: "filter[0][a_int]"
			select "Other (E, O, J, M, etc)", from: "filter[0][a_int]"
			select "No Visa", from: "filter[0][a_int]"
		end

		it "should set work 1 correctly" do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(true)
	    select "5", from: "filter[0][a_int]"
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(false)
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(false)
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content

	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "work"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "募集する職種と関連した仕事での経験年数"
	    filter.select_options.should == [["0年", 0], ["1年", 1], ["2年", 2], ["3年", 3], ["4年", 4], ["5年", 5], ["6年", 6], ["7年", 7], ["8年", 8], ["9年", 9], ["10年", 10], ["10年以上", 11]]
			filter.a_int.should          == 5

			page.should have_link "このポジションに応募する"
			page.should have_content "募集する職種と関連した仕事での経験年数"
			select "1年", from: "filter[#{@default_filters_count}][a_int]"
			select "2年", from: "filter[#{@default_filters_count}][a_int]"
			select "3年", from: "filter[#{@default_filters_count}][a_int]"
			select "4年", from: "filter[#{@default_filters_count}][a_int]"
			select "5年", from: "filter[#{@default_filters_count}][a_int]"
			select "6年", from: "filter[#{@default_filters_count}][a_int]"
			select "7年", from: "filter[#{@default_filters_count}][a_int]"
			select "8年", from: "filter[#{@default_filters_count}][a_int]"
			select "9年", from: "filter[#{@default_filters_count}][a_int]"
			select "10年", from: "filter[#{@default_filters_count}][a_int]"
			select "10年以上", from: "filter[#{@default_filters_count}][a_int]"
		end

		it "should set work 2 correctly" do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(false)
			find(:css, "#filter_1_selected").set(true)
	    select "5", from: "filter[1][a_int]"
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(false)
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(false)
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content

	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "work"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "フルタイムの仕事での経験年数"
	    filter.select_options.should == [["0年", 0], ["1年", 1], ["2年", 2], ["3年", 3], ["4年", 4], ["5年", 5], ["6年", 6], ["7年", 7], ["8年", 8], ["9年", 9], ["10年", 10], ["10年以上", 11]]
			filter.a_int.should          == 5

			page.should have_link "このポジションに応募する"
			page.should have_content "フルタイムの仕事での経験年数"
			select "1年", from: "filter[#{@default_filters_count}][a_int]"
			select "2年", from: "filter[#{@default_filters_count}][a_int]"
			select "3年", from: "filter[#{@default_filters_count}][a_int]"
			select "4年", from: "filter[#{@default_filters_count}][a_int]"
			select "5年", from: "filter[#{@default_filters_count}][a_int]"
			select "6年", from: "filter[#{@default_filters_count}][a_int]"
			select "7年", from: "filter[#{@default_filters_count}][a_int]"
			select "8年", from: "filter[#{@default_filters_count}][a_int]"
			select "9年", from: "filter[#{@default_filters_count}][a_int]"
			select "10年", from: "filter[#{@default_filters_count}][a_int]"
			select "10年以上", from: "filter[#{@default_filters_count}][a_int]"
		end

		it "should set work 3 correctly" do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(false)
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(true)
	    select "5", from: "filter[2][a_int]"
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(false)
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(false)
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content

	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "work"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "英語を使った仕事の職務経験年数"
	    filter.select_options.should == [["0年", 0], ["1年", 1], ["2年", 2], ["3年", 3], ["4年", 4], ["5年", 5], ["6年", 6], ["7年", 7], ["8年", 8], ["9年", 9], ["10年", 10], ["10年以上", 11]]
			filter.a_int.should          == 5

			page.should have_link "このポジションに応募する"
			page.should have_content "英語を使った仕事の職務経験年数"
			select "1年", from: "filter[#{@default_filters_count}][a_int]"
			select "2年", from: "filter[#{@default_filters_count}][a_int]"
			select "3年", from: "filter[#{@default_filters_count}][a_int]"
			select "4年", from: "filter[#{@default_filters_count}][a_int]"
			select "5年", from: "filter[#{@default_filters_count}][a_int]"
			select "6年", from: "filter[#{@default_filters_count}][a_int]"
			select "7年", from: "filter[#{@default_filters_count}][a_int]"
			select "8年", from: "filter[#{@default_filters_count}][a_int]"
			select "9年", from: "filter[#{@default_filters_count}][a_int]"
			select "10年", from: "filter[#{@default_filters_count}][a_int]"
			select "10年以上", from: "filter[#{@default_filters_count}][a_int]"
		end

		it "should set lang 1 correctly" do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(false)
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(true)
	    select "ビジネス", from: "filter[3][a_int]"
			find(:css, "#filter_4_selected").set(false)
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(false)
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content

	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "language"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "英語の語学レベル"
	    filter.select_options.should == [["日常会話", 1], ["日常会話上級", 2], ["ビジネス", 3], ["ネイティブ", 4]]
			filter.a_int.should          == 3

			page.should have_link "このポジションに応募する"
			page.should have_content "英語の語学レベル"
			select "日常会話", from: "filter[#{@default_filters_count}][a_int]"
			select "日常会話上級", from: "filter[#{@default_filters_count}][a_int]"
			select "ビジネス", from: "filter[#{@default_filters_count}][a_int]"
			select "ネイティブ", from: "filter[#{@default_filters_count}][a_int]"
		end

		it "should set lang 2 correctly" do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(false)
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(true)
	    select "220 ~ 465点", from: "filter[4][a_int]"
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(false)
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content

	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "language"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "TOEICの成績"
	    filter.select_options.should == [["不問", 0], ["220点未満", 1], ["220 ~ 465点", 2], ["470 ~ 725点", 3], ["730 ~ 850点", 4], ["855点以上", 5]]
			filter.a_int.should          == 2

			page.should have_link "このポジションに応募する"
			page.should have_content "TOEICの成績"
			select "不問", from: "filter[#{@default_filters_count}][a_int]"
			select "220点未満", from: "filter[#{@default_filters_count}][a_int]"
			select "220 ~ 465点", from: "filter[#{@default_filters_count}][a_int]"
			select "470 ~ 725点", from: "filter[#{@default_filters_count}][a_int]"
			select "730 ~ 850点", from: "filter[#{@default_filters_count}][a_int]"
			select "855点以上", from: "filter[#{@default_filters_count}][a_int]"
		end

		it "should set lang 3 correctly" do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(false)
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(false)
			find(:css, "#filter_5_selected").set(true)
	    select "80 ~ 89点", from: "filter[5][a_int]"
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(false)
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content

	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "language"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "TOEFLの成績"
	    filter.select_options.should == [["不問", 0], ["80点未満", 1], ["80 ~ 89点", 2], ["90 ~ 99 点", 3], ["100 ~ 110点", 4], ["111点以上", 5]]
			filter.a_int.should          == 2

			page.should have_link "このポジションに応募する"
			page.should have_content "TOEFLの成績"
			select "不問", from: "filter[#{@default_filters_count}][a_int]"
			select "80点未満", from: "filter[#{@default_filters_count}][a_int]"
			select "80 ~ 89点", from: "filter[#{@default_filters_count}][a_int]"
			select "90 ~ 99 点", from: "filter[#{@default_filters_count}][a_int]"
			select "100 ~ 110点", from: "filter[#{@default_filters_count}][a_int]"
			select "111点以上", from: "filter[#{@default_filters_count}][a_int]"
		end

		it "should set lang 4 correctly" do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(false)
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(false)
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(true)
	    select "ネイティブ", from: "filter[6][a_int]"
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(false)
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content

	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "language"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "日本語の語学レベル"
	    filter.select_options.should == [["日常会話", 1], ["日常会話上級", 2], ["ビジネス", 3], ["ネイティブ", 4]]
			filter.a_int.should          == 4

			page.should have_link "このポジションに応募する"
			page.should have_content "日本語の語学レベル"
			select "日常会話", from: "filter[#{@default_filters_count}][a_int]"
			select "日常会話上級", from: "filter[#{@default_filters_count}][a_int]"
			select "ビジネス", from: "filter[#{@default_filters_count}][a_int]"
			select "ネイティブ", from: "filter[#{@default_filters_count}][a_int]"
		end

		it "should set education 1 correctly" do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(false)
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(false)
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(true)
	    select "Master (修士・大学院)", from: "filter[7][a_int]"
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(false)
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content

	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "education"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "学位"
	    filter.select_options.should == [["High School (高校)", 1], ["Associate (短大)", 2], ["Bachelor (学士・大学)", 3], ["Master (修士・大学院)", 4], ["MBA (経営学修士)", 5], ["JD (法務博士)", 5], ["Ph.D. (博士)", 5]]
			filter.a_int.should          == 4

			page.should have_link "このポジションに応募する"
			page.should have_content "学位"
			select "High School (高校)", from: "filter[#{@default_filters_count}][a_int]"
			select "Associate (短大)", from: "filter[#{@default_filters_count}][a_int]"
			select "Bachelor (学士・大学)", from: "filter[#{@default_filters_count}][a_int]"
			select "Master (修士・大学院)", from: "filter[#{@default_filters_count}][a_int]"
			select "MBA (経営学修士)", from: "filter[#{@default_filters_count}][a_int]"
			select "JD (法務博士)", from: "filter[#{@default_filters_count}][a_int]"
			select "Ph.D. (博士)", from: "filter[#{@default_filters_count}][a_int]"
		end

		it "should set education 2 correctly" do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(false)
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(false)
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(true)
	    select "生物/化学/薬学系", from: "filter[8][a_string][]"
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(false)
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content

	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "education"
			filter.a_type.should         == "String"
			filter.q_text.should         == "学部"
	    filter.select_options.should == [["国際/法学系", 1], ["建築/デザイン系", 2], ["ビジネス/経済系", 3], ["生物/化学/薬学系", 4], ["エンジニアリング/技術系", 5], ["数学/物理学/科学系", 6], ["一般教養系", 7], ["その他文系", 8], ["その他理数系", 9]]
			filter.a_string.should       == [4]

			page.should have_link "このポジションに応募する"
			page.should have_content "学部"
			select "国際/法学系", from: "filter[#{@default_filters_count}][a_int]"
			select "建築/デザイン系", from: "filter[#{@default_filters_count}][a_int]"
			select "ビジネス/経済系", from: "filter[#{@default_filters_count}][a_int]"
			select "生物/化学/薬学系", from: "filter[#{@default_filters_count}][a_int]"
			select "エンジニアリング/技術系", from: "filter[#{@default_filters_count}][a_int]"
			select "数学/物理学/科学系", from: "filter[#{@default_filters_count}][a_int]"
			select "一般教養系", from: "filter[#{@default_filters_count}][a_int]"
			select "その他文系", from: "filter[#{@default_filters_count}][a_int]"
			select "その他理数系", from: "filter[#{@default_filters_count}][a_int]"
		end

		it "should set education 3 correctly" do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(false)
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(false)
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(true)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(false)
	    select "top 20%", from: "filter[9][a_int]"
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content

	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "education"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "成績"
	    filter.select_options.should == [["top 80%", 1], ["top 60%", 2], ["top 40%", 3], ["top 20%", 4], ["top 10%", 5]]
			filter.a_int.should          == 4

			page.should have_link "このポジションに応募する"
			page.should have_content "成績"
			select "top 80%", from: "filter[#{@default_filters_count}][a_int]"
			select "top 60%", from: "filter[#{@default_filters_count}][a_int]"
			select "top 40%", from: "filter[#{@default_filters_count}][a_int]"
			select "top 20%", from: "filter[#{@default_filters_count}][a_int]"
			select "top 10%", from: "filter[#{@default_filters_count}][a_int]"
		end

		it "should set software 1 correctly" do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(false)
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(false)
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(true)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(false)
	    select "ワープロとしての基本操作は使える", from: "filter[10][a_int]"
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content

	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "software"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "MSワードの使用経験"
	    filter.select_options.should == [["ワープロとしての基本操作は使える", 1], ["ワープロとしての基本操作に加えて簡単な書式変更の操作はできる。", 2], ["書式の変更や画像の挿入、目次付け、見出し付などの機能も使いこなせる。", 3]]
			filter.a_int.should          == 1

			page.should have_link "このポジションに応募する"
			page.should have_content "ワード"
	    select "ワープロとしての基本操作は使える", from: "filter[#{@default_filters_count}][a_int]"
	    select "ワープロとしての基本操作に加えて簡単な書式変更の操作はできる。", from: "filter[#{@default_filters_count}][a_int]"
	    select "書式の変更や画像の挿入、目次付け、見出し付などの機能も使いこなせる。", from: "filter[#{@default_filters_count}][a_int]"
		end

		it "should set software 2 correctly" do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(false)
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(false)
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(true)
			find(:css, "#filter_12_selected").set(false)
	    select "集計したデータに対して簡単なグラフや計算式を使える", from: "filter[11][a_int]"
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content

	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "software"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "MSエクセルの使用経験"
	    filter.select_options.should == [["基本的なデータの集計はできる", 1], ["集計したデータに対して簡単なグラフや計算式を使える", 2], ["SUMPRODUCTなどの複雑な計算式やマクロやピボットテーブルなども使いこなせる", 3]]
			filter.a_int.should          == 2

			page.should have_link "このポジションに応募する"
			page.should have_content "エクセル"
	    select "基本的なデータの集計はできる", from: "filter[#{@default_filters_count}][a_int]"
	    select "集計したデータに対して簡単なグラフや計算式を使える", from: "filter[#{@default_filters_count}][a_int]"
	    select "SUMPRODUCTなどの複雑な計算式やマクロやピボットテーブルなども使いこなせる", from: "filter[#{@default_filters_count}][a_int]"
		end

		it "should set software 3 correctly" do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(false)
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(false)
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(true)
	    select "スライドマスタを使ったプロフェッショナルなプレゼンテーションを作成できる。", from: "filter[12][a_int]"
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content

	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "software"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "MSパワーポイントの使用経験"
	    filter.select_options.should == [["簡単なスライドを作成したことがある", 1], ["表・グラフや画像の挿入ができる。", 2], ["スライドマスタを使ったプロフェッショナルなプレゼンテーションを作成できる。", 3]]
			filter.a_int.should          == 3

			page.should have_link "このポジションに応募する"
			page.should have_content "パワーポイント"
	    select "簡単なスライドを作成したことがある", from: "filter[#{@default_filters_count}][a_int]"
	    select "表・グラフや画像の挿入ができる。", from: "filter[#{@default_filters_count}][a_int]"
	    select "スライドマスタを使ったプロフェッショナルなプレゼンテーションを作成できる。", from: "filter[#{@default_filters_count}][a_int]"
		end


	end

	context 'filter editing' do
		it "should set update with new filter." do
			fill_in_job_details
			find(:css, "#filter_0_selected").set(true)
	    select "5", from: "filter[0][a_int]"
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(false)
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(false)
	    click_button "ステップ２に進む"
	    page_should_have_review_page_content
	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "work"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "募集する職種と関連した仕事での経験年数"
	    filter.select_options.should == [["0年", 0], ["1年", 1], ["2年", 2], ["3年", 3], ["4年", 4], ["5年", 5], ["6年", 6], ["7年", 7], ["8年", 8], ["9年", 9], ["10年", 10], ["10年以上", 11]]
			filter.a_int.should          == 5

			click_link "内容を修正する"
			find(:css, "#filter_0_selected").set(false)
			find(:css, "#filter_1_selected").set(false)
			find(:css, "#filter_2_selected").set(false)
			find(:css, "#filter_3_selected").set(false)
			find(:css, "#filter_4_selected").set(true)
	    select "220 ~ 465点", from: "filter[4][a_int]"
			find(:css, "#filter_5_selected").set(false)
			find(:css, "#filter_6_selected").set(false)
			find(:css, "#filter_7_selected").set(false)
			find(:css, "#filter_8_selected").set(false)
			find(:css, "#filter_9_selected").set(false)
			find(:css, "#filter_10_selected").set(false)
			find(:css, "#filter_11_selected").set(false)
			find(:css, "#filter_12_selected").set(false)
			click_button "この内容でOK"
	    Filter.count.should == 1 + @default_filters_count
			filter = Filter.all[-1]
			filter.section.should        == "language"
			filter.a_type.should         == "Integer"
			filter.q_text.should         == "TOEICの成績"
	    filter.select_options.should == [["不問", 0], ["220点未満", 1], ["220 ~ 465点", 2], ["470 ~ 725点", 3], ["730 ~ 850点", 4], ["855点以上", 5]]
			filter.a_int.should          == 2
		end
	end
end


def fill_in_job_details
	fill_in "job[title]", with: "テスト　スペシャリスト"
	fill_in "job[company]", with: "世界最優良企業"
  fill_in "job[description]", with: "とても良い仕事です！"
  fill_in "job[email]", with: "ana@email.com"
end

def page_should_have_header_content
  page.should have_content "ニューヨークで、良い人材を見つけよう。"
  page.should have_content "【効果的】応募フィルター機能で条件に合った人材だけを選出"
  page.should have_content "【スピーディー	】約15分で求人広告掲載完了"
  page.should have_content "【低コスト】掲載から人材選出まで$100のみ"
end

def page_should_have_root_page_content
	page_should_have_header_content
  page.should have_link "求人募集の掲載はこちら"
  page_should_have_footer_content
end

def page_should_have_review_page_content
  page.should have_content "広告内容の確認"
  page.should have_link "このポジションに応募する"
	page.should have_content "プロモーション期間につき現在プロモーションコード($100 Off)を発行しております。お持ちでない方は、下記赤い「プロモーションコード申請」ボタンにてご申請ください。"
  page_should_have_footer_content
end

def page_should_have_job_form_content
  page.should have_content "広告作成"
  page_should_have_footer_content
end

def page_should_have_new_order_content
	page.should have_content "下記の内容でご注文を承ります。 内容をご確認ください。"
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
