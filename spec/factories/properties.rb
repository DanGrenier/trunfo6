FactoryBot.define do
  factory :property do 
  	description {"Main Property"}
  	address {"1234 some street"}
    address2 {""}
    city {"Athens"}
    state {"GA"}
    zip {"30606"}
    association :user
    
  end

  factory :property2, class: Property do |b|
    b.description {"Secondary Property"}
    b.address {"1234 some other street"}
    b.address2 {""}
    b.city {"Bogart"}
    b.state {"GA"}
    b.zip {"30622"}
    b.association :user


  end
end
