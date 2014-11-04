feature 'create a goal' do
  before :each do
    sign_up("Thomas_the_tank", "engine")
  end 
  
  it 'users show page should have button to create goal' do
    expect(page).to have_content("Create Goal")
  end
  
  feature 'new goal page' do
    before :each do
      click_button('Create Goal')
    end
    
    it "clicking goal button should bring you to new goal page" do
      expect(page).to have_content('Create a New Goal')
    end
    
    it "should show errors if goal parameters aren't valid" do
      click_button('Submit Goal')
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Description can't be blank")
    end
    
    it "should return to new goal's show page after creating valid goal" do
      fill_in('Title', with: "Exercise")
      fill_in('Description', with: "Go uphill at least 50% of the time")
      choose('Incomplete')
      choose('Public')
      click_button('Submit Goal')
      expect(page).to have_content('Exercise')
      expect(page).to have_content('Go uphill at least 50% of the time')
    end
  end
  
end

feature 'read a goal' do
  before :each do
    sign_up("Pablo Sandoval", "go_giants")
    FactoryGirl.build(:goal, privacy: "public", status: "complete")
    FactoryGirl.build(:goal, title: "Different Goal",
     privacy: "private", status: "incomplete")
  end
  
  it "user's show page should have links to goals" do
    expect(page).to have_content "Goal Title"
  end
  
  feature "user's goal show page" do
    before :each do
      click_link("Goal Title")
    end
    
    it "should have name of goal" do 
      expect(page).to have_content("Goal Title")
    end
     
    it "should have description of goal" do
      expect(page).to have_content("Goal Description")
    end
    
    it "should have goal completion status" do 
      expect(page).to have_content("complete")
    end
    
    it "should have link back to user page" do
      expect(page).to have_content("User Page")
    end
    
    it "should have a button to delete goal" do 
      expect(page).to have_content("Delete")
    end
    
    it "should have button to update goal" do 
      expect(page).to have_content("Update")
    end
  end
  
  feature "visit another user's show page" do
    before :each do
      click_button('Log Out')
      sign_up("Aaron Rodgers", "go_pack_go")
      visit user_url(1)
    end
    
    it "should display public goals" do
      expect(page).to have_content("Goal Title")
    end
    
    it "should not display private goals" do
      expect(page).not_to have_content("Different Goal")
    end
    
    feature "display show page for a specific goal" do
      before :each do
        click_link("Goal Title")
      end
      
      it "should have name of goal" do 
        expect(page).to have_content("Goal Title")
      end
    
      it "should have description of goal" do 
        expect(page).to have_content("Goal Description")
      end
    
      it "should have goal completion status" do
        expect(page).to have_content("complete")
      end
    
      it "should have link back to user page" do
        expect(page).to have_content("User Page")
      end
    
      it "should not have a button to delete goal" do 
        expect(page).not_to have_content("Delete")
      end
    
      it "should not have button to update goal" do 
        expect(page).not_to have_content("Update")
      end
    end
    
  end
end

feature 'update a goal' do
  before :each do
    sign_up("Pablo Sandoval", "go_giants")
    FactoryGirl.build(:goal, privacy: "public", status: "complete")
    FactoryGirl.build(:goal, title: "Different Goal",
      privacy: "private", status: "incomplete")
    click_link('Goal Title')
    click_button("Update")
  end
  
  it "clicking update button should redirect to edit page" do
    expect(page).to have_content("Edit Goal")
  end
  
  it "should show errors if goal params are invalid" do
    fill_in("Title", with: "")
    fill_in("Description", with: "")
    click_button("Submit")
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Description can't be blank"
  end
  
  it "should return the goal show page after updating" do
    fill_in("Title", with: "New Title")
    fill_in("Description", with: "New Description")
    click_button("Submit")
    expect(page).to have_content "New Title"
  end
end

feature 'delete a goal' do
  before :each do
    sign_up("Pablo Sandoval", "go_giants")
    FactoryGirl.build(:goal, privacy: "public", status: "complete")
    FactoryGirl.build(:goal, title: "Different Goal",
      privacy: "private", status: "incomplete")
    click_link('Goal Title')
    click_button("Delete")
  end
   
  it "should redirect to the user show page" do
    expect(page).to have_content "Pablo Sandoval"
  end
  
  it "goal should no longer appear on user show page" do
    expect(page).not_to have_content "Goal Title"
  end
end