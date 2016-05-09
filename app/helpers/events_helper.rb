# Helper methods defined here can be accessed in any controller or view in the application

module GetVolunteers
  class App
    module EventsHelper
      # Loads the series as specified in the request URL as /:series_slug
      def series
        @_series ||= Series.first slug: params[:series_slug]
      end

      # Loads the event specified in the request URL as /:series_slug/:event_id
      def event
        @_event ||= if params[:event_id] == 'next'
                      Event.all(series_slug: params[:series_slug]).next
                    else
                      Event.first(
                          series_slug: params[:series_slug],
                          id:          params[:event_id])
                    end
      end
    end

    helpers EventsHelper
  end
end
