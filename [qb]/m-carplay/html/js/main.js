const store = Vuex.createStore({
  state: {},
  mutations: {},
  actions: {},
});

const app = Vue.createApp({
  data: () => ({
    Show: false,
    time: localStorage.getItem("ScreenMode") || "dark",
    carPlayPosition: {
      left: null,
      top: null,
    },
    currentPage: "AutoPilotApp",
    CurrentPageData: {
      DefaultApp: false,
      AutoPilotApp: false,
      DoorApp: false,
      NeonApp: false,
      MusicApp: true,
      KonumApp: false,
      SettingsApp: false,
    },
    PlayerPlaylist: [
      {
        title: "Liked Songs",
        song: [
          {
            name: "Never Gonna Give You Up",
            artistname: "Rick Astley",
            url: "https://youtu.be/dQw4w9WgXcQ",
            kapakPictures:
              "https://i.scdn.co/image/ab67616d0000b273baf89eb11ec7c657805d2da0",
            songimage:
              "https://i.scdn.co/image/ab67616d00001e02baf89eb11ec7c657805d2da0",
            image:
              "https://i.scdn.co/image/ab67616d00004851baf89eb11ec7c657805d2da0",
            liked: true,
            playing: false,
          },
        ],
        image:
          "https://i.scdn.co/image/ab67616d00001e0226f7f19c7f0381e56156c94a",
        liked: true,
        playing: true,
      },
    ],
    currentPlaylist: null,
    notifyData: {
      bool: false,
      text: "Notification",
    },
    Playlist: {
      timer: null,
      DeletePlaylist: true,
      ShowPlaylistData: false,
      OtherPlayer: false,
      OtherPlayerID: null,
      PauseMusic: true,
      AddPlaylistSucces: false,
      DeletePlaylistSucces: false,
      NewPlaylistName: "Playlist Name",
      EditButton: false,
      CoverUrlvmodel: "Cover Image URL...",
      SongURLvmodel: "Song URL...",
      Playingsong: {
        currentTime: "0",
        maxDuration: "186",
        name: localStorage.getItem("playlistName") || "Never Gonna Give You Up",
        artistname: localStorage.getItem("playlistArtistname") || "Rick Astley",
        url:
          localStorage.getItem("playlistUrl") || "https://youtu.be/dQw4w9WgXcQ",
        kapakPictures:
          localStorage.getItem("playlistKapakPictures") ||
          "https://i.scdn.co/image/ab67616d0000b273baf89eb11ec7c657805d2da0",
        songimage:
          localStorage.getItem("playlistSongimage") ||
          "https://i.scdn.co/image/ab67616d00001e02baf89eb11ec7c657805d2da0",
        image:
          localStorage.getItem("playlistImage") ||
          "https://i.scdn.co/image/ab67616d00004851baf89eb11ec7c657805d2da0",
        liked: localStorage.getItem("playlistLiked") || false,
        playing: false,
      },
    },

    playerdata: {
      name: "TURKYUSUFFFFFF",
      soundlevel: localStorage.getItem("soundlevel") || 25,
      avatar: "./img/profilepicture.png",
    },
    NewCreatePlaylist: false,
    defaultapp: false,
    currentTime: "",
    SecilenMode: localStorage.getItem("vmodelScreen") || "dark",
    screenSize: 100,
    Locales: {},

    soundOpen: "",
    menuBackGround: localStorage.getItem("menuBackGround") || false,
    passengerAccess: localStorage.getItem("passengerAccess") || false,
    minishow: localStorage.getItem("minishow") || false,
    LastPlaylistUrl: "",
    lastPlaylistName: "",
    lastPlaylistSong: "",
    VehicleData: {
      speed: 180,
      fuel: 70,
      nosLevel: 20,
      gearN: 2,
      broken: false,
      gear: "D",
      light: true,
      belt: false,
      image: "./img/vehicle/0.png",
      NeonBool: true,
      LeftSignal: true,
      Brake: true,
      RightSignal: true,
      LongLight: false,
      ShortLight: true,
      autoPilotStatus: false,
      Zone: "WINEWOOD",
      Street: "WINEWOOD BOULEVARD",
      neon: {
        all: false,
        party: false,
        front: false,
        rear: false,
        "l-side": false,
        "r-side": false,
        color: "purple",
      },

      windows: {
        0: false, // Sol ön cam
        1: false, // Sağ ön cam
        2: false, // Sol arka cam
        3: false, // Sağ arka cam
        4: false, // bütün camlar
      },

      doors: {
        0: false, // Sol ön kapı
        1: false, // Sağ ön kapı
        2: false, // Sol arka kapı
        3: false, // Sağ arka kapı
        4: false, // Kaput
        5: false, // Bagaj
      },
    },
    isDragging: false,
    offsetX: 0,
    offsetY: 0,
  }),

  methods: {
    MouseDown() {},
    MouseUp() {},

    MakeElementDraggable(classname, type) {
      let started = false;
      $(classname).draggable({
        helper: "clone",
        revertDuration: 0,
        revert: false,
        containment: "body",
        scroll: false,
        start: (event, ui) => {
          if (
            document.elementFromPoint(event.clientX, event.clientY)
              .firstChild == null
          ) {
            return false;
          } else {
            if (
              document.elementFromPoint(event.clientX, event.clientY).firstChild
                .textContent.length <= 0 &&
              document.body.contains(
                document.elementFromPoint(event.clientX, event.clientY)
                  .firstChild
              ) &&
              document
                .elementFromPoint(event.clientX, event.clientY)
                .firstChild.classList.contains("tablet-cover")
            ) {
              return true;
            }
            return false;
          }
        },
        drag: (event, ui) => {},
        stop: (event, ui) => {
          let left = ui.position.left;
          let top = ui.position.top;
          this.carPlayPosition.left = left;
          this.carPlayPosition.top = top;

          localStorage.setItem(
            "CarPlayPoss",
            JSON.stringify({
              left,
              top,
            })
          );

          // let type = $(event.target).attr('data-type');
          // this.positionsData[type] = { left: `${left}px`, top: `${top}px`, position: `absolute` };
          // this.setHudSettings({
          //     type,
          //     value: {
          //         left,
          //         top,
          //     },
          // })
        },
      });
    },
    playAudio() {
      const audio = document.getElementById("music");
      if (audio) {
        audio.play();
      }
    },
    clearPlaceholder() {
      this.Playlist.NewPlaylistName = "";
      this.Playlist.SongURLvmodel = "";
    },
    clearPlaceholderSongURLvmodel() {
      this.Playlist.SongURLvmodel = "";
    },
    CreatePlaylist() {
      this.playAudio();
      this.NewCreatePlaylist = false;
    },
    sendNotify(bool, text) {
      if (this.notifyData.bool) {
        setTimeout(() => {
          this.notifyData.bool = false;
        }, 3000);
      } else {
        this.notifyData.bool = bool;
        this.notifyData.text = text;

        setTimeout(() => {
          this.notifyData.bool = false;
        }, 5000);
      }
    },
    ChangePage(page) {
      if (page == "MusicApp") {
        this.Playlist.EditButton = false;
        this.Playlist.ShowPlaylistData = false;
      }
      if (this.CurrentPageData[page] === true) {
        for (const key in this.CurrentPageData) {
          this.CurrentPageData[key] = false;
        }
        this.CurrentPageData["DefaultApp"] = true;
        this.playAudio();
      } else {
        for (const key in this.CurrentPageData) {
          this.CurrentPageData[key] = false;
        }
        this.CurrentPageData[page] = true;
        this.playAudio();
      }
    },
    DoorOpen(index) {
      if (this.Playlist.OtherPlayer) {
        this.playAudio();
        this.sendNotify(true, this.Locales["ONLYDRIVER"]);
      } else {
        this.playAudio();
        this.VehicleData.doors[index] = !this.VehicleData.doors[index];
        postNUI("EDIT_VEHICLE", {
          page: "DoorPart",
          i: index,
        });
      }
    },
    DoorWindows(index) {
      if (this.Playlist.OtherPlayer) {
        this.playAudio();
        this.sendNotify(true, this.Locales["ONLYDRIVER"]);
      } else {
        this.playAudio();
        if (index === "all") {
          this.VehicleData.windows[0] = !this.VehicleData.windows[0];
          this.VehicleData.windows[1] = !this.VehicleData.windows[1];
          this.VehicleData.windows[2] = !this.VehicleData.windows[2];
          this.VehicleData.windows[3] = !this.VehicleData.windows[3];
          this.VehicleData.windows[4] = !this.VehicleData.windows[4];
        } else {
          this.VehicleData.windows[index] = !this.VehicleData.windows[index];
        }
        postNUI("EDIT_VEHICLE", {
          page: "WindowsPart",
          i: index,
        });
      }
    },
    NeonPart(index, bool) {
      if (this.VehicleData.NeonBool) {
        if (this.Playlist.OtherPlayer) {
          this.playAudio();
          this.sendNotify(true, this.Locales["ONLYDRIVER"]);
        } else {
          this.playAudio();
          if (bool == true) {
            this.VehicleData.neon[index] = !this.VehicleData.neon[index];
            if (index == "all") {
              this.VehicleData.neon["party"] = false;
              this.VehicleData.neon["front"] = !this.VehicleData.neon["front"];
              this.VehicleData.neon["rear"] = !this.VehicleData.neon["rear"];
              this.VehicleData.neon["l-side"] =
                !this.VehicleData.neon["l-side"];
              this.VehicleData.neon["r-side"] =
                !this.VehicleData.neon["r-side"];
            }
            postNUI("EDIT_VEHICLE", {
              page: "NeonPosition",
              i: index,
            });
          } else {
            this.VehicleData.neon.color = index;
            postNUI("EDIT_VEHICLE", {
              page: "NeonColor",
              i: this.VehicleData.neon.color,
            });
          }
        }
      }
    },
    SelectLocation(index) {
      this.playAudio();
      postNUI("MARK_NEAREST", {
        location: index,
      });
    },
    ClickMusic(index, data) {
      this.playAudio();
      if (index == "NewCreate") {
        this.NewCreatePlaylist = !this.NewCreatePlaylist;
      } else if (index == "ShowPlaylist") {
        this.Playlist.ShowPlaylistData = data;
        if (this.Playlist.ShowPlaylistData.title !== "Liked Songs") {
          this.LastPlaylistUrl = this.Playlist.ShowPlaylistData.image;
          this.lastPlaylistName = this.Playlist.ShowPlaylistData.title;
          this.lastPlaylistSong = this.Playlist.ShowPlaylistData.song;
        }
      } else if (index == "CancelPlaylistCreate") {
        this.NewCreatePlaylist = !this.NewCreatePlaylist;
      } else if (index == "BackPlaylist") {
        if (this.Playlist.ShowPlaylistData.title !== "Liked Songs") {
          this.Playlist.ShowPlaylistData.title = this.lastPlaylistName;
          this.Playlist.ShowPlaylistData.image = this.LastPlaylistUrl;
          this.Playlist.ShowPlaylistData.song = this.lastPlaylistSong;
        }
        this.Playlist.EditButton = false;
        this.Playlist.ShowPlaylistData = false;
      } else if (index == "EditPlaylist") {
        if (
          this.Playlist.ShowPlaylistData.title !== "Liked Songs" &&
          this.Playlist.ShowPlaylistData.title.length >= 2
        ) {
          const previousUrl = this.LastPlaylistUrl;
          const previousName = this.lastPlaylistName;
          const previousSong = this.lastPlaylistSong;

          fetch(this.Playlist.ShowPlaylistData.image)
            .then((response) => {
              if (response.status === 200) {
                this.LastPlaylistUrl = this.Playlist.ShowPlaylistData.image;
                this.lastPlaylistName = this.Playlist.ShowPlaylistData.title;
                this.lastPlaylistSong = this.Playlist.ShowPlaylistData.song;
                this.Playlist.EditButton = !this.Playlist.EditButton;

                const musicData = this.PlayerPlaylist;
                postNUI("MUSIC_VEHICLE", {
                  page: "CreatePlaylist",
                  musicData: musicData,
                });
              } else {
                this.LastPlaylistUrl = previousUrl;
                this.lastPlaylistName = previousName;
                this.lastPlaylistSong = previousSong;
                this.sendNotify(true, this.Locales["INCORRECTURL"]);
              }
            })
            .catch((error) => {
              this.LastPlaylistUrl = previousUrl;
              this.lastPlaylistName = previousName;
              this.lastPlaylistSong = previousSong;
              this.sendNotify(true, this.Locales["INCORRECTURL"]);
            });
        } else {
          this.sendNotify(true, this.Locales["MUSTTWOCHARACTER"]);
        }
      } else if (index == "RemoveMusic") {
        if (this.Playlist.ShowPlaylistData) {
          const songIndex = data;
          if (
            songIndex >= 0 &&
            songIndex < this.Playlist.ShowPlaylistData.song.length
          ) {
            this.Playlist.ShowPlaylistData.song.splice(songIndex, 1);
          }
          const musicData = this.PlayerPlaylist;
          postNUI("MUSIC_VEHICLE", {
            page: "CreatePlaylist",
            musicData: musicData,
          });
        }
      } else if (index == "Like") {
        if (this.Playlist.Playingsong) {
          this.Playlist.Playingsong.liked = !this.Playlist.Playingsong.liked;

          const newSong = {
            name: this.Playlist.Playingsong.name,
            artistname: this.Playlist.Playingsong.artistname,
            url: this.Playlist.Playingsong.url,
            kapakPictures: this.Playlist.Playingsong.kapakPictures,
            songimage: this.Playlist.Playingsong.songimage,
            image: this.Playlist.Playingsong.image,
            liked: this.Playlist.Playingsong.liked,
          };

          const likedSongsPlaylist = this.PlayerPlaylist.find(
            (playlist) => playlist.title === "Liked Songs"
          );

          if (likedSongsPlaylist) {
            if (this.Playlist.Playingsong.liked) {
              likedSongsPlaylist.song.push(newSong);
            } else {
              const songIndex = likedSongsPlaylist.song.findIndex(
                (song) => song.url === this.Playlist.Playingsong.url
              );
              if (songIndex !== -1) {
                likedSongsPlaylist.song.splice(songIndex, 1);
              }
            }
          }
          const musicData = this.PlayerPlaylist;
          postNUI("MUSIC_VEHICLE", {
            page: "CreatePlaylist",
            musicData: musicData,
          });
        }
      } else if (index == "addMusic") {
        const newSong = {
          name: this.Playlist.Playingsong.name,
          artistname: this.Playlist.Playingsong.artistname,
          url: this.Playlist.Playingsong.url,
          kapakPictures: this.Playlist.Playingsong.kapakPictures,
          songimage: this.Playlist.Playingsong.songimage,
          image: this.Playlist.Playingsong.image,
          liked: this.Playlist.Playingsong.liked,
        };
        this.PlayerPlaylist.forEach((playlist) => {
          if (playlist.title === data) {
            if (
              playlist.image ==
              "https://www.afrocharts.com/images/song_cover.png"
            ) {
              playlist.image = this.Playlist.Playingsong.image;
            }
            playlist.song.push(newSong);
          }
          const musicData = this.PlayerPlaylist;
          postNUI("MUSIC_VEHICLE", {
            page: "CreatePlaylist",
            musicData: musicData,
          });
        });
      } else if (index == "PlayMusic") {
        if (this.Playlist.OtherPlayer == true) {
          this.Playlist.PauseMusic = false;
          postNUI("MUSIC_VEHICLE", {
            page: "PlayMusic",
            url: this.Playlist.SongURLvmodel,
            musicOwner: this.Playlist.OtherPlayerID,
          });
        } else {
          this.Playlist.PauseMusic = false;
          $.getJSON(
            "https://noembed.com/embed?url=",
            { format: "json", url: this.Playlist.SongURLvmodel },
            (data) => {
              this.Playlist.SongURLvmodel = "Song URL...";

              this.Playlist.Playingsong.url = data.url;
              const likedSongsPlaylist = this.PlayerPlaylist.find(
                (playlist) => playlist.title === "Liked Songs"
              );

              if (likedSongsPlaylist) {
                const isLiked = likedSongsPlaylist.song.some(
                  (song) => song.url === this.Playlist.Playingsong.url
                );
                this.Playlist.Playingsong.liked = isLiked;
              }

              if (!this.SpotifyImage) {
                this.Playlist.Playingsong.name = data.title;
                this.Playlist.Playingsong.artistname = data.author_name;
                this.Playlist.Playingsong.kapakPictures = data.thumbnail_url;
                this.Playlist.Playingsong.songimage = data.thumbnail_url;
                this.Playlist.Playingsong.image = data.thumbnail_url;
                this.Playlist.Playingsong.playing = true;

                localStorage.setItem(
                  "playlistUrl",
                  this.Playlist.Playingsong.url
                );
                localStorage.setItem(
                  "playlistName",
                  this.Playlist.Playingsong.name
                );
                localStorage.setItem(
                  "playlistArtistname",
                  this.Playlist.Playingsong.artistname
                );
                localStorage.setItem(
                  "playlistKapakPictures",
                  this.Playlist.Playingsong.kapakPictures
                );
                localStorage.setItem(
                  "playlistSongimage",
                  this.Playlist.Playingsong.songimage
                );
                localStorage.setItem(
                  "playlistImage",
                  this.Playlist.Playingsong.image
                );
                localStorage.setItem(
                  "playlistLiked",
                  this.Playlist.Playingsong.liked
                );
              }

              postNUI("MUSIC_VEHICLE", {
                page: "PlayMusic",
                url: this.Playlist.Playingsong.url,
              }),
                this.getSpotifyCover(data.title + " " + data.author_name);
            }
          );
        }
      } else if (index == "CreatePlaylist") {
        let isDuplicate = false;
        this.PlayerPlaylist.forEach((playlist) => {
          if (playlist.title === this.Playlist.NewPlaylistName) {
            isDuplicate = true;
            this.sendNotify(true, this.Locales["REPEATEDNAME"]);
          }
        });

        if (!isDuplicate) {
          const newPlaylist = {
            title: this.Playlist.NewPlaylistName,
            song: [],
            image: "https://www.afrocharts.com/images/song_cover.png",
            kapakPictures: null,
            BigPictures: null,
            playing: false,
          };
          this.PlayerPlaylist.push(newPlaylist);
          this.Playlist.NewPlaylistName = "Playlist Name";
          this.NewCreatePlaylist = !this.NewCreatePlaylist;
          const musicData = this.PlayerPlaylist;
          postNUI("MUSIC_VEHICLE", {
            page: "CreatePlaylist",
            musicData: musicData,
          });
        }
      } else if (index == "AddPlaylistSucces") {
        if (this.Playlist.DeletePlaylistSucces) {
          this.sendNotify(true, this.Locales["DISABLEBTN"]);
        } else {
          this.Playlist.AddPlaylistSucces = !this.Playlist.AddPlaylistSucces;
        }
      } else if (index == "DeletePlaylistSucces") {
        if (this.Playlist.AddPlaylistSucces) {
          this.sendNotify(true, this.Locales["DISABLEBTN"]);
        } else {
          this.Playlist.DeletePlaylistSucces =
            !this.Playlist.DeletePlaylistSucces;
        }
      } else if (index == "RemovePlaylist") {
        const playingSongUrl = this.Playlist.Playingsong.url;
        const playlist = this.PlayerPlaylist.find(
          (item) => item.title === data.title
        );

        for (const song of playlist.song) {
          if (song.url === playingSongUrl) {
            this.PlayerPlaylist.forEach((playlist) => {
              playlist.playing = false;
              playlist.song.forEach((song) => {
                song.playing = false;
              });
            });
            this.Playlist.PauseMusic = true;
            postNUI("MUSIC_VEHICLE", {
              page: "PauseMusic",
            });
          }
        }
        const indexToRemove = this.PlayerPlaylist.findIndex((playlist) => {
          return playlist.title === data.title;
        });

        if (indexToRemove !== -1) {
          this.PlayerPlaylist.splice(indexToRemove, 1);
          this.sendNotify(true, "Playlist named " + data.title + " DELETED");
        } else {
          this.sendNotify(true, this.Locales["PLAYLISTNOTFOUND"]);
        }

        this.PlayerPlaylist.forEach((playlist) => {
          playlist.playing = false;
          playlist.song.forEach((song) => {
            if (song.url === this.Playlist.Playingsong.url) {
              song.playing = true;
              playlist.playing = true;
              this.currentPlaylist = playlist;
              found = true;
            } else {
              song.playing = false;
            }
          });
        });
        const musicData = this.PlayerPlaylist;
        postNUI("MUSIC_VEHICLE", {
          page: "CreatePlaylist",
          musicData: musicData,
        });
      } else if (index == "PauseMusic") {
        if (this.Playlist.OtherPlayer == true) {
          this.Playlist.PauseMusic = true;
          postNUI("MUSIC_VEHICLE", {
            page: "PauseMusic",
            musicOwner: this.Playlist.OtherPlayerID,
          });
        } else {
          this.PlayerPlaylist.forEach((playlist) => {
            playlist.playing = false;
            playlist.song.forEach((song) => {
              song.playing = false;
            });
          });
          this.Playlist.PauseMusic = true;
          postNUI("MUSIC_VEHICLE", {
            page: "PauseMusic",
          });
        }
      } else if (index == "ResumeMusic") {
        if (this.Playlist.OtherPlayer == true) {
          this.Playlist.PauseMusic = false;
          postNUI("MUSIC_VEHICLE", {
            page: "ResumeMusic",
            musicOwner: this.Playlist.OtherPlayerID,
          });
        } else {
          this.Playlist.PauseMusic = false;
          postNUI("MUSIC_VEHICLE", {
            page: "ResumeMusic",
          });
          this.PlayerPlaylist.forEach((playlist) => {
            playlist.playing = false;
            playlist.song.forEach((song) => {
              if (song.url === this.Playlist.Playingsong.url) {
                song.playing = true;
                playlist.playing = true;
                this.currentPlaylist = playlist;
                found = true;
              } else {
                song.playing = false;
              }
            });
          });
        }
      } else if (index == "ClickMusicandPlay") {
        if (this.Playlist.OtherPlayer == true) {
          this.Playlist.PauseMusic = false;
          let found = false;
          this.PlayerPlaylist.forEach((playlist) => {
            playlist.playing = false;
            playlist.song.forEach((song) => {
              if (song.url === data.url) {
                song.playing = true;
                playlist.playing = true;
                this.currentPlaylist = playlist;
                found = true;
              } else {
                song.playing = false;
              }
            });
          });

          if (!found) {
            this.sendNotify(true, this.Locales["SOUNDNOTFOUND"]);
          }
          this.Playlist.Playingsong.url = data.url;
          this.Playlist.Playingsong.name = data.name;
          this.Playlist.Playingsong.artistname = data.artistname;
          this.Playlist.Playingsong.kapakPictures = data.kapakPictures;
          this.Playlist.Playingsong.songimage = data.songimage;
          this.Playlist.Playingsong.image = data.image;
          this.Playlist.Playingsong.liked = data.liked;
          this.Playlist.Playingsong.playing = true;

          localStorage.setItem("playlistUrl", this.Playlist.Playingsong.url);
          localStorage.setItem("playlistName", this.Playlist.Playingsong.name);
          localStorage.setItem(
            "playlistArtistname",
            this.Playlist.Playingsong.artistname
          );
          localStorage.setItem(
            "playlistKapakPictures",
            this.Playlist.Playingsong.kapakPictures
          );
          localStorage.setItem(
            "playlistSongimage",
            this.Playlist.Playingsong.songimage
          );
          localStorage.setItem(
            "playlistImage",
            this.Playlist.Playingsong.image
          );
          localStorage.setItem(
            "playlistLiked",
            this.Playlist.Playingsong.liked
          );
          postNUI("MUSIC_VEHICLE", {
            page: "PlayMusic",
            url: this.Playlist.Playingsong.url,
            musicOwner: this.Playlist.OtherPlayerID,
          });
        } else {
          this.Playlist.PauseMusic = false;
          let found = false;
          this.PlayerPlaylist.forEach((playlist) => {
            playlist.playing = false;
            playlist.song.forEach((song) => {
              if (song.url === data.url) {
                song.playing = true;
                playlist.playing = true;
                this.currentPlaylist = playlist;
                this.ShowPlaylistData = playlist;
                found = true;
              } else {
                song.playing = false;
              }
            });
          });

          if (!found) {
            this.sendNotify(true, this.Locales["SOUNDNOTFOUND"]);
          }

          this.Playlist.Playingsong.url = data.url;
          this.Playlist.Playingsong.name = data.name;
          this.Playlist.Playingsong.artistname = data.artistname;
          this.Playlist.Playingsong.kapakPictures = data.kapakPictures;
          this.Playlist.Playingsong.songimage = data.songimage;
          this.Playlist.Playingsong.image = data.image;
          this.Playlist.Playingsong.liked = data.liked;
          this.Playlist.Playingsong.playing = true;

          localStorage.setItem("playlistUrl", this.Playlist.Playingsong.url);
          localStorage.setItem("playlistName", this.Playlist.Playingsong.name);
          localStorage.setItem(
            "playlistArtistname",
            this.Playlist.Playingsong.artistname
          );
          localStorage.setItem(
            "playlistKapakPictures",
            this.Playlist.Playingsong.kapakPictures
          );
          localStorage.setItem(
            "playlistSongimage",
            this.Playlist.Playingsong.songimage
          );
          localStorage.setItem(
            "playlistImage",
            this.Playlist.Playingsong.image
          );
          localStorage.setItem(
            "playlistLiked",
            this.Playlist.Playingsong.liked
          );
          postNUI("MUSIC_VEHICLE", {
            page: "PlayMusic",
            url: this.Playlist.Playingsong.url,
          });
        }
      } else if (index == "backMusic") {
        let found = false;
        this.PlayerPlaylist.forEach((playlist) => {
          playlist.playing = false;
          playlist.song.forEach((song) => {
            if (song.url === this.Playlist.Playingsong.url) {
              this.currentPlaylist = playlist;
              found = true;
            }
          });
        });
        const currentIndex = this.currentPlaylist.song.findIndex(
          (song) => song.playing
        );
        if (currentIndex > 0) {
          this.setPlayingSong(this.currentPlaylist.song[currentIndex - 1]);
        } else {
          this.Playlist.PauseMusic = true;
          postNUI("MUSIC_VEHICLE", {
            page: "PauseMusic",
            musicOwner: false,
            stop: true,
          });
          postNUI("THE_END");
        }
      } else if (index == "nextMusic") {
        let found = false;

        this.PlayerPlaylist.forEach((playlist) => {
          playlist.playing = false;
          playlist.song.forEach((song) => {
            if (song.url === this.Playlist.Playingsong.url) {
              this.currentPlaylist = playlist;
              found = true;
            }
          });
        });
        if (found) {
          const currentIndex = this.currentPlaylist.song.findIndex(
            (song) => song.playing
          );
          if (
            currentIndex >= 0 &&
            currentIndex < this.currentPlaylist.song.length - 1
          ) {
            this.setPlayingSong(this.currentPlaylist.song[currentIndex + 1]);
          } else {
            this.Playlist.PauseMusic = true;
            postNUI("MUSIC_VEHICLE", {
              page: "PauseMusic",
              musicOwner: false,
            });
          }
        }
      }
    },
    setPlayingSong(data) {
      this.Playlist.PauseMusic = false;
      let found = false;
      this.PlayerPlaylist.forEach((playlist) => {
        playlist.playing = false;
        playlist.song.forEach((song) => {
          if (song.url === data.url) {
            song.playing = true;
            playlist.playing = true;
            this.currentPlaylist = playlist;
            found = true;
          } else {
            song.playing = false;
          }
        });
      });

      if (!found) {
        this.sendNotify(true, this.Locales["SOUNDNOTFOUND"]);
      }

      this.Playlist.Playingsong.url = data.url;
      this.Playlist.Playingsong.name = data.name;
      this.Playlist.Playingsong.artistname = data.artistname;
      this.Playlist.Playingsong.kapakPictures = data.kapakPictures;
      this.Playlist.Playingsong.songimage = data.songimage;
      this.Playlist.Playingsong.image = data.image;
      this.Playlist.Playingsong.liked = data.liked;
      this.Playlist.Playingsong.playing = true;

      localStorage.setItem("playlistUrl", this.Playlist.Playingsong.url);
      localStorage.setItem("playlistName", this.Playlist.Playingsong.name);
      localStorage.setItem(
        "playlistArtistname",
        this.Playlist.Playingsong.artistname
      );
      localStorage.setItem(
        "playlistKapakPictures",
        this.Playlist.Playingsong.kapakPictures
      );
      localStorage.setItem(
        "playlistSongimage",
        this.Playlist.Playingsong.songimage
      );
      localStorage.setItem("playlistImage", this.Playlist.Playingsong.image);
      localStorage.setItem("playlistLiked", this.Playlist.Playingsong.liked);
      postNUI("MUSIC_VEHICLE", {
        page: "endsoundNextMusic",
        url: this.Playlist.Playingsong.url,
        musicOwner: false,
      });
    },
    async getSpotifyCover(data) {
      try {
        if (this.SpotifyImage) {
          const clientId = this.clientId;
          const clientSecret = this.clientSecret;
          const authResponse = await fetch(
            "https://accounts.spotify.com/api/token",
            {
              method: "POST",
              headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                Authorization: "Basic " + btoa(clientId + ":" + clientSecret),
              },
              body: "grant_type=client_credentials",
            }
          );

          const authData = await authResponse.json();
          const accessToken = authData.access_token;
          const searchResponse = await fetch(
            `https://api.spotify.com/v1/search?q=${encodeURIComponent(
              data
            )}&type=track&limit=1`,
            {
              headers: {
                Authorization: "Bearer " + accessToken,
              },
            }
          );

          const searchData = await searchResponse.json();

          if (searchData.tracks.items.length === 0) {
            return;
          }

          const firstTrack = searchData.tracks.items[0];
          this.Playlist.Playingsong.name = firstTrack.name;
          this.Playlist.Playingsong.artistname = firstTrack.artists[0].name;
          this.Playlist.Playingsong.kapakPictures =
            firstTrack.album.images[0].url;
          this.Playlist.Playingsong.songimage = firstTrack.album.images[1].url;
          this.Playlist.Playingsong.image = firstTrack.album.images[2].url;
          this.Playlist.Playingsong.playing = true;

          localStorage.setItem("playlistUrl", this.Playlist.Playingsong.url);
          localStorage.setItem("playlistName", this.Playlist.Playingsong.name);
          localStorage.setItem(
            "playlistArtistname",
            this.Playlist.Playingsong.artistname
          );
          localStorage.setItem(
            "playlistKapakPictures",
            this.Playlist.Playingsong.kapakPictures
          );
          localStorage.setItem(
            "playlistSongimage",
            this.Playlist.Playingsong.songimage
          );
          localStorage.setItem(
            "playlistImage",
            this.Playlist.Playingsong.image
          );
          localStorage.setItem(
            "playlistLiked",
            this.Playlist.Playingsong.liked
          );
        }
      } catch (error) {
        // Şarkı bulunmadı
      }
    },
    IsSongInPlaylist(dataname) {
      const playingSongUrl = this.Playlist.Playingsong.url;
      const playlist = this.PlayerPlaylist.find(
        (item) => item.title === dataname
      );

      if (!playlist) {
        return true;
      }

      for (const song of playlist.song) {
        if (song.url === playingSongUrl) {
          return false;
        }
      }

      if (dataname === "Liked Songs") {
        return false;
      }

      return true;
    },
    IsSongInPlaylistDelete(dataname) {
      const playingSongUrl = this.Playlist.Playingsong.url;
      const playlist = this.PlayerPlaylist.find(
        (item) => item.title === dataname
      );

      if (!playlist) {
        return true;
      }

      if (dataname === "Liked Songs") {
        return false;
      }

      return true;
    },
    onSongEnded() {
      this.ClickMusic("nextMusic");
    },
    watchSongProgress() {
      // if ( this.Playlist.Playingsong.currentTime == this.Playlist.Playingsong.maxDuration -3 )  {
      //     this.onSongEnded();
      // }
    },
    SetTimeStamp(e) {
      if (this.Playlist.OtherPlayer == true) {
        this.playAudio();
        if (
          this.Playlist.Playingsong.name &&
          this.Playlist.Playingsong.maxDuration > 0
        ) {
          const pos =
            (e.pageX - this.$refs.musicbar.getClientRects()[0].x) /
            this.$refs.musicbar.getClientRects()[0].width;
          postNUI("MUSIC_VEHICLE", {
            page: "timestamp",
            payload: pos * this.Playlist.Playingsong.maxDuration,
            musicOwner: this.Playlist.OtherPlayerID,
          });
        }
      } else {
        this.playAudio();
        if (
          this.Playlist.Playingsong.name &&
          this.Playlist.Playingsong.maxDuration > 0
        ) {
          const pos =
            (e.pageX - this.$refs.musicbar.getClientRects()[0].x) /
            this.$refs.musicbar.getClientRects()[0].width;

          postNUI("MUSIC_VEHICLE", {
            page: "timestamp",
            payload: pos * this.Playlist.Playingsong.maxDuration,
          });
        }
      }
    },

    toMMSS(val) {
      var sec_num = parseInt(val, 10);
      var hours = Math.floor(sec_num / 3600);
      var minutes = Math.floor((sec_num - hours * 3600) / 60);
      var seconds = sec_num - hours * 3600 - minutes * 60;

      if (hours < 10) {
        hours = "0" + hours;
      }
      if (minutes < 10) {
        minutes = "0" + minutes;
      }
      if (seconds < 10) {
        seconds = "0" + seconds;
      }
      return minutes + ":" + seconds;
    },
    OtherPlayerPlaying(clientData) {
      this.Playlist.PauseMusic = clientData.paused;
      this.Playlist.Playingsong.currentTime = clientData.currentTime;
      this.Playlist.Playingsong.maxDuration = clientData.maxDuration;
      $.getJSON(
        "https://noembed.com/embed?url=",
        { format: "json", url: clientData.url },
        (data) => {
          this.Playlist.Playingsong.url = data.url;
          const likedSongsPlaylist = this.PlayerPlaylist.find(
            (playlist) => playlist.title === "Liked Songs"
          );

          if (likedSongsPlaylist) {
            const isLiked = likedSongsPlaylist.song.some(
              (song) => song.url === this.Playlist.Playingsong.url
            );
            this.Playlist.Playingsong.liked = isLiked;
          }

          this.PlayerPlaylist.forEach((playlist) => {
            playlist.playing = false;
            playlist.song.forEach((song) => {
              if (song.url === this.Playlist.Playingsong.url) {
                song.playing = true;
                playlist.playing = true;
                this.currentPlaylist = playlist;
                found = true;
              } else {
                song.playing = false;
              }
            });
          });
          if (!this.SpotifyImage) {
            this.Playlist.Playingsong.name = data.title;
            this.Playlist.Playingsong.artistname = data.author_name;
            this.Playlist.Playingsong.kapakPictures = data.thumbnail_url;
            this.Playlist.Playingsong.songimage = data.thumbnail_url;
            this.Playlist.Playingsong.image = data.thumbnail_url;
            this.Playlist.Playingsong.playing = true;

            localStorage.setItem("playlistUrl", this.Playlist.Playingsong.url);
            localStorage.setItem(
              "playlistName",
              this.Playlist.Playingsong.name
            );
            localStorage.setItem(
              "playlistArtistname",
              this.Playlist.Playingsong.artistname
            );
            localStorage.setItem(
              "playlistKapakPictures",
              this.Playlist.Playingsong.kapakPictures
            );
            localStorage.setItem(
              "playlistSongimage",
              this.Playlist.Playingsong.songimage
            );
            localStorage.setItem(
              "playlistImage",
              this.Playlist.Playingsong.image
            );
            localStorage.setItem(
              "playlistLiked",
              this.Playlist.Playingsong.liked
            );
          }
          this.getSpotifyCover(data.title + " " + data.author_name);
        }
      );
    },
    PlayerPlayingEqualtle(otherData, otherUrl) {
      if (otherData == "PauseMusic") {
        this.PlayerPlaylist.forEach((playlist) => {
          playlist.playing = false;
          playlist.song.forEach((song) => {
            song.playing = false;
          });
        });
        this.Playlist.PauseMusic = true;
      } else if (otherData == "ResumeMusic") {
        this.Playlist.PauseMusic = false;
        this.PlayerPlaylist.forEach((playlist) => {
          playlist.playing = false;
          playlist.song.forEach((song) => {
            if (song.url === this.Playlist.Playingsong.url) {
              song.playing = true;
              playlist.playing = true;
              this.currentPlaylist = playlist;
              found = true;
            } else {
              song.playing = false;
            }
          });
        });
      } else if (otherData == "PlayMusic") {
        this.Playlist.PauseMusic = false;
        this.Playlist.Playingsong.url = otherUrl;
        $.getJSON(
          "https://noembed.com/embed?url=",
          { format: "json", url: this.Playlist.Playingsong.url },
          (data) => {
            this.Playlist.SongURLvmodel = "Song URL...";

            this.PlayerPlaylist.forEach((playlist) => {
              playlist.playing = false;
              playlist.song.forEach((song) => {
                if (song.url === this.Playlist.Playingsong.url) {
                  song.playing = true;
                  playlist.playing = true;
                  this.currentPlaylist = playlist;
                  found = true;
                } else {
                  song.playing = false;
                }
              });
            });

            this.Playlist.Playingsong.url = otherUrl;
            const likedSongsPlaylist = this.PlayerPlaylist.find(
              (playlist) => playlist.title === "Liked Songs"
            );

            if (likedSongsPlaylist) {
              const isLiked = likedSongsPlaylist.song.some(
                (song) => song.url === this.Playlist.Playingsong.url
              );
              this.Playlist.Playingsong.liked = isLiked;
            }
            postNUI("MUSIC_VEHICLE", {
              page: "PlayMusic",
              url: this.Playlist.Playingsong.url,
            });
            if (!this.SpotifyImage) {
              this.Playlist.Playingsong.name = data.title;
              this.Playlist.Playingsong.artistname = data.author_name;
              this.Playlist.Playingsong.kapakPictures = data.thumbnail_url;
              this.Playlist.Playingsong.songimage = data.thumbnail_url;
              this.Playlist.Playingsong.image = data.thumbnail_url;
              this.Playlist.Playingsong.playing = true;

              localStorage.setItem(
                "playlistUrl",
                this.Playlist.Playingsong.url
              );
              localStorage.setItem(
                "playlistName",
                this.Playlist.Playingsong.name
              );
              localStorage.setItem(
                "playlistArtistname",
                this.Playlist.Playingsong.artistname
              );
              localStorage.setItem(
                "playlistKapakPictures",
                this.Playlist.Playingsong.kapakPictures
              );
              localStorage.setItem(
                "playlistSongimage",
                this.Playlist.Playingsong.songimage
              );
              localStorage.setItem(
                "playlistImage",
                this.Playlist.Playingsong.image
              );
              localStorage.setItem(
                "playlistLiked",
                this.Playlist.Playingsong.liked
              );
            }

            this.getSpotifyCover(data.title + " " + data.author_name);
          }
        );
      }
    },
    SettingPage(index) {
      this.playAudio();
      if (index == "restore") {
        this.playAudio();
        this.carPlayPosition.left = null;
        this.carPlayPosition.top = null;
        const defaultPosition = {
          left: null,
          top: null,
        };
        localStorage.setItem("CarPlayPoss", JSON.stringify(defaultPosition));
      } else if (index == "move") {
      } else if (index == "save") {
        this.screenSize = parseInt(this.screenSize);
        localStorage.setItem("screenSize", this.screenSize);
        this.playAudio();
      }
    },
    ThemeChange(mode) {
      this.playAudio();
      this.time = mode;

      if (mode == "dinamik") {
        localStorage.setItem("vmodelScreen", "dinamik");
      } else {
        localStorage.setItem("ScreenMode", this.time);
        localStorage.setItem("vmodelScreen", mode);
      }
    },
    updateCurrentTime() {
      const now = new Date();
      const day = now.getDate();
      const month = now.toLocaleString("default", { month: "long" });
      const hours = String(now.getHours()).padStart(2, "0");
      const minutes = String(now.getMinutes()).padStart(2, "0");
      this.currentTime = `${day} ${month} ${hours}:${minutes}`;
    },
    SoundChange(bool) {
      this.playAudio();
      if (bool == 1) {
        if (this.playerdata.soundlevel <= 95) {
          this.playerdata.soundlevel = this.playerdata.soundlevel + 5;
        } else {
          this.playerdata.soundlevel = 95;
        }
      } else {
        if (this.playerdata.soundlevel >= 5) {
          this.playerdata.soundlevel = this.playerdata.soundlevel - 5;
        } else {
          this.playerdata.soundlevel = 5;
        }
      }
      if (this.Playlist.OtherPlayer) {
        postNUI("MUSIC_VEHICLE", {
          page: "SoundLevel",
          volume: this.playerdata.soundlevel,
          musicOwner: this.Playlist.OtherPlayerID,
        });
      } else {
        postNUI("MUSIC_VEHICLE", {
          page: "SoundLevel",
          volume: this.playerdata.soundlevel,
        });
        localStorage.setItem("soundlevel", this.playerdata.soundlevel);
      }
    },
    SetTimeStampSound(e) {
      if (this.Playlist.OtherPlayer == true) {
        this.playAudio();
        if (
          this.Playlist.Playingsong.name &&
          this.Playlist.Playingsong.maxDuration > 0
        ) {
          const soundlevelbar = this.$refs.soundlevelbar;
          if (soundlevelbar) {
            const rect = soundlevelbar.getBoundingClientRect();
            const pos = (e.pageX - rect.left) / rect.width;
            this.playerdata.soundlevel = pos * 100;
            postNUI("MUSIC_VEHICLE", {
              page: "SoundLevel",
              volume: this.playerdata.soundlevel,
              musicOwner: this.Playlist.OtherPlayerID,
            });
          }
        }
      } else {
        this.playAudio();
        if (
          this.Playlist.Playingsong.name &&
          this.Playlist.Playingsong.maxDuration > 0
        ) {
          const soundlevelbar = this.$refs.soundlevelbar;
          if (soundlevelbar) {
            const rect = soundlevelbar.getBoundingClientRect();
            const pos = (e.pageX - rect.left) / rect.width;
            this.playerdata.soundlevel = pos * 100;
            postNUI("MUSIC_VEHICLE", {
              page: "SoundLevel",
              volume: this.playerdata.soundlevel,
            });
          }
        }
        localStorage.setItem("soundlevel", this.playerdata.soundlevel);
      }
      localStorage.setItem("soundlevel", this.playerdata.soundlevel);
    },
    soundOpenStorage() {
      localStorage.setItem("soundOpen", JSON.stringify(this.soundOpen));
    },
    setMenuBackground() {
      this.playAudio();
      this.menuBackGround = !this.menuBackGround;
      localStorage.setItem("menuBackGround", this.menuBackGround);
    },
    SetpassengerAccess() {
      localStorage.setItem("passengerAccess", this.passengerAccess);
      this.playAudio();
      postNUI("SETTING_VEHICLE", {
        page: "passengerAccess",
        passengerAccess: this.passengerAccess,
      });
    },

    setMiniShow() {
      this.playAudio();

      localStorage.setItem("minishow", this.minishow);
    },
    AutoPilotStart() {
      this.playAudio();
      if (this.Playlist.OtherPlayer) {
        this.playAudio();
        this.sendNotify(true, this.Locales["ONLYDRIVER"]);
      } else {
        this.VehicleData.autoPilotStatus = !this.VehicleData.autoPilotStatus;
        postNUI("AUTO_PILOT_START", {
          status: this.VehicleData.autoPilotStatus,
        });
      }
    },
    OnChangeColor(e) {
      let dataType = e.target.getAttribute("data-type");
      if (dataType == "neon") {
        this.VehicleData.neon.color = hexToRgb(e.target.value);
        postNUI("EDIT_VEHICLE", {
          page: "NeonColor",
          i: this.VehicleData.neon.color,
          rgb: true,
        });
      }
    },
    OpenUI() {
      if (this.Show) {
        this.Show = false;
        postNUI("CLOSE_TABLET");
      } else {
        postNUI("OPEN_TABLET");
      }
      this.playAudio();
    },
    onKeyUp(event) {
      if (event.key === "Escape") {
        this.Show = false;
        postNUI("CLOSE_TABLET");
      }
    },
  },
  computed: {
    getCarPlayPosition() {
      if (this.carPlayPosition.left) {
        return {
          position: this.carPlayPosition.left ? "absolute" : "static",
          left: this.carPlayPosition.left + "px",
          top: this.carPlayPosition.top + "px",
        };
      } else {
        return;
      }
    },
    speedStyle() {
      if (this.VehicleData.speed.length === 3) {
        return {
          fontSize: "1.5vw",
        };
      }

      if (this.VehicleData.speed.length === 4) {
        return {
          fontSize: "1.3vw",
        };
      }
      return {};
    },

    openColoris: function () {
      if (this.VehicleData.NeonBool) {
        Coloris({
          theme: "polaroid",
          themeMode: "dark",
          alpha: false,
          formatToggle: false,
        });
      }
    },
  },

  watch: {},

  beforeDestroy() {
    if (this.Playlist.timer) {
      clearTimeout(this.Playlist.timer);
    }

    if (this.notifyData.bool) {
      setTimeout(() => {
        this.notifyData.bool = false;
        this.notifyData.text = "Notification";
      }, 5000);
    }
    if (this.VehicleData.LeftSignal) {
      setTimeout(() => {
        this.VehicleData.LeftSignal = false;
      }, 1000);
    }
    window.removeEventListener("keyup", this.onKeyUp);
  },

  mounted() {
    (this.minishow = localStorage.getItem("minishow") || false),
      this.MakeElementDraggable(".dragItem");
    if (this.notifyData.bool) {
      setTimeout(() => {
        this.notifyData.bool = false;
        this.notifyData.text = "Notification";
      }, 5000);
    }
    this.watchSongProgress();
    const savedValue = localStorage.getItem("soundOpen");
    if (savedValue !== null) {
      this.soundOpen = JSON.parse(savedValue);
    }
    const savedPosValue = localStorage.getItem("CarPlayPoss");
    if (savedPosValue !== null) {
      this.carPlayPosition = JSON.parse(savedPosValue);
    } else {
      const defaultPosition = {
        left: null,
        top: null,
      };
      localStorage.setItem("CarPlayPoss", JSON.stringify(defaultPosition));
    }

    this.updateCurrentTime();
    this.timer = setInterval(this.updateCurrentTime, 60000);
    window.addEventListener("message", (event) => {
      window.addEventListener("keyup", this.onKeyUp);
      switch (event.data.message) {
        case "OPEN_CARPLAY":
          this.CurrentPageData["DefaultApp"] = true;
          this.CurrentPageData["AutoPilotApp"] = false;
          this.CurrentPageData["DoorApp"] = false;
          this.CurrentPageData["NeonApp"] = false;
          this.CurrentPageData["MusicApp"] = false;
          this.CurrentPageData["KonumApp"] = false;
          this.CurrentPageData["SettingsApp"] = false;

          this.Show = true;
          this.VehicleData.gearN = event.data.VehicleData.gearN;
          this.VehicleData.gear = event.data.VehicleData.gear;
          this.VehicleData.speed = event.data.VehicleData.speed;
          this.VehicleData.fuel = event.data.VehicleData.fuel;
          this.VehicleData.nosLevel = event.data.VehicleData.nosLevel;
          this.VehicleData.broken = !event.data.VehicleData.broken;
          this.VehicleData.light = event.data.VehicleData.light;
          this.VehicleData.belt = event.data.VehicleData.belt;
          this.VehicleData.NeonBool = event.data.VehicleData.NeonBool;
          this.VehicleData.LeftSignal = event.data.VehicleData.LeftSignal;
          this.VehicleData.RightSignal = event.data.VehicleData.RightSignal;
          this.VehicleData.LongLight = event.data.VehicleData.LongLight;
          this.VehicleData.ShortLight = event.data.VehicleData.ShortLight;
          this.VehicleData.doors = event.data.VehicleData.doors;
          this.VehicleData.windows = event.data.VehicleData.windows;
          this.VehicleData.Zone = event.data.VehicleData.Zone;
          this.VehicleData.Street = event.data.VehicleData.Street;
          this.Locales = event.data.Locales;
          this.Playlist.OtherPlayer = false;
          this.Playlist.OtherPlayerID = null;

          if (this.SecilenMode == "dinamik") {
            this.time = event.data.SetsecilenMode;
          }
          this.SpotifyImage = event.data.SpotifyImage;

          if (this.SpotifyImage == true) {
            this.clientId = event.data.SpotifyClientID;
            this.clientSecret = event.data.SpotifyClientSecret;
          }
          this.playerdata.name = event.data.playerdata.name;
          this.playerdata.avatar =
            event.data.playerdata.avatar || "./img/profilepicture.png";
          if (event.data.musicData) {
            this.PlayerPlaylist = JSON.parse(event.data.musicData);
          }

          postNUI("SETTING_VEHICLE", {
            page: "passengerAccess",
            passengerAccess: this.passengerAccess,
            soundlevel: this.playerdata.soundlevel,
          });
          break;
        case "CLOSE_CARPLAY":
          this.Show = false;
          break;
        case "CANCEL_AUTO_PILOT":
          this.VehicleData.autoPilotStatus = false;
          break;
        case "STOP_AUTO_PILOT":
          this.VehicleData.autoPilotStatus = false;
          this.sendNotify(true, this.Locales["JSAUTO"]);
          break;
        case "OPEN_CARPLAY_OTHER":
          this.CurrentPageData["DefaultApp"] = true;
          this.CurrentPageData["AutoPilotApp"] = false;
          this.CurrentPageData["DoorApp"] = false;
          this.CurrentPageData["NeonApp"] = false;
          this.CurrentPageData["MusicApp"] = false;
          this.CurrentPageData["KonumApp"] = false;
          this.CurrentPageData["SettingsApp"] = false;
          this.Show = true;
          this.VehicleData.gearN = event.data.VehicleData.gearN;
          this.VehicleData.gear = event.data.VehicleData.gear;
          this.VehicleData.speed = event.data.VehicleData.speed;
          this.VehicleData.fuel = event.data.VehicleData.fuel;
          this.VehicleData.nosLevel = event.data.VehicleData.nosLevel;
          this.VehicleData.broken = !event.data.VehicleData.broken;
          this.VehicleData.light = event.data.VehicleData.light;
          this.VehicleData.belt = event.data.VehicleData.belt;
          this.VehicleData.NeonBool = event.data.VehicleData.NeonBool;
          this.VehicleData.LeftSignal = event.data.VehicleData.LeftSignal;
          this.VehicleData.RightSignal = event.data.VehicleData.RightSignal;
          this.VehicleData.Brake = event.data.VehicleData.Brake;
          this.VehicleData.LongLight = event.data.VehicleData.LongLight;
          this.VehicleData.ShortLight = event.data.VehicleData.ShortLight;
          this.VehicleData.doors = event.data.VehicleData.doors;
          this.VehicleData.windows = event.data.VehicleData.windows;
          this.VehicleData.Zone = event.data.VehicleData.Zone;
          this.VehicleData.Street = event.data.VehicleData.Street;
          this.Locales = event.data.Locales;
          this.Playlist.OtherPlayer = false;
          this.Playlist.OtherPlayerID = null;
          this.SpotifyImage = event.data.SpotifyImage;
          this.playerdata.name = event.data.playerdata.name;

          if (this.SecilenMode == "dinamik") {
            this.time = event.data.SetsecilenMode;
          }

          if (this.SpotifyImage == true) {
            this.clientId = event.data.SpotifyClientID;
            this.clientSecret = event.data.SpotifyClientSecret;
          }

          this.playerdata.avatar =
            event.data.playerdata.avatar || "./img/profilepicture.png";
          if (event.data.musicData) {
            this.PlayerPlaylist = JSON.parse(event.data.musicData);
          }
          break;
        case "Change_Vehicle_Image":
          this.VehicleData.image = event.data.image;
          break;
        case "SET_MUSIC_DATA":
          this.Playlist.Playingsong.currentTime =
            event.data.musicData.currentTime;
          this.Playlist.Playingsong.maxDuration =
            event.data.musicData.maxDuration;
          this.Playlist.Playingsong.nextSong = event.data.nextSong;
          if (event.data.nextSong) {
            this.onSongEnded();
          }
          break;
        case "SET_MUSIC_DATA_OTHER":
          this.OtherPlayerPlaying(event.data.musicData);
          this.Playlist.OtherPlayerID = event.data.musicOwner;
          this.Playlist.OtherPlayer = true;
          break;
        case "SET_MUSIC_DATA_OTHERID":
          this.Playlist.OtherPlayerID = event.data.musicOwner;
          this.Playlist.OtherPlayer = true;
          break;
        case "SET_MUSIC_EQUALTLE":
          this.PlayerPlayingEqualtle(event.data.data, event.data.url);
          break;
        case "Change_Vehicle_Data":
          if (this.Show) {
            this.VehicleData.gearN = event.data.VehicleData.gearN;
            this.VehicleData.gear = event.data.VehicleData.gear;
            this.VehicleData.speed = event.data.VehicleData.speed;
            this.VehicleData.fuel = event.data.VehicleData.fuel;
            this.VehicleData.nosLevel = event.data.VehicleData.nosLevel;
            this.VehicleData.broken = !event.data.VehicleData.broken;
            this.VehicleData.light = event.data.VehicleData.light;
            this.VehicleData.belt = event.data.VehicleData.belt;
            this.VehicleData.NeonBool = event.data.VehicleData.NeonBool;
            this.VehicleData.LeftSignal = event.data.VehicleData.LeftSignal;
            this.VehicleData.RightSignal = event.data.VehicleData.RightSignal;
            this.VehicleData.Brake = event.data.VehicleData.Brake;
            this.VehicleData.ShortLight = event.data.VehicleData.ShortLight;
            this.VehicleData.LongLight = event.data.VehicleData.LongLight;
            this.VehicleData.doors = event.data.VehicleData.doors;
            this.VehicleData.windows = event.data.VehicleData.windows;
            this.VehicleData.Zone = event.data.VehicleData.Zone;
            this.VehicleData.Street = event.data.VehicleData.Street;
            if (this.SecilenMode == "dinamik") {
              this.time = event.data.SetsecilenMode;
            }
          }
          break;
        case "SET_PAUSE_DATA":
          this.Playlist.PauseMusic = true;
          this.PlayerPlaylist.forEach((playlist) => {
            playlist.playing = false;
            playlist.song.forEach((song) => {
              song.playing = false;
            });
          });
          break;
        case "SET_RESUME_DATA":
          this.Playlist.PauseMusic = false;
          this.PlayerPlaylist.forEach((playlist) => {
            playlist.playing = false;
            playlist.song.forEach((song) => {
              if (song.url === this.Playlist.Playingsong.url) {
                song.playing = true;
                playlist.playing = true;
                this.currentPlaylist = playlist;
                found = true;
              } else {
                song.playing = false;
              }
            });
          });
          break;
      }
    });
  },

  destroyed() {
    clearInterval(this.Playlist.timer);
  },
});

app.use(store).mount("#app");

const resourceName = window.GetParentResourceName
  ? window.GetParentResourceName()
  : "m-carplay";

window.postNUI = async (name, data) => {
  try {
    const response = await fetch(`https://${resourceName}/${name}`, {
      method: "POST",
      mode: "cors",
      cache: "no-cache",
      credentials: "same-origin",
      headers: {
        "Content-Type": "application/json",
      },
      redirect: "follow",
      referrerPolicy: "no-referrer",
      body: JSON.stringify(data),
    });
    return !response.ok ? null : response.json();
  } catch (error) {
    // console.log(error)
  }
};

function hexToRgb(hex) {
  hex = hex.replace(/^#/, "");

  // Parse r, g, b values
  let bigint = parseInt(hex, 16);
  let r = (bigint >> 16) & 255;
  let g = (bigint >> 8) & 255;
  let b = bigint & 255;

  return [r, g, b];
}
