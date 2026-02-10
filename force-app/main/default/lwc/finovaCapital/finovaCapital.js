import { LightningElement, track } from 'lwc';

export default class finovaCapital extends LightningElement {
    map;
    routingControl;
    leafletLoaded = false;

    @track searchStart = '';
    @track searchEnd = '';

    @track filteredStartLocations = [];
    @track filteredEndLocations = [];

    @track startLocation = null;
    @track endLocation = null;

    allLocations = [
        { name: 'Mumbai', latlng: [19.0760, 72.8777] },
        { name: 'Delhi', latlng: [28.6139, 77.2090] },
        { name: 'Pune', latlng: [18.5204, 73.8567] },
        { name: 'Bangalore', latlng: [12.9716, 77.5946] },
        { name: 'Hyderabad', latlng: [17.3850, 78.4867] },
        { name: 'Chennai', latlng: [13.0827, 80.2707] },
        { name: 'Ahmedabad', latlng: [23.0225, 72.5714] }
    ];

    renderedCallback() {
        if (this.leafletLoaded) return;

        Promise.all([
            this.loadCss('https://unpkg.com/leaflet/dist/leaflet.css'),
            this.loadCss('https://unpkg.com/leaflet-routing-machine/dist/leaflet-routing-machine.css'),
            this.loadScript('https://unpkg.com/leaflet/dist/leaflet.js'),
            this.loadScript('https://unpkg.com/leaflet-routing-machine/dist/leaflet-routing-machine.min.js')
        ])
            .then(() => {
                this.leafletLoaded = true;
                this.initMap();
            })
            .catch((err) => console.error('Leaflet load error:', err));
    }

    loadScript(src) {
        return new Promise((resolve, reject) => {
            const script = document.createElement('script');
            script.src = src;
            script.onload = resolve;
            script.onerror = reject;
            document.head.appendChild(script);
        });
    }

    loadCss(href) {
        return new Promise((resolve, reject) => {
            const link = document.createElement('link');
            link.rel = 'stylesheet';
            link.href = href;
            link.onload = resolve;
            link.onerror = reject;
            document.head.appendChild(link);
        });
    }

    initMap() {
        const container = this.template.querySelector('.map');
        this.map = L.map(container).setView([20.5937, 78.9629], 5);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(this.map);
    }

    handleStartSearch(event) {
        this.searchStart = event.target.value;

        if (this.searchStart.length < 3) {
            this.filteredStartLocations = [];
            return;
        }

        this.searchLocation(this.searchStart).then((results) => {
            this.filteredStartLocations = results;
        });
    }

    handleEndSearch(event) {
        this.searchEnd = event.target.value;

        if (this.searchEnd.length < 3) {
            this.filteredEndLocations = [];
            return;
        }

        this.searchLocation(this.searchEnd).then((results) => {
            this.filteredEndLocations = results;
        });
    }

    searchStartLocation() {
        if (!this.searchStart || this.searchStart.length < 3) {
            this.filteredStartLocations = [];
            return;
        }

        this.searchLocation(this.searchStart).then((results) => {
            this.filteredStartLocations = results;
        });
    }

    searchEndLocation() {
        if (!this.searchEnd || this.searchEnd.length < 3) {
            this.filteredEndLocations = [];
            return;
        }

        this.searchLocation(this.searchEnd).then((results) => {
            this.filteredEndLocations = results;
        });
    }



    drawRoute() {
        if (!this.startLocation || !this.endLocation || !this.map || !L.Routing) return;

        if (this.routingControl) {
            this.map.removeControl(this.routingControl);
        }

        this.routingControl = L.Routing.control({
            waypoints: [
                L.latLng(...this.startLocation.latlng),
                L.latLng(...this.endLocation.latlng)
            ],
            routeWhileDragging: false,
            addWaypoints: false,
            show: false,
            lineOptions: {
                styles: [{ color: 'blue', opacity: 0.8, weight: 6 }]
            },
            createMarker: () => null
        }).addTo(this.map);

        // Add markers manually
        L.marker(this.startLocation.latlng)
            .addTo(this.map)
            .bindPopup(`Start: ${this.startLocation.name}`)
            .openPopup();

        L.marker(this.endLocation.latlng)
            .addTo(this.map)
            .bindPopup(`End: ${this.endLocation.name}`);
    }

    searchLocation(query) {
        const encodedQuery = encodeURIComponent(query);
        const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodedQuery}`;

        return fetch(url)
            .then((response) => response.json())
            .then((data) => {
                return data.map((loc) => ({
                    name: loc.display_name,
                    latlng: [parseFloat(loc.lat), parseFloat(loc.lon)]
                }));
            })
            .catch((err) => {
                console.error('Geocoding error:', err);
                return [];
            });
    }


    updateStartInput(event) {
        this.searchStart = event.target.value;
    }

    updateEndInput(event) {
        this.searchEnd = event.target.value;
    }

}