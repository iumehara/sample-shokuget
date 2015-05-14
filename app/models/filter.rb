class Filter < ActiveRecord::Base

	belongs_to :form, polymorphic: :true
	before_validation :set_a_type
	validates_presence_of :form_type, :form_id, :q_text
	before_save :jsonify_a_string_if_array

	def a_string
		if super.class == String
			JSON.parse super
		else
			super
		end
	end

	def select_options
		if super.class == String
			JSON.parse super
		else
			super
		end
	end


	def parent
		Filter.find(self.parent_id)
	end

	def answer
		select_options = self.parent.select_options
		select_options.delete_if { |option| option[1] != self.a_int }
		select_options[0][0]
	end


	private

		def set_a_type
			unless self.a_type.to_s == "String" || self.a_type.to_s == "Boolean"
				self.a_type = "Integer"
			end
		end

		def jsonify_a_string_if_array
			if self.a_string.class.to_s == "Array"
				s_to_i = self.a_string.map{ |x| x.to_i }
				self.a_string = s_to_i.to_json
			end
		end

end

# == Schema Information
#
# Table name: filters
#
#  id             :integer         not null, primary key
#  form_type      :string(255)
#  form_id        :integer
#  section        :string(255)
#  q_text         :string(255)
#  a_int          :integer
#  a_bool         :boolean
#  a_string       :string(255)
#  select_options :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  parent_id      :integer
#  a_type         :string(255)
#

