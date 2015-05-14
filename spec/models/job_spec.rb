require 'spec_helper'

describe Job do

	before do
		@job = FactoryGirl.create :job
	end

	subject { @job }
	it { should respond_to :active }
	it { should respond_to :apply_info }
	it { should respond_to :created_at }
	it { should respond_to :company }
	it { should respond_to :description }
	it { should respond_to :email }
	it { should respond_to :expire_date }
	it { should respond_to :industry }
	it { should respond_to :location }
	it { should respond_to :title }
	it { should respond_to :type_of }
	it { should respond_to :updated_at }
	it { should respond_to :url }
	it { should respond_to :recruiter_name }
	it { should be_valid }

	describe "validations" do

		it "should reject unformatted emails" do
			@job = FactoryGirl.build :job, email: "emailemail.com"
			@job.should be_invalid
			@job.errors.full_messages[0].should == "Eメール を読み取ることができませんでした。確認して再度入力してください。"

			@job = FactoryGirl.build :job, email: "email@emailcom"
			@job.should be_invalid
			@job.errors.full_messages[0].should == "Eメール を読み取ることができませんでした。確認して再度入力してください。"

			@job = FactoryGirl.build :job, email: "emailemail."
			@job.should be_invalid
			@job.errors.full_messages[0].should == "Eメール を読み取ることができませんでした。確認して再度入力してください。"

			@job = FactoryGirl.build :job, email: "emailemail .com"
			@job.should be_invalid
			@job.errors.full_messages[0].should == "Eメール を読み取ることができませんでした。確認して再度入力してください。"
		end

		it "should create and set token" do
			@job = FactoryGirl.create :job
			@job.token.should be_present
		end

		it "should require email" do
			@job = FactoryGirl.build :job, email: nil
			@job.should be_invalid
			@job.errors.full_messages[0].should == "Eメール を読み取ることができませんでした。確認して再度入力してください。"
		end

		it "should require title" do
			@job = FactoryGirl.build :job, title: nil
			@job.should be_invalid
			@job.errors.full_messages[0].should == "タイトル を読み取ることができませんでした。確認して再度入力してください。"
		end

		it "should require industry" do
			@job = FactoryGirl.build :job, industry: nil
			@job.should be_invalid
			@job.errors.full_messages[0].should == "業界 を読み取ることができませんでした。確認して再度入力してください。"
		end

		it "should require location" do
			@job = FactoryGirl.build :job, location: nil
			@job.should be_invalid
			@job.errors.full_messages[0].should == "勤務地 を読み取ることができませんでした。確認して再度入力してください。"
		end

		it "should require type_of" do
			@job = FactoryGirl.build :job, type_of: nil
			@job.should be_invalid
			@job.errors.full_messages[0].should == "勤務形態 を読み取ることができませんでした。確認して再度入力してください。"
		end

		it "should require description" do
			@job = FactoryGirl.build :job, description: nil
			@job.should be_invalid
			@job.errors.full_messages[0].should == "職務内容 を読み取ることができませんでした。確認して再度入力してください。"
		end

		it "should require company" do
			@job = FactoryGirl.build :job, company: nil
			@job.should be_invalid
			@job.errors.full_messages[0].should == "企業名 を読み取ることができませんでした。確認して再度入力してください。"
		end
	end

	describe "Callbacks" do
		context "Visa Filter" do
			it "should create correct filter visa jobs" do
				@job = FactoryGirl.create(:job,
					title: "New Job",
					industry: "Sales",
					location: "マンハッタン",
					type_of: "Full-time",
					company: "Bobs Burgers",
					email: "bob@email.com",
					visa: true
				)
				filter = @job.filters.first
				filter.section.should == "visa"
				filter.q_text.should  == "現在のビザステータス"
				filter.select_options.should == VISA_OPTIONS
				filter.a_type.should == "Integer"
				filter.a_int.should == 10
			end
			it "should create correct filter non-visa jobs" do
				@job = FactoryGirl.create(:job,
					title: "New Job",
					industry: "Sales",
					location: "マンハッタン",
					type_of: "Full-time",
					company: "Bobs Burgers",
					email: "bob@email.com",
					visa: false
				)
				filter = @job.filters.first
				filter.section.should == "visa"
				filter.q_text.should  == "現在のビザステータス"
				filter.select_options.should == VISA_OPTIONS
				filter.a_type.should == "Integer"
				filter.a_int.should == 30
			end
		end
	end
end
