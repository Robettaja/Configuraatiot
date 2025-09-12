import { property, register } from "ags/gobject";
import { execAsync } from "ags/process";
import { interval } from "ags/time";
import GObject from "gi://GObject?version=2.0";

@register()
export class NetworkPerformanceService extends GObject.Object {
    @property(Number)
    packetLoss: number;

    constructor() {
        super();
        this.packetLoss = 0;

        interval(5 * 1000, () => this.#test);
    }
    async #test() {
        const result = await execAsync("ping -c 5 -q 1.1.1.1");
        const match = result.match(/(\d+(?:\.\d+)?)% packet loss/);
        this.packetLoss = match ? parseFloat(match[1]) : 0;
    }
}
