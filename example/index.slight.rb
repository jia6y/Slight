doctype :html
html do
  head do
    title "Example"
    use "resource/css/bootstrap.css"
    use "resource/script/jquery.js"
  end
  body do
    div "panel" do
      nav "nav nav-pill", id:"NavMenu", css:"color: red" do
        img! src:"resource/images/icon1.png"
      end
    end
    div css:'border 1 bold blue' do
      layout_yield("#{File.dirname(__FILE__)}/component.slight.rb")
    end
    div css:'border 1 bold green' do
      layout_yield("#{File.dirname(__FILE__)}/component.slight.rb")
    end
    br
  end

  js %{
      let a =1;
      console.log(a);
    }

end
