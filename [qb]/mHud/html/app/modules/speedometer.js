const module = {
    namespaced: true,
    state: {
        selectedSpeedometerSizeMode : 0,
    },
    mutations: {
        setSelectSpeedometerSizeMode(state, payload){
            state.selectedSpeedometerSizeMode = payload
        }
    },
}

export default module