module ModelHelper

  def model_user?(model)
    signed_in? and (current_user == model.user)
  end
end
