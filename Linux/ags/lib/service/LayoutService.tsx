import GObject, { property, register } from "ags/gobject";
import { interval } from "ags/time";
import { execAsync } from "ags/process";

@register()
export class LayoutService extends GObject.Object {
    @property(String)
    layout: string;
    constructor() {
        super();
        this.layout = "🇫🇮";
        interval(500, () => this.#update());
    }
    async #update() {
        try {
            const result = await execAsync([
                "bash",
                "-c",
                "hyprctl devices -j | jq -r '.keyboards[] | .active_keymap' | head -n1 | cut -c1-2 | tr 'a-z' 'A-Z'",
            ]);

            const layoutCode = result.trim();

            const layoutMap: { [key: string]: string } = {
                FI: "🇫🇮",
                EN: "🇺🇸",
            };

            this.layout = layoutMap[layoutCode] || this.layout;
        } catch (error) {
            console.error("LayoutService update failed:", error);
        }
    }
}
