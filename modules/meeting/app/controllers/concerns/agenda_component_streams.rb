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

module AgendaComponentStreams
  extend ActiveSupport::Concern

  included do
    def update_new_section_via_turbo_stream(state: :initial, meeting_agenda_item: nil, meeting: @meeting,
                                            active_work_package: @active_work_package)
      update_via_turbo_stream(
        component: MeetingAgendaItems::NewSectionComponent.new(
          state:,
          meeting:,
          meeting_agenda_item:,
          active_work_package:
        )
      )
    end

    def update_list_via_turbo_stream(meeting: @meeting, active_work_package: @active_work_package)
      # replace needs to be called in order to mount the drag and drop handlers again
      # update would not do that and drag and drop would stop working after the first update
      replace_via_turbo_stream(
        component: MeetingAgendaItems::ListComponent.new(
          meeting:,
          active_work_package:
        )
      )
    end

    def update_heading_via_turbo_stream(meeting: @meeting)
      update_via_turbo_stream(
        component: MeetingAgendaItems::HeadingComponent.new(
          meeting:
        )
      )
    end

    def update_item_via_turbo_stream(state: :show, meeting_agenda_item: @meeting_agenda_item,
                                     active_work_package: @active_work_package)
      update_via_turbo_stream(
        component: MeetingAgendaItems::ItemComponent.new(
          state:,
          meeting_agenda_item:,
          active_work_package:
        )
      )
    end

    def update_all_via_turbo_stream
      update_new_section_via_turbo_stream
      update_list_via_turbo_stream
      update_heading_via_turbo_stream
    end
  end
end
