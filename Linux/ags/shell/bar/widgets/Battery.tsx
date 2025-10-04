import { createBinding, createComputed } from "ags";
import Battery from "gi://AstalBattery";

const battery = Battery.get_default();

const icon = createComputed(
    [createBinding(battery, "percentage"), createBinding(battery, "state")],
    (percent, charging) => {
        percent *= 100;
        if (charging === Battery.State.CHARGING) return "󰂄";
        if (charging === Battery.State.PENDING_CHARGE) return "󰚥";
        if (percent >= 100) return "󰁹";
        if (percent >= 90) return "󰂂";
        if (percent >= 80) return "󰂁";
        if (percent >= 70) return "󰂀";
        if (percent >= 60) return "󰁿";
        if (percent >= 50) return "󰁾";
        if (percent >= 40) return "󰁽";
        if (percent >= 30) return "󰁼";
        if (percent >= 20) return "󰁻";
        if (percent >= 10) return "󰁺";
        return "󰂎";
    },
);

const tooltip = createComputed(
    [
        createBinding(battery, "percentage"),
        createBinding(battery, "state"),
        createBinding(battery, "timeToEmpty"),
        createBinding(battery, "timeToFull"),
    ],
    (percent, state, timeToEmpty, timeToFull) => {
        percent *= 100;
        const percentText = `${percent.toFixed(0)}%`;
        const tteS = timeToEmpty % 60;
        const tteM = ((timeToEmpty - tteS) / 60) % 60;
        const tteH = ((timeToEmpty - tteS) / 60 - tteM) / 60;
        const tte = `${tteH}h ${tteM}min`;
        const ttfS = timeToFull % 60;
        const ttfM = ((timeToFull - ttfS) / 60) % 60;
        const ttfH = ((timeToFull - ttfS) / 60 - ttfM) / 60;
        const ttf = `${ttfH}h ${ttfM}min`;
        if (state === Battery.State.CHARGING)
            return `${percentText} - ${ttf} until charged`;
        if (state === Battery.State.PENDING_CHARGE)
            return `${percentText} - Plugged In`;
        return `${percentText} - ${tte} remaining`;
    },
);

export default function BatteryStatus() {
    return (
        <box>
            <label label={icon} tooltipMarkup={tooltip} cssClasses={["icon"]} />
            <label
                label={createBinding(battery, "percentage").as(
                    (p) => ` ${(p * 100).toFixed(0)}%`,
                )}
            />
        </box>
    );
}
