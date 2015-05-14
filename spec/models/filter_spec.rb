require 'spec_helper'

describe Filter do

	before do
		@filter = Filter.new(form_type: "Job",
			                   form_id: 1,
			                   section: "work",
			                   q_text: "募集する職種と関連した仕事での経験年数",
			                   select_options: (0..10).to_a.to_json)
	end

	subject { @filter }
	it { should respond_to :a_bool }
	it { should respond_to :a_int }
	it { should respond_to :a_string }
	it { should respond_to :created_at }
	it { should respond_to :form_id }
	it { should respond_to :form_type }
	it { should respond_to :parent_id }
	it { should respond_to :q_text }
	it { should respond_to :section }
	it { should respond_to :select_options }
	it { should respond_to :updated_at }
	it { should be_valid }

	describe "validations" do
		it "should require form_id" do
			filter = FactoryGirl.build :filter, form_id: nil
			filter.should be_invalid
			filter.errors.full_messages[0].should == "Form を読み取ることができませんでした。確認して再度入力してください。"
		end
		it "should require form_type" do
			filter = FactoryGirl.build :filter, form_type: nil
			filter.should be_invalid
			filter.errors.full_messages[0].should == "Form type を読み取ることができませんでした。確認して再度入力してください。"
		end
		it "should require q_text" do
			filter = FactoryGirl.build :filter, q_text: nil
			filter.should be_invalid
			filter.errors.full_messages[0].should == "Q text を読み取ることができませんでした。確認して再度入力してください。"
		end
	end

end
