# frozen_string_literal: true

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

module Members
  class DeleteWorkPackageSharesDialogComponent < ::ApplicationComponent
    options :row

    delegate :principal,
             :shared_work_package_ids,
             :other_shared_work_packages_count?,
             :direct_shared_work_packages_count,
             :inherited_shared_work_packages_count?,
             :total_shared_work_packages_count,
             to: :model

    def shared_work_packages_count = model.shared_work_package_ids.length

    def shared_role_id = row.table.shared_role_id
    def shared_role_name = row.table.shared_role_name

    def only_inherited_shared_work_packages? = direct_shared_work_packages_count.zero?

    def administration_settings_link
      link_to 'administration settings', edit_user_path(model.principal, tab: :groups)
    end

    def id
      "principal-#{principal.id}-delete-work-package-shares-dialog"
    end

    def delete_url(work_package_shares_role_id: nil)
      url_for(controller: '/members', action: 'destroy_by_principal', principal_id: principal, work_package_shares_role_id:)
    end
  end
end
