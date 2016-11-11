doctype :html
html do
  head do
    title "Example"
    use "resource/css/bootstrap.css"
    use "resource/script/jquery.js"
    use "resource/script/angular.js"
  end
  body do
    div "btn btn-primary" do
      nav "nav nav-pill", id:"NavMenu", css:"color: red" do
        img! src:"resource/images/icon1.png"
      end
    end
    span do
      "Hello Span"
    end
    br
    hr
  end

  js %{
      let a =1;
      console.log(a);
    }

end
