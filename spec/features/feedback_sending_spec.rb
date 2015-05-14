#coding: UTF-8
require 'spec_helper'

describe "Feedback Form" do
	it "should have correct form" do
		visit root_path
		first(".feedback").click
		page.should have_selector('h1', "お問い合わせフォーム")
	end

	it "should go to form from promo popup" do
		visit root_path
		click_link "今すぐ求人広告掲載"
		click_link "プロモーションコード申請"
		page.should have_selector('h1', "お問い合わせフォーム")
	end

	it "should submit correctly" do
		visit contact_path
		fill_in "feedback[name]", with: "ボブ"
    fill_in "feedback[email]", with: "bob@email.com"
    select "求人広告掲載について", from: "feedback[subject]"
    fill_in "feedback[content]", with: "とても良いサイトですね！"

    FeedbacksMailer.stub_chain(:new_feedback, :deliver).and_return(true)
    click_button "メール送信"
    page.should have_content "メールが送信されました。"
	end

	it "should submit correctly" do
		visit contact_path
		fill_in "feedback[name]", with: "ボブ"
    fill_in "feedback[email]", with: "bobemail.com"
    select "求人広告掲載について", from: "feedback[subject]"
    fill_in "feedback[content]", with: "とても良いサイトですね！"

    FeedbacksMailer.stub_chain(:new_feedback, :deliver).and_return(true)
    click_button "メール送信"
		page.should have_selector('h1', "お問い合わせフォーム")
    page.should_not have_content "メールが送信されました。"
    page.should have_content "Eメール を読み取ることができませんでした。確認して再度入力してください。"
	end

end
