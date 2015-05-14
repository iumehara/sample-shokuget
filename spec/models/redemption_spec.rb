require 'spec_helper'

describe Redemption do

	before do
		@admin      = FactoryGirl.create :admin
		@promo      = FactoryGirl.create :promo, code: "promopromo", admin_id: @admin.id
		@redemption = FactoryGirl.create :redemption, promo_id: @promo.id, promo_code: "promopromo"
	end

	subject { @redemption }
	it { should respond_to :created_at }
	it { should respond_to :updated_at }
	it { should respond_to :promo_id }
	it { should respond_to :job_id }
	it { should respond_to :amount }
	it { should be_valid }

	describe "validations" do

		it "should reject incorrect promo code" do
			@redemption = FactoryGirl.build :redemption, promo_code: "ropmoasdf"
			@redemption.should be_invalid
			@redemption.errors.full_messages[0].should == "入力されたプロモーションコード「ropmoasdf」は利用できませんでした。プロモーションコードに間違いがないかご確認ください。"
		end

		it "should be case insensitive" do
			@redemption = FactoryGirl.build :redemption, promo_code: "PROMOpromo"
			@redemption.should be_valid
		end

	end

end
