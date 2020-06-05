FactoryBot.define do
  factory :property do 
  	description {"Main Property"}
  	address {"1234 some street"}
    address2 {""}
    city {"Athens"}
    state {"GA"}
    zip {"30606"}
    association :user

    trait :with_picture do 
      property_picture {fixture_file_upload(Rails.root.join('spec','factories','files','home.jpg'),'image/jpg')}
    end
    
  end

  factory :property2, class: Property do |b|
    b.description {"Secondary Property"}
    b.address {"1234 some other street"}
    b.address2 {""}
    b.city {"Bogart"}
    b.state {"GA"}
    b.zip {"30622"}
    b.association :user

    trait :with_picture do 
      b.property_picture {fixture_file_upload(Rails.root.join('spec','factories','files','cabin.jpg'),'image/jpg')}
    end


  end
end
