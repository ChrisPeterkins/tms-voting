module PollsHelper
  
  def active_poll?
    @polls.each do |poll|
      if(poll.active)
        return true
      end
    end
  end
  
  def visualize_votes_for(option)
    content_tag :div, class: 'progress' do
      content_tag :div, class: 'progress-bar',
                  style: "width: #{option.poll.normalized_votes_for(option)}%" do
        "#{option.votes.count}"
      end
    end
  end
end