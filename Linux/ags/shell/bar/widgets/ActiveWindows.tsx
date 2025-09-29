import { Accessor, createBinding, createState } from "ags";
import Hyprland from "gi://AstalHyprland";
import { truncate } from "../../../lib/utils";

const hyprland = Hyprland.get_default();

export default function ActiveWindow({
    monitor,
}: {
    monitor: Accessor<number>;
}) {
    const [activeWindow, setActiveWindow] = createState(
        hyprland.monitors.find((m) => m.id === monitor.get())!.activeWorkspace
            .lastClient?.initialTitle ?? "",
    );
    const focusedClient = createBinding(hyprland, "focusedClient");
    focusedClient.subscribe(() => {
        if (
            focusedClient.get()?.get_workspace()?.get_monitor()?.id ===
            monitor.get()
        ) {
            setActiveWindow(focusedClient.get()!.initialTitle);
        }
    });
    const focusedWorkspace = createBinding(hyprland, "focusedWorkspace");
    focusedWorkspace.subscribe(() => {
        if (focusedWorkspace.get()?.monitor?.id === monitor.get()) {
            setActiveWindow(
                focusedWorkspace.get().lastClient?.initialTitle ??
                    focusedWorkspace.get().clients[0]?.initialTitle ??
                    "",
            );
        }
    });
    function clientMoved() {
        const ws = hyprland.monitors.find(
            (m) => m.id === monitor.get(),
        )!.activeWorkspace;
        if (ws.get_clients().length === 0) {
            setActiveWindow("");
        } else {
            setActiveWindow(ws.clients[0].initialTitle);
        }
    }

    hyprland.connect("client-moved", clientMoved);
    hyprland.connect("client-removed", clientMoved);

    return (
        <box
            cssClasses={activeWindow.as((t) =>
                [t ? "pill" : ""].filter(Boolean),
            )}
        >
            <label label={activeWindow.as(truncate)}></label>
        </box>
    );
}
