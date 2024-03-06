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
  class DeleteMemberDialogComponent < ::ApplicationComponent
    options :row

    delegate :can_delete?, :can_delete_shares?, to: :row

    delegate :principal,
             :shared_work_package_ids,
             :inherited_shared_work_package_ids,
             :total_shared_work_package_ids,
             to: :model

    def shared_work_packages_count = model.shared_work_package_ids.length
    def inherited_shared_work_packages_count = model.inherited_shared_work_package_ids.length
    def total_shared_work_packages_count = model.total_shared_work_package_ids.length

    def id
      "principal-#{principal.id}-delete-member-dialog"
    end

    def delete_url(delete_member: nil, delete_work_package_shares: nil)
      url_for(controller: '/members', action: 'destroy_by_principal', principal_id: principal, delete_member:, delete_work_package_shares:)
    end
  end
end
