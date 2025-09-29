import { Accessor, createBinding, createState } from 'ags';
import Hyprland from 'gi://AstalHyprland';
import { truncate } from '../../../lib/utils';

const hyprland = Hyprland.get_default();

export default function ActiveWindow({ monitor }: { monitor: Accessor<number> }) {
    const [activeWindow, setActiveWindow] = createState(hyprland.monitors.find((m) => m.id === monitor.get())!.activeWorkspace
        .lastClient?.title ?? "");
    const focusedClient = createBinding(hyprland, "focusedClient");
    focusedClient.subscribe(() => {
        if (focusedClient.get()?.get_workspace()?.get_monitor()?.id === monitor.get()) {
            setActiveWindow(focusedClient.get()!.title);
        }
    });
    const focusedWorkspace = createBinding(hyprland, "focusedWorkspace");
    focusedWorkspace.subscribe(() => {
        if (focusedWorkspace.get()?.monitor?.id === monitor.get()) {
            setActiveWindow(
                focusedWorkspace.get().lastClient?.title ??
                focusedWorkspace.get().clients[0]?.title ?? "")

        }
    });
    function clientMoved() {
        const ws = hyprland.monitors.find(
            (m) => m.id === monitor.get())!.activeWorkspace;
        if (ws.get_clients().length === 0) {
            setActiveWindow("");
        } else {
            setActiveWindow(ws.clients[0].title);
        }
    }

    hyprland.connect("client-moved", clientMoved);
    hyprland.connect("client-removed", clientMoved);

    return (
        <box cssClasses={activeWindow.as((t) => [t ? "pill" : ""].filter(Boolean))}>
            <label label={activeWindow.as(truncate)}></label>
        </box>
    )

}

