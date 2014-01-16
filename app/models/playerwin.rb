require 'win32ole'

module WinPlay
  class Player

    @@itunes = WIN32OLE.new('iTunes.Application')

    def self.state
      `./script/get-state`
    end

    def self.playing
      song = @@itunes.CurrentTrack
      "Now playing #{song.Name} by #{song.Artist}..."
    end

    def self.artwork
      art = `./script/artwork`.gsub /(?<!\n)\n(?!\n)/, ''
    end

    def self.play
      @@itunes.Play
      self.playing
    end

    def self.pause
      @@itunes.Pause
    end
    
    def self.next
      @@itunes.NextTrack
      "Onwards! #{self.playing}"
    end

    def self.back
      @@itunes.PreviousTrack
      "Let's hear it again! #{self.playing}"
    end
    
    def self.mute
      @@itunes.SoundVolume = 0
      'Shhh...'
    end

    def self.volume
      vol = @@itunes.SoundVolume
      vol.to_i
    end
    
    def self.how_much_longer
      `./script/how-much-longer`
    end

    def self.volume=(vol)
      vol+=1
      @@itunes.SoundVolume += vol
      vol
    end

    def self.play_song(song)
      song.Play
      self.playing
    end

    def self.find(track)
      library = @@itunes.LibraryPlaylist

      allTracks = library.Search(track, 5)

      return allTracks

      return nil
    end

    def self.say(what)
      currentVolume = self.volume
      self.volume=currentVolume/3
      `say #{what}`
      self.volume = currentVolume
      what
    end

  end
end