#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2024 the OpenProject GmbH
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

module ProjectCustomFieldProjectMappings
  class BaseContract < ::ModelContract
    attribute :project_id
    attribute :custom_field_id

    validate :validate_has_select_project_custom_fields_permission
    validate :validate_is_not_required

    def validate_has_select_project_custom_fields_permission
      return if user.allowed_in_project?(:select_project_custom_fields, model.project)

      errors.add :base, :error_unauthorized
    end

    def validate_is_not_required
      # only mappings of custom fields which are not required can be manipulated by the user
      # enabling a custom field which is required happens in an after_save hook within the custom field model itself
      return if model.project_custom_field.nil? || !model.project_custom_field.required?

      errors.add :custom_field_id, :invalid
    end
  end
end