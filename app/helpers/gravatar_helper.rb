module GravatarHelper

  def gravatar_image_tag email, size
    hash = Digest::MD5.hexdigest(email)
    image_tag "//www.gravatar.com/avatar/#{hash}?s=#{size}",
              height: size, width: size, class: 'user_avatar'
  end

end
