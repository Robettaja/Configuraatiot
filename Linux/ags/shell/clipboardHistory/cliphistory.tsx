import app from "ags/gtk4/app";
import { Astal, Gdk, Gtk } from "ags/gtk4";
import style from "./style.scss";
import { execAsync } from "ags/process";
import { For, Accessor, createState } from "ags";
import { truncate } from "../../lib/utils";
import Pango from "gi://Pango?version=1.0";

app.apply_css(style);

type ClipItem = {
    item: string;
};

const [clipBoardHistory, setHistory] = createState<ClipItem[]>([]);

async function clipboard(): Promise<ClipItem[]> {
    const results: ClipItem[] = [];

    const lastResult = await execAsync(["bash", "-c", `clipvault list`]);
    const resultAmount = parseInt(lastResult.split(" ")[0]);
    let maxResult = 100;
    for (let i = 0; i < Math.min(resultAmount, maxResult); i++) {
        const result = await execAsync([
            "bash",
            "-c",
            `clipvault get --index ${i}`,
        ]);
        const clip: ClipItem = {
            item: result,
        };
        if (results.some((clipItem) => clipItem.item == result)) {
            maxResult++;
            continue;
        }
        if (result != "") results.push(clip);
    }
    return results;
}
async function addToClipboard(text: string) {
    await execAsync(["bash", "-c", `wl-copy "${text}"`]);
}
function updateHistory() {
    clipboard().then((value) => setHistory(value));
}

export default async function ClipboardHistory(gdkmonitor: Gdk.Monitor) {
    const { RIGHT, BOTTOM } = Astal.WindowAnchor;

    const geo = gdkmonitor.get_geometry();

    return (
        <window
            name="clipboardhistory"
            anchor={BOTTOM | RIGHT}
            widthRequest={geo.width / 5}
            height_request={geo.height / 3}
            margin={8}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            layer={Astal.Layer.TOP}
            application={app}
            onShow={(source) => updateHistory()}
        >
            <box class={"clip-area"} orientation={Gtk.Orientation.VERTICAL}>
                <image
                    class={"clip-icon"}
                    file={"media/clipboard.png"}
                    pixelSize={24}
                    halign={Gtk.Align.END}
                ></image>
                <scrolledwindow
                    width_request={geo.width / 5}
                    height_request={geo.height / 3}
                    vscrollbarPolicy={Gtk.PolicyType.ALWAYS}
                    hscrollbarPolicy={Gtk.PolicyType.EXTERNAL}
                >
                    <box
                        orientation={Gtk.Orientation.VERTICAL}
                        marginTop={4}
                        margin_start={4}
                    >
                        <For each={clipBoardHistory}>
                            {(item, index: Accessor<number>) => (
                                <button
                                    class={"clip-item"}
                                    halign={Gtk.Align.FILL}
                                    onClicked={(self: Gtk.Button) =>
                                        addToClipboard(item.item)
                                    }
                                >
                                    <label
                                        class={"clip-item-text"}
                                        halign={Gtk.Align.START}
                                        label={`${index.get() + 1}. ${truncate(item.item.replaceAll("\n", " "))}`}
                                    ></label>
                                </button>
                            )}
                        </For>
                    </box>
                </scrolledwindow>
            </box>
        </window>
    );
}
