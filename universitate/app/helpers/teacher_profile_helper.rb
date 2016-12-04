module TeacherProfileHelper
  def google_logo(user)
    user.logged?('google_oauth2') ? image_tag('GooglePlus_color.png') : image_tag('GooglePlus_grey.png')
  end

  def linkedin_logo(user)
    user.logged?('linkedin') ? image_tag('LINKEDIN_color.png') : image_tag('LINKEDIN_grey.png')
  end
end
