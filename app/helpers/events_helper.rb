# Helper methods defined here can be accessed in any controller or view in the application

module GetVolunteers
  class App
    module EventsHelper
      def series
        @_series ||= Series.first slug: params[:series_slug]
      end

      def event
        @_event ||= if params[:id] == 'next'
                      Event.all(series: params[:series_slug]).next
                    else
                      Event.first(series: params[:series_slug], id: params[:id])
                    end
      end
    end

    helpers EventsHelper
  end
end
