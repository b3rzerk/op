#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2023 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

class CustomFields::Inputs::MultiSelectList < CustomFields::Inputs::Base::Autocomplete::MultiValueInput
  form do |custom_value_form|
    # autocompleter does not set key with blank value if nothing is selected or input is cleared
    # in order to let acts_as_customizable handle the clearing of the value, we need to set the value to blank via a hidden field
    # which sends blank if autocompleter is cleared
    custom_value_form.hidden(**input_attributes.merge(
      scope_name_to_model: false,
      name: "#{@object.class.name.downcase}[custom_field_values][#{input_attributes[:name]}][]",
      value:
    ))

    custom_value_form.autocompleter(**input_attributes) do |list|
      @custom_field.custom_options.each do |custom_option|
        list.option(
          label: custom_option.value, value: custom_option.id,
          selected: selected?(custom_option)
        )
      end
    end
  end

  private

  def decorated?
    true
  end

  def selected?(custom_option)
    cf_values = @custom_values.reject { |custom_value| custom_value.id.nil? }

    if cf_values.any?
      cf_values.pluck(:value).map { |value| value&.to_i }.include?(custom_option.id)
    else
      custom_option.default_value?
    end
  end
end