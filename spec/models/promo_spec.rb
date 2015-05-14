require 'spec_helper'

describe Promo do

	before do
		@promo = Promo.new type_of: "single", code: "promopromo", rate: 100
	end

	subject { @promo }
	it { should respond_to :code }
	it { should respond_to :rate }
	it { should respond_to :type_of }
	it { should respond_to :closed }
	it { should respond_to :closed_at }
	it { should respond_to :created_at }
	it { should respond_to :updated_at }

	describe "before validation" do
		it "should strip and downcase code" do
			admin = FactoryGirl.create :admin
			@promo = Promo.new type_of: "single", code: " promOpRomo  ", rate: 100, admin_id: admin.id
			@promo.save
			@promo.code.should == "promopromo"
		end
	end

	describe "validations" do
		it "should require presence of type_of" do
			@promo = Promo.new code: "promopromo", rate: 100
			@promo.should_not be_valid
			@promo.errors.full_messages[0].should == "Type of を読み取ることができませんでした。確認して再度入力してください。"
		end
		it "should require presence of code" do
			@promo = Promo.new type_of: "single", rate: 100
			@promo.should_not be_valid
			@promo.errors.full_messages[0].should == "Code を読み取ることができませんでした。確認して再度入力してください。"
		end
		it "should require presence of rate" do
			@promo = Promo.new type_of: "single", code: "promopromo"
			@promo.should_not be_valid
			@promo.errors.full_messages[0].should == "Rate を読み取ることができませんでした。確認して再度入力してください。"
		end
	end

end
