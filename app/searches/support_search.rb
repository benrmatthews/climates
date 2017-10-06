class SupportSearch < Searchlight::Search
  search_on Support.includes(:topic, :receiver, :user)

  searches :body, :topic_id, :receiver_id, :user_id, :state

  def paginated_results(page_number, per_page = 20)
    results.paginate page: page_number, per_page: per_page
  end

  def search_state
    case state
    when 'done'
      search.done
    when 'notdone'
      search.not_done
    else
      search.all
    end
  end

  def search_body
    search.where('body ILIKE ?', "%#{body}%")
  end

  def search_topic_id
    search.where(topic_id: topic_id)
  end

  def search_receiver_id
    search.where(receiver_id: receiver_id)
  end

  def search_user_id
    search.where(user_id: user_id)
  end
end
