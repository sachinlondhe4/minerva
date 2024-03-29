module CalendarHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year}, :id=>('month_'+month_date.month.to_s))
  end

  # custom options for this calendar
  def event_calendar_opts
    {
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text => "&lt;&lt; #{month_link(@shown_month.prev_month)}",
      :next_month_text => "#{month_link(@shown_month.next_month)} &gt;&gt;",
      :use_all_day => true
    }
  end

  def event_calendar
   
    calendar event_calendar_opts do |args|
      event, day = args[:event], args[:day]
      if @nurse and (@nurse.id == event.nurse_id)
        html = %(<a href="/nurse/#{event.nurse_id}/calendar/#{event.id}" title="#{h(event.name)}" class="event">)
        html << %Q(#{@nurse.name})
        if event.pto
          html << %Q( - PTO)
        end
        html << %Q(</a>)
      else
        html = %(<a href="#">)
        html << %(</a>)
      end
      html
    end
  end

  def admin_event_calendar
    
    calendar event_calendar_opts do |args|
      event, day = args[:event], args[:day]
      html = %(<a href="/nurse/#{event.nurse_id}/calendar/#{event.id}"
               title="#{h(event.name + '-' + event.nurse.position.to_s)}" class="event">)
      html << display_event_time(event, day)
      html << %(#{h(event.name)})
      if event.pto
        html << %Q( - PTO)
      end
      html << %Q(</a>)
      html
    end
  end
end
