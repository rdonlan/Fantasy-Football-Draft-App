class DrafttrackController < ApplicationController

  def destroy_all
    Pat1.destroy_all
    Ram1.destroy_all
    Falcon1.destroy_all
    AvailablePlayer.destroy_all      
    respond_to do |format|
      format.html{redirect_to "/"}
    end
  end

  def startDraft
    @availablePlayers = []
    @playerArray = []
    if AvailablePlayer.first.nil? && Pat1.first.nil? && Ram1.first.nil? && Falcon1.first.nil?
      File.open("playerlist.txt").each do |line|
        @playerArray << line.strip.split("\t")
      end
  
      @playerArray.each do |player|
        pos = player[0]
        name = player[1]
        rating = player[2].to_f
        map = {"position" => pos, "player" => name, "rating" => rating}
        newPlayer = AvailablePlayer.new(map)
        newPlayer.save
      end
    end
    
    @availablePlayers = AvailablePlayer.all
    @patriots = Pat1.all
    @falcons = Falcon1.all
    @rams = Ram1.all 
  end


  def draftPlayer
    puts "----------- In draftPlayer --------------"
    if @playerArray.nil?
      @playerArray = []
      File.open("playerlist.txt").each do |line|
        @playerArray << line.strip.split("\t")
      end
    end
    @availablePlayers = AvailablePlayer.all
    @patriots = Pat1.all
    @falcons = Falcon1.all
    @rams = Ram1.all
    @@teamnum = AvailablePlayer.count % 3
    teamlist = ["pats","falcons","rams"]
    @team = teamlist[@@teamnum]

    if @team == "pats"
      @current_team = Pat1
    elsif @team == "falcons"
      @current_team = Falcon1
    elsif @team == "rams"
      @current_team = Ram1
    end

    player = params[:draftInput]
    playerToBeDrafted = AvailablePlayer.find_by(player: player)

    if playerToBeDrafted.nil?
      puts "-----------no player has been found with this name----------------"
      # WE NEED TO FIGURE OUT HOW TO HANDLE
      respond_to do |format|
        format.html{redirect_to "/"} and return
      end
      abort
    end

    pos = playerToBeDrafted.position
    name = playerToBeDrafted.player
    rating = playerToBeDrafted.rating
    
    map = {"position" => pos, "player" => name, "rating" => rating}

    playerToBeDeleted = AvailablePlayer.find_by(player: name)
    playerToBeDeleted.destroy
    newRow = @current_team.new(map)
    
    respond_to do |format|
      if newRow.save
        puts "Successfully saved data into ", @current_team, " table!"
        format.html{redirect_to "/"}
      else
        format.html{redirect_to "/"}
      end
    end
  end  
end