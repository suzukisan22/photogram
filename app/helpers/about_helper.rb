module AboutHelper
  def checkPageParams(page)
    page == params[:page] ? "active" : "non-active"
  end
end
