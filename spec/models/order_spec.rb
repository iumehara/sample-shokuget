require 'spec_helper'

describe Order do

	before do
		@job = FactoryGirl.create :job
		@admin = FactoryGirl.create :admin
		@promo = FactoryGirl.create :promo, code: "promopromo", rate: 100, admin_id: @admin.id
		@redemption = FactoryGirl.create :redemption, job_id: @job.id, promo_code: "promopromo"
		@order = @job.build_order(promo_id: @promo.id)
	end

	subject { @order }
	it { should respond_to :job_id }
	it { should respond_to :promo_id }
	it { should respond_to :ip_address }
	it { should respond_to :first_name }
	it { should respond_to :last_name }
	it { should respond_to :card_type }
	it { should respond_to :card_expires_on }
	it { should respond_to :amount }
	it { should respond_to :created_at }
	it { should respond_to :updated_at }
	it { should be_valid }
	it { should respond_to :card_number }
	it { should respond_to :card_verification }

	describe "validations" do
		it "should set amount" do
			order = FactoryGirl.create :order, job_id: @job.id, promo_id: @promo.id, amount: nil
			order.amount.should == @redemption.amount
			order.amount_outstanding?.should == false
		end
	end

end
