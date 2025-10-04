import app from "ags/gtk4/app";
import style from "./bar.scss";
import { Astal, Gdk } from "ags/gtk4";
import Clock from "./widgets/Clock";
import SysTray from "./widgets/Tray";
import Volume from "./widgets/Volume";
import NetworkStatus from "./widgets/Network";
import WeatherStatus from "./widgets/Weather";
import ActiveLayout from "./widgets/ActiveLayout";
import Media from "./widgets/Media";
import NetworkPerformance from "./widgets/NetworkPerformance";
import ActiveWindow from "./widgets/ActiveWindows";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import { createBinding } from "ags";
import Workspaces from "./widgets/Workspaces";

const hyprland = AstalHyprland.get_default();

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;
    app.apply_css(style);
    const monitor = createBinding(hyprland, "monitors").as(
        (monitor) =>
            monitor.find(
                (m) =>
                    m.name.toLowerCase() === gdkmonitor.connector.toLowerCase(),
            )?.id ?? 0,
    );
    const activeMonitor = createBinding(hyprland, "focusedMonitor").as(
        (m) => m.id,
    );
    return (
        <window
            visible
            cssClasses={["bar"]}
            gdkmonitor={gdkmonitor}
            marginTop={8}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={TOP | LEFT | RIGHT}
            application={app}
        >
            <centerbox cssClasses={["bar"]}>
                <box $type="start" spacing={8}>
                    <box cssClasses={["pill"]}>
                        <Workspaces monitor={monitor} />
                    </box>
                    <box>
                        <ActiveWindow monitor={activeMonitor} />
                    </box>
                </box>
                <box $type="center" cssClasses={["pill", "pill-media"]}>
                    <Media />
                </box>
                <box $type="end" spacing={8}>
                    <box cssClasses={["pill"]}>
                        <SysTray />
                    </box>
                    <box cssClasses={["pill"]} spacing={12}>
                        {/* <NetworkPerformance /> */}
                        <WeatherStatus />
                        <Volume />
                        <NetworkStatus />
                        <ActiveLayout />
                    </box>
                    <box cssClasses={["pill"]}>
                        <Clock />
                    </box>
                </box>
            </centerbox>
        </window>
    );
}
