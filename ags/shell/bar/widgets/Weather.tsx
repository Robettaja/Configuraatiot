import { createBinding } from "ags";
import { WeatherService } from "../../../lib/service/WeatherService";

const weather = new WeatherService();
export default function WeatherStatus() {
    return (
        <box>
            <label
                label={createBinding(weather, "short")}
                tooltipMarkup={createBinding(weather, "long")}
            ></label>
        </box>
    );
}
