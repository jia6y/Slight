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
      nav "nav nav-pill", css:"color: red" do 
        
      end
    end
  end
end