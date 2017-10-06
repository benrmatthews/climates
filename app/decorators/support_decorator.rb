class SupportDecorator < Draper::Decorator

  decorates :support
  delegate :done?, :body, :discussed?, :receiver, :user,
           :updated_at, :comments_count

  def topic
    topic.title
  end

  def title
    h.raw "#{receiver} asked #{user} for help."
  end

  def ticket_id
    "##{object.id}"
  end

  def formatted_date(date)
    "#{h.time_ago_in_words(date)} ago"
  end

  def started_at
    formatted_date object.created_at
  end

  def finished_at
    formatted_date object.updated_at
  end

  def comments_label
    return unless object.discussed?
    " &middot; #{h.pluralize(object.comments_count, 'comment')}".html_safe
  end

  def formatted_list_label(params)
    active_user = h.content_tag(:strong, params[:active_user])
    passive_user = h.content_tag(:strong, params[:passive_user])
    "#{active_user} #{params[:action]} #{passive_user} in".html_safe
  end

  def folks_label
    params =  if done?
                { active_user: user, action: 'helped', passive_user: receiver }
              else
                { active_user: receiver, action: 'asked', passive_user: user }
              end
    formatted_list_label params
  end

  def css_class
    status = SupportStatus.new object
    done? ? 'done' : status
  end

  def action_button
    return if done?

    if support.receiver == h.current_user
      thanks_for_help_button
    elsif discussed?
      finish_button
    else
      ack_button
    end
  end

  def delete_button
    return if done? || support.receiver != h.current_user
    h.link_to 'Delete', h.support_path(object),
              method: :delete,
              data: { confirm: h.t('support.destroy.confirm') }
  end

  def skip_button
    return if done? || support.user != h.current_user

    h.link_to h.raw('Skip'), h.skip_support_path(object),
              method: :post,
              data: { confirm: "Do you really don't have time for this one?" }
  end

  def user
    UserDecorator.decorate(object.user)
  end

  def receiver_link
    receiver.profile_link
  end

  def user_link
    user.profile_link
  end

  def receiver
    UserDecorator.decorate(object.receiver)
  end

  def topic
    TopicDecorator.decorate(object.topic)
  end

  def truncated_body
    body.truncate(150) if body.present?
  end

  def state_image
    status  = object.done? ? 'done' : 'new'
    h.image_tag "i/status-#{status}.png"
  end

  private

  def thanks_for_help_button
    finish_button "I've received help!",
                  "Are you sure? #{user} will receive a credit for that."
  end

  def finish_button(text = nil, confirmation = nil)
    text ||= 'Mark as resolved'
    confirmation ||=  'Are you sure you are done helping? This action will '\
                      'also set you as a supporter for this issue.'
    h.link_to h.raw(text), h.finish_support_path(object),
      method: :post,
      data: { confirm: confirmation },
      class: 'btn btn-success'
  end

  def ack_button
    h.link_to h.raw('Acknowledge!'), h.ack_support_path(object),
      method: :post, class: 'btn btn-success'
  end
end
