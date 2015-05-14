#coding: UTF-8
require 'spec_helper'

describe "Index Page" do
	before do
		visit root_path
		FactoryGirl.create :captcha
	end

	it "should have correct root page" do
		page_should_have_root_page_content
	end

	it "should link to the promo popup form" do
		click_link "今すぐ求人広告掲載"
		page.should have_content "広告を掲載される企業様へ"
		page.should have_button "キャンセル"
		page.should have_link "プロモーションコード申請"
		page.should have_link "広告を作成する"
	end

	it "should link to the promo popup form" do
		click_link "今すぐ求人広告掲載"
		click_link "広告を作成する"
		page_should_have_job_form_content
	end
end

describe "Job Form" do
	before do
		visit new_job_path
		@today = Time.now.utc.to_date
		FactoryGirl.create :captcha
	end

	it "should have correct form" do
		page_should_have_job_form_content
	end

	it "should submit correctly" do
		fill_in "job[title]", with: "テスト　スペシャリスト"
		fill_in "job[company]", with: "世界最優良企業"
    fill_in "job[description]", with: "とても良い仕事です！"
    fill_in "job[email]", with: "ana@email.com"
    click_button "ステップ２に進む"
    page_should_have_review_page_content
    job = Job.last
    job.title.should       == "テスト　スペシャリスト"
    job.company.should     == "世界最優良企業"
    job.description.should == "とても良い仕事です！"
    job.email.should       == "ana@email.com"
		page.should have_css("h1", text: "テスト スペシャリスト")
		page.should have_css("h4", text: "投稿日：#{ @today.strftime("%_m月%e日")}")
		page.should have_css("h3", text: "会社名：世界最優良企業")
		page.should have_css("h3", text: "勤務地：マンハッタン")
		page.should have_link "このポジションに応募する"
	end

	it "should redirect incomplete form" do
		fill_in "job[company]", with: "世界最優良企業"
    fill_in "job[description]", with: "とても良い仕事です！"
    fill_in "job[email]", with: "ana@email.com"
    click_button "ステップ２に進む"
    page_should_have_job_form_content
		page.should have_content "以下の1件のエラーのため、作成できませんでした:"
		page.should have_content "タイトル を読み取ることができませんでした。確認して再度入力してください。"
	end

end

describe "Job Review Page" do
	before do
		@admin = FactoryGirl.create :admin
		@promo = FactoryGirl.create :promo, code: "promopromo", admin_id: @admin.id
		FactoryGirl.create :captcha
		visit new_job_path
		fill_in "job[title]", with: "テスト　スペシャリスト"
		fill_in "job[company]", with: "世界最優良企業"
    fill_in "job[description]", with: "とても良い仕事です！"
    fill_in "job[email]", with: "ana@email.com"
    click_button "ステップ２に進む"
	end

	it "should reject entry if promo doesn't fit" do
		fill_in "redemption[promo_code]", with: "bob"
		click_button "ステップ３に進む"
		page_should_have_review_page_content
		page.should have_content "入力されたプロモーションコード「bob」は利用できませんでした。プロモーションコードに間違いがないかご確認ください。"
	end

	it "should accept correct code" do
		fill_in "redemption[promo_code]", with: "promopromo"
		click_button "ステップ３に進む"
		page_should_have_new_order_content
		page.should_not have_content "クレジットカード"
		redemption = Redemption.last
		redemption.promo.should == @promo
		redemption.amount.should == 0
	end

	it "should return to edit page" do
		click_link "内容を修正する"
		page_should_have_job_form_content
	end

	it "should allow editing" do
		click_link "内容を修正する"
		fill_in "job[company]", with: "宇宙最優良企業"
    click_button "この内容でOK！"
    page_should_have_review_page_content
    Job.last.company.should == "宇宙最優良企業"
	end

	it "should redirect bad edit with errors" do
		click_link "内容を修正する"
		fill_in "job[title]", with: ""
    click_button "この内容でOK！"
    page_should_have_job_form_content
		page.should have_content "以下の1件のエラーのため、作成できませんでした:"
		page.should have_content "タイトル を読み取ることができませんでした。確認して再度入力してください。"
	end

	it "should cancel out of edit" do
		click_link "内容を修正する"
		fill_in "job[company]", with: "宇宙最優良企業"
    click_link "編集せずにステップ２に戻る"
    page_should_have_review_page_content
    Job.last.company.should == "世界最優良企業"
	end
