doctype :html
html do
  head do
    title "Example"
    use "/css/bootstrap.css"
    use "/script/jquery.js"
    use "/script/angular.js"
  end
  body do
    div "btn btn-primary" do
      nav "nav nav-pill", id:"NavMenu", css:"color: red" do
        img! src:"/images/icon1.png"
      end
    end
    span do
      "Hello Span"
    end
    br
    hr
  end
  js do
%{
      let a =1;
      console.log(a);
}
  end
end
