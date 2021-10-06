
var app = new Vue({
    el: '#app',
    data: {
        mode: ''
    },
    methods: {
        // focusSearchBox()
        // {
        //     this.$refs.searchBox.focus();
        // },
        close() {
            // this.vehicles.forEach(vehicle => {
            //     this.hideTransfer(vehicle);
            //     this.hideSetName(vehicle);
            // });
            
            // this.$refs.vehicleDetailsPanel -- Need to think about how to collapse all items at once with Vue.js, as in remove the 'show' class
            // But using jQuery here does actually work so using it for now
            // $('.collapse').collapse('hide');

            // this.search = '';
            $.post('https://htb_mechanic/close', JSON.stringify({}));
        },


    },
    computed: {
        // filteredVehicles() {
        //     return this.vehicles.filter(item => {
        //         if(this.search === '') return item;
        //         return item.plate.toLowerCase().indexOf(this.search.toLowerCase()) > -1
        //             || item.spawnName !== undefined && item.spawnName.toLowerCase().indexOf(this.search.toLowerCase()) > -1
        //             || item.modelName !== undefined && item.modelName.toLowerCase().indexOf(this.search.toLowerCase()) > -1
        //             || item.displayName !== undefined && item.displayName.toLowerCase().indexOf(this.search.toLowerCase()) > -1
        //             || item.vehiclename !== undefined && item.vehiclename.toLowerCase().indexOf(this.search.toLowerCase()) > -1
        //     })
        // },

    }

});


document.onreadystatechange = () => {
    if (document.readyState === "complete") {
        window.addEventListener('message', (event) => {
            if (event.data.action === 'enable') {
                document.body.style.display = event.data.isVisible ? "block" : "none";
                app.mode = event.data.mode;
                //app.focusSearchBox();
            }
        });
    }
};

/* Handle escape key press to close the menu */
document.onkeyup = function (data) {
    // console.log(JSON.stringify(data));
    if (data.which == 27) {
        app.close();
        
    }
};

