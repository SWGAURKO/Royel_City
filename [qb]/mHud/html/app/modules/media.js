const module = {
  namespaced: true,
  state: {
    playlists: [],
    myPlaylists: [],
    SpotifyclientId:"",
    SpotifyclientSecret:"",
    currentPlaylist: {
      isMyPlaylist: false,
      currentMusicIndex: false,
      data: false,
    },
    currentSongInformations: {
      url: false,
      name: false,
      isPaused: false,
      volume: 0.1,
      coverUrl : false,
    },
  },
  mutations: {
    setSpotifyIds(state, payload){
      state.SpotifyclientId = payload.SpotifyclientId
      state.SpotifyclientSecret = payload.SpotifyclientSecret

    },
    setPlaylists(state, payload) {
      state.playlists = payload
    },
    setCurrentSongInformations(state, payload) {
      state.currentSongInformations[payload.type] = payload.value

    },
    setMyPlaylists(state, payload) {
      state.myPlaylists = payload
    },
    setCurrentPlaylist(state, payload) {
      state.currentPlaylist[payload.type] = payload.value
    },
  },
}

export default module