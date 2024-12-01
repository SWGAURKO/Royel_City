import importTemplate from '../../../../utils/importTemplate.js'
import inlinesvg from '../../../../utils/inlineSvg.js'



const ElectricSpeedo = {
    data() {
        return {
            nitroValue:0,
            fuelProgress : false,
            nitroProgress:false,
            rpmProgress:false,

        }
    },
    props: ["speed", "cruise", "vehicleSignals", "abs", "fuel", "seatbeltEnabled", "vehicleLights", "engineStatus", "handbrake", "nitroneedle"],

    methods: {
        messageHandler(event) {
            switch (event.data.action) {
                case "SET_NITRO_VALUE":
                    this.nitroValue = event.data.payload
                    if (this.nosbar) {
                        this.nosbar.set(this.nitroValue, true)
                    }
                    break
                default:
                    break;
            }
        },
        
    },
    components: {
        inlinesvg,
    },
    computed: {
        ...Vuex.mapState({
            hudSettings: state => state.hud.hudSettings,
        }),
    },
    watch:{
        'fuel'(val){
            this.fuelProgress.animate(val/100)
        },
        'nitroValue'(val){
            this.nitroProgress.animate(val/100)
        },
        'speed.current'(val){
            // this.nitroProgress.animate(val/100)
            this.rpmProgress.animate(val/330)     

        },
    },
    mounted() {
        window.addEventListener('message', this.messageHandler);
        if(!this.rpmProgress){
            this.rpmProgress = new ProgressBar.Path("#electric-path", {
                easing: 'easeInOut',
                duration: 200
            });
            this.rpmProgress.animate(this.speed.rpm)     
        }
        if(!this.fuelProgress){
            this.fuelProgress = new ProgressBar.Path("#electric-fuel-path", {
                easing: 'easeInOut',
                duration: 200
            });
            this.fuelProgress.set(0)
        }   
        this.fuelProgress.animate(this.fuel/100)
        if(!this.nitroProgress){  
            this.nitroProgress = new ProgressBar.Path("#electric-nitro-path", {
                easing: 'easeInOut',
                duration: 200
            });
            this.nitroProgress.animate(this.nitroValue / 100)
        }
    },
    created() {
    },
    beforeDestroy() {
        window.removeEventListener('message', this.messageHandler);
    },
    template: await importTemplate('./app/pages/speedometer/components/electricspeedo/index.html')
}
export default ElectricSpeedo