end

describe "New Order Page" do
	before do
		@admin = FactoryGirl.create :admin
		@promo = FactoryGirl.create :promo, code: "promopromo", admin_id: @admin.id
		FactoryGirl.create :captcha
		visit new_job_path
		fill_in "job[title]", with: "テスト　スペシャリスト"
		fill_in "job[company]", with: "世界最優良企業"
    fill_in "job[description]", with: "とても良い仕事です！"
    fill_in "job[email]", with: "ana@email.com"
    click_button "ステップ２に進む"
		fill_in "redemption[promo_code]", with: "promopromo"
		click_button "ステップ３に進む"
	end

	it "should return new orders page" do
		page.should have_content "下記の内容でご注文を承ります。内容をご確認ください。"
	end

	it "should create a new order, and update job status" do
		job = Job.last
		job.active.should == nil
		Job.any_instance.stub(:post_to_twitter).and_return(true)
		Job.any_instance.stub(:post_to_facebook).and_return(true)
		click_button "求人広告を掲載する"
		job.reload
		job.active.should == true
		Order.last.status.should == "purchased"
	end

	it "should send email if box is checked" do
		OrdersMailer.stub_chain(:new_order, :deliver).and_return(true)
		OrdersMailer.should_receive(:new_order)
		Job.any_instance.stub(:post_to_twitter).and_return(true)
		Job.any_instance.stub(:post_to_facebook).and_return(true)
		find(:css, "#order_email").set(true)
		find(:css, "#sns_posts").set(false)
		click_button "求人広告を掲載する"
	end

	it "should post sns if box is checked" do
		OrdersMailer.stub_chain(:new_order, :deliver).and_return(true)
		Job.any_instance.should_receive(:post_to_sns).and_return(true)
		find(:css, "#order_email").set(false)
		find(:css, "#sns_posts").set(true)
		click_button "求人広告を掲載する"
	end

	it "should not send email if box is not checked" do
		OrdersMailer.stub_chain(:new_order, :deliver).and_return(true)
		OrdersMailer.should_not_receive(:new_order)
		Job.any_instance.stub(:post_to_twitter).and_return(true)
		Job.any_instance.stub(:post_to_facebook).and_return(true)
		find(:css, "#order_email").set(false)
		click_button "求人広告を掲載する"
	end
end

describe "Order should accept case-insensitive code" do
	before do
		@admin = FactoryGirl.create :admin
		@promo = FactoryGirl.create :promo, code: "promopromo", admin_id: @admin.id
		FactoryGirl.create :captcha
		visit new_job_path
		fill_in "job[title]", with: "テスト　スペシャリスト"
		fill_in "job[company]", with: "世界最優良企業"
    fill_in "job[description]", with: "とても良い仕事です！"
    fill_in "job[email]", with: "ana@email.com"
    click_button "ステップ２に進む"
		fill_in "redemption[promo_code]", with: "Promopromo"
		click_button "ステップ３に進む"
	end

	it "should return new orders page" do
		page.should have_content "下記の内容でご注文を承ります。内容をご確認ください。"
	end
end

def page_should_have_header_content
  page.should have_content "職Getは企業の採用条件に合った人材を職Getフィルター* により自動的に選出し、求職者と企業様を瞬時にコネクトする全く新しいタイプの求人広告サービスです。"
end

def page_should_have_root_page_content
	page_should_have_header_content
  page.should have_link "今すぐ求人広告掲載"
  page.should have_link "企業の皆様へ"
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
