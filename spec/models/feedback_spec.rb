require 'spec_helper'

describe Feedback do

	before do
		@feedback = Feedback.new(name: "おじさん", email: "ojisan@email.com", subject: "良いサイトだねぇ", content: "これからもガンバってください。")
	end

	subject { @feedback }
	it { should respond_to :content }
	it { should respond_to :email }
	it { should respond_to :name }
	it { should respond_to :subject }
	it { should be_valid }

	describe "validations" do

		it "should require content" do
			feedback = FactoryGirl.build :feedback, content: nil
			feedback.should be_invalid
			feedback.errors.full_messages[0].should == "お問い合わせ内容 を読み取ることができませんでした。確認して再度入力してください。"
		end

		it "should require email" do
			feedback = FactoryGirl.build :feedback, email: nil
			feedback.should be_invalid
			feedback.errors.full_messages[0].should == "Eメール を読み取ることができませんでした。確認して再度入力してください。"
		end

		it "should require name" do
			feedback = FactoryGirl.build :feedback, name: nil
			feedback.should be_invalid
			feedback.errors.full_messages[0].should == "お名前 を読み取ることができませんでした。確認して再度入力してください。"
		end

		it "should reject unformatted emails" do
			feedback = FactoryGirl.build :feedback, email: "emailemail.com"
			feedback.should be_invalid
			feedback.errors.full_messages[0].should == "Eメール を読み取ることができませんでした。確認して再度入力してください。"

			feedback = FactoryGirl.build :feedback, email: "email@emailcom"
			feedback.should be_invalid
			feedback.errors.full_messages[0].should == "Eメール を読み取ることができませんでした。確認して再度入力してください。"

			feedback = FactoryGirl.build :feedback, email: "emailemail."
			feedback.should be_invalid
			feedback.errors.full_messages[0].should == "Eメール を読み取ることができませんでした。確認して再度入力してください。"

			feedback = FactoryGirl.build :feedback, email: "emailemail .com"
			feedback.should be_invalid
			feedback.errors.full_messages[0].should == "Eメール を読み取ることができませんでした。確認して再度入力してください。"
		end

		it "should reject content that's too long" do
			feedback = FactoryGirl.build :feedback, content: "a" * 501
			feedback.should be_invalid
			feedback.errors.full_messages[0].should == "お問い合わせ内容 が長過ぎます。（５００字以内）"
		end
	end

end
