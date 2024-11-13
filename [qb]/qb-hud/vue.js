const app = new Vue({
  el: '#app',
  data: {
    all:false,
    menu:false,
    speedometer: null, // car civilian
    lastAnimwState: null,
    backgroundImageStyle: {
      backgroundImage: "url('assets/img/background.svg')"
    },
    currentTime: 'Dec 05, 17:30',
    player:{
      account:{
        job:'Miner',
        cash:21000,
        bank:21000,
        black:0
      },
      weapon:{
        data:true,
        item:'WEAPON_PISTOL',
        ammo:65,
        clip:66
      },
      location1:'Vespucci Boulevard',
      location2:'Vespucci'
    },
    type:'car', // car civilian
    map:'rounded', // standart // rounded
    bar: [
      { d: "M40.669 227.331C39.884 228.116 38.6102 228.117 37.8371 227.32C25.0441 214.138 15.098 198.465 8.61702 181.277C8.22537 180.238 8.76868 179.086 9.81314 178.71V178.71C10.8576 178.334 12.0077 178.877 12.3998 179.915C18.6797 196.547 28.305 211.714 40.68 224.477C41.4527 225.274 41.4539 226.546 40.669 227.331V227.331Z", opacity: 0.12 },
      { d: "M6.50745 168.162C5.43518 168.449 4.33148 167.813 4.06028 166.736C-0.427453 148.923 -1.20476 130.378 1.77668 112.252C1.95685 111.156 3.00347 110.43 4.09601 110.627V110.627C5.18856 110.823 5.91326 111.868 5.7336 112.964C2.85633 130.507 3.60857 148.455 7.94374 165.696C8.21444 166.772 7.57971 167.874 6.50745 168.162V168.162Z", opacity: 0.12 },
      { d: "M6.50745 99.8384C5.43519 99.5511 4.79737 98.4485 5.10073 97.3806C10.1207 79.7103 18.7205 63.2604 30.3655 49.0536C31.0692 48.1951 32.3387 48.0895 33.1866 48.806V48.806C34.0345 49.5225 34.1396 50.7898 33.4363 51.6486C22.1728 65.4031 13.8504 81.3223 8.9842 98.4212C8.68034 99.4889 7.57972 100.126 6.50745 99.8384V99.8384Z", opacity: 0.12 },
      { d: "M40.669 40.669C39.884 39.884 39.883 38.6101 40.6796 37.8371C53.8622 25.0441 69.5348 15.098 86.7231 8.61702C87.7618 8.22537 88.9139 8.76869 89.29 9.81315V9.81315C89.666 10.8576 89.1234 12.0077 88.0849 12.3998C71.4532 18.6797 56.2862 28.305 43.5225 40.6799C42.7255 41.4527 41.4539 41.4539 40.669 40.669V40.669Z", opacity: 0.12 },
      { d: "M261.493 168.162C262.565 168.449 263.669 167.813 263.94 166.736C268.427 148.923 269.205 130.378 266.223 112.252C266.043 111.156 264.997 110.43 263.904 110.627V110.627C262.811 110.823 262.087 111.868 262.266 112.964C265.144 130.507 264.391 148.455 260.056 165.696C259.786 166.772 260.42 167.874 261.493 168.162V168.162Z", opacity: 0.12 },
      { d: "M261.493 99.8384C262.565 99.5511 263.203 98.4485 262.899 97.3806C257.879 79.7103 249.28 63.2604 237.634 49.0536C236.931 48.1951 235.661 48.0895 234.813 48.806V48.806C233.966 49.5225 233.86 50.7898 234.564 51.6486C245.827 65.4031 254.15 81.3223 259.016 98.4212C259.32 99.4889 260.42 100.126 261.493 99.8384V99.8384Z", opacity: 0.12 },
      { d: "M227.331 40.669C228.116 39.884 228.117 38.6101 227.32 37.8371C214.138 25.0441 198.465 15.098 181.277 8.61702C180.238 8.22537 179.086 8.76869 178.71 9.81315V9.81315C178.334 10.8576 178.877 12.0077 179.915 12.3998C196.547 18.6797 211.714 28.305 224.477 40.6799C225.274 41.4527 226.546 41.4539 227.331 40.669V40.669Z", opacity: 0.12 },
      { d: "M99.8385 6.50744C99.5512 5.43518 100.187 4.33147 101.264 4.06027C121.831 -1.12152 143.336 -1.34672 164.008 3.4032C165.09 3.6518 165.749 4.74194 165.484 5.81999V5.81999C165.219 6.89804 164.131 7.55571 163.049 7.30761C143.035 2.71859 122.218 2.9366 102.304 7.94374C101.228 8.21444 100.126 7.57971 99.8385 6.50744V6.50744Z", opacity: 0.12 },
    ],
    speedNumbers: [ 
    { value: 20, x: 60, y: 186.48 },
    { value: 40, x: 45, y: 144.48 },
    { value: 60, x: 53, y: 97.48 },
    { value: 80, x: 84, y: 66.48 },
    { value: 100, x: 123.314, y: 53.48 },
    { value: 120, x: 163.898, y: 66.48 },
    { value: 140, x: 194.074, y: 97.48 },
    { value: 160, x: 205.828, y: 144.48 }
    ],
    hud: {
      speedometer: {
        speed: null,
        rpm: null,
        fuel: null,
        gear: null,
        light: false,
        noss:0
      },
      status: {
        hunger: null,
        water: null,
        microphone: null,
        health: null,
        armor: null,
        oxygen: 100,
        stress: 0
      }
    }
   },

   methods: {
    getOpacity(value) {
      return this.hud.speedometer.speed >= value ? 1 : 0.5;
    },

    handleEventMessage(event) {
      const item = event.data;
      switch (item.data) {
        case 'CAR':
          this.updateCarStatus(item);
          break;
        case 'CIVIL':
          this.speedometer = 'civilian';
          break;
        case 'MAP':
          this.map = item.type;
          break;
        case 'STREET':
          this.updatePlayerLocation(item);
          break;
        case 'WEAPON':
          this.updatePlayerWeapon(item);
          break;
        case 'AMMO':
          this.updatePlayerAmmo(item);
          break;
        case 'STATUS':
          this.updateStatus(item);
          break;
        case 'MICROPHONE':
          this.hud.status.microphone = item.variable;
          break;
        case 'HEALTH':
          this.hud.status.health = item.health;
          break;
        case 'ARMOR':
          this.hud.status.armor = item.armor;
          break;
        case 'PLAYER':
          this.player.account = item.player;
          break;
        case 'QBSET_CRYPTO':
          this.player.account.black = item.amount;
        break
        case 'QBSET_CASH':
          this.player.account.cash = item.amount;
        break
        case 'QBSET_BANK':
          this.player.account.bank = item.amount;
        break
        case 'OXYGEN':
          this.hud.status.oxygen = item.oxygen;
          break;
        case 'JOB':
          this.player.account.job = item.label;
          break;
        case 'ACCOUNT':
          this.updateAccount(item);
          break;
        case 'STRESS':
          this.hud.status.stress = item.stress;
          break;
        case 'EXIT':
          this.all = item.args;
          break
        case 'NOSS':
          this.hud.speedometer.noss = item.noss;
          break
      }
    },

    updateCarStatus(item) {
      this.speedometer = 'car';
      this.hud.speedometer = {
        speed: item.speed,
        rpm: item.rpm,
        fuel: item.fuel,
        light: item.state,
        seatbelt: item.seatbelt,
        engine:item.engine,
        noss:this.hud.speedometer.noss,
        gear: item.gear === 0 ? 'N' : item.gear
      };
    },

    updatePlayerLocation(item) {
      this.player.location1 = item.StreetName1;
      this.player.location2 = item.StreetName2;
    },

    updatePlayerWeapon(item) {
      let weaponName = item.weapon.toUpperCase();
      if (!weaponName.startsWith('WEAPON_')) {
        weaponName = 'WEAPON_' + weaponName;
      }
      this.player.weapon.item = weaponName;
    },

    updatePlayerAmmo(item) {
      this.player.weapon.ammo = item.ammo;
      this.player.weapon.clip = item.clip;
    },

    updateStatus(item) {
      this.hud.status.hunger = item.hunger;
      this.hud.status.water = item.thirst;
    },

    updateAccount(item) {
      if (item.type == 'BANK') {
        this.player.account.bank = item.amount;
      } else if (item.type == 'CASH') {
        this.player.account.cash = item.amount;
      }
    },

    updateTime() {
      const now = new Date();
      this.currentTime = now.toLocaleString('en-US', {
        month: 'short',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
      });
    },

    formatCurrency(value, currencySymbol = '$', delimiter = '.') {
      value = parseFloat(value);
      let formattedValue = value.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, delimiter);
      return formattedValue + currencySymbol;
    },
    
    triggerAnimation() {
      anime({
        targets: this.$refs.animatingPath,
        rotate: '1turn',
        duration: 2000,
        loop: false,
        complete: () => {
          if (this.$refs.animatingPath) {
            this.$refs.animatingPath.style.transform = ''; 
          }
        }
      });
    },
    

    Animejs(i) {
      const target = this.$refs.speedometer;
      if (i === 'civilian') {
        anime({
          targets: target,
          translateY: [0, 100],
          opacity: [1, 0], 
          easing: 'easeInExpo',
          duration: 700,
          delay: 100, 
          complete: () => {
            target.style.transform = 'translateY(-100px)'; 
            target.style.opacity = 0; 
          }
        });
      } else {
        anime({
          targets: target,
          translateY: [-100, 0], 
          opacity: [0, 1], 
          easing: 'easeOutExpo',
          duration: 700, 
          delay: 100,
          begin: () => {
            target.style.opacity = 0; 
          }
        });
      }
    },

    Animw(i) {
      if (this.lastAnimwState !== i) {
        this.lastAnimwState = i;
        const isVisible = i ? true : false;
        const easingType = isVisible ? 'easeOutExpo' : 'easeInExpo';
        this.applyAnimation(this.$refs.weaponDiv, isVisible, easingType, 1000);
      }
    },
    
    applyAnimation: function(element, isVisible, easing, duration) { 
      anime({
        targets: element,
        opacity: isVisible ? [0, 1] : [1, 0],
        translateX: isVisible ? [-100, 0] : [0, -100],
        easing: easing,
        duration: duration
      });
    },

    calculateWidth(percentage) {
      const maxWidth = 100; 
      return (maxWidth * percentage) / 100;
    },
    },

    watch: {
      'hud.status.water': function(val) {
        if (Math.floor(val) !== val) {
            val = Math.floor(val);
        }
        this.hud.status.water = val;
      },
      'hud.status.hunger': function(val) {
        if (Math.floor(val) !== val) {
            val = Math.floor(val);
        }
        this.hud.status.hunger = val;
      },
      'player.account': function(){
        this.all = true;
      },

      'player.weapon.item': function(id) {
        if (id == 'WEAPON_UNARMED'){
          this.Animw(false)
        }else {
          this.Animw(true)
        }
      },

      'player.weapon.ammo': function(newAmmo, oldAmmo) {
        anime({
          targets: this.$refs.ammoDisplay,
          opacity: [0, 1], 
          easing: 'easeOutElastic',
          duration: 1000,
        });
        anime({
          targets: this.$refs.ammoIcon,
          rotate: [0, 5, -5, 0],  
          duration: 300,  
          easing: 'easeInOutSine',
          loop: 1,
        });
      },

     speedometer(newValue, oldValue) {
        if (newValue !== oldValue) {
          this.Animejs(newValue);
        }
      },

      'hud.speedometer.rpm': function(newVal) {
        if (newVal == 103) {
          this.$set(this.hud.speedometer, 'rpm', 0);
        }
      },

      'player.location1'(newVal, oldVal) {
        if (newVal !== oldVal) {
          this.triggerAnimation();
        }
      },
      
    },

    created() {
      window.addEventListener('message', this.handleEventMessage);
    },

    mounted(){
      this.updateTime();
      setInterval(this.updateTime, 1000); 
    },
    
    computed: {
      dynamicClasses() {
        let classes = 'LOCATION absolute';
        if (this.map === 'standart' && this.speedometer != 'car') {
            classes += ' animate-slide-left top-[53.5rem] left-[-10rem]';
        }else if (this.map == 'standart' && this.speedometer == 'car'){
          classes += ' animate-slide-left top-[40.25rem] left-[-10rem]';
        } 
        else if (this.map === 'rounded' && this.speedometer != 'car') {
            classes += ' animate-slide-bottom top-[53.35rem] left-[-10rem]';
        } else if (this.map === 'rounded'){
            classes += ' animate-slide-bottom top-[40.5rem] left-[-9rem]';
        }
        if (this.speedometer === 'civilian') {
            this.map = 'animate-slide-bottom standart';
        }
        return classes;
      },
      currentSvgContent() {
        return this.generateSvgContent();
      },
      formattedSpeed() {
        let speed = this.hud.speedometer.speed;
        if (speed < 100) {
          return `<tspan fill="grey">0</tspan><tspan fill="white">${speed}</tspan>`;
        } else {
          return speed;
        }
      },
      formattedAmmoDisplay() {
        const ammo = this.player.weapon.ammo;
        const clip = this.player.weapon.clip;
        const commonStyle = 'font-family="Proxima Nova" font-size="16" font-weight="bold"';
    
        if (ammo < 99) {
          return `<tspan ${commonStyle}>${clip} / ${ammo}</tspan>`;
        } else {
          return `<tspan ${commonStyle}>${clip} / ${ammo}</tspan>`;
        }
      },
      microphone() {
        return this.hud.status.microphone ? 'rgba(191, 250, 53, 0.75)' : 'rgba(229, 46, 46, 0.75)';
      },
      seatbelt() {
        return this.hud.speedometer.seatbelt ? 'rgba(191, 250, 53, 0.749)' : 'rgba(229, 46, 46, 0.349)';
      },
      door() {
          return this.hud.speedometer.door ? 'rgba(191, 250, 53, 0.749)' : 'rgba(229, 46, 46, 0.349)';
      },
      light() {
        return this.hud.speedometer.light ? 'rgba(191, 250, 53, 0.749)' : 'rgba(229, 46, 46, 0.349)';
      },
      engine() {
        return this.hud.speedometer.engine ? 'rgba(191, 250, 53, 0.749)' : 'rgba(229, 46, 46, 0.349)';
      }
    }
  })


  document.onkeyup = function (data) {
    if (data.which == 27) {
      $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}));
    }
  };

  