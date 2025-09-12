import app from "ags/gtk4/app"
import style from "./Access.scss";
import { Astal, Gdk, Gtk } from "ags/gtk4";
import { Accessor, createState, For, onCleanup, With } from "ags";
import { DummyPlugin } from "./plugins/dummy";
import { AccessManager } from "./AccessManager";
import { SearchResult } from "./plugins";
import { throttle } from "../../lib/signals"

app.apply_css(style);

function Icon({ icon }: { icon: string }) {
    const isEmoji = /\p{Extended_Pictographic}/u.test(icon);
    return (
        <box class="access-result-icon">
            {isEmoji ? <label label={icon} /> : <image />}
        </box>
    )
}
const manager = new AccessManager();
manager.addPlugin(new DummyPlugin)

function Access() {
    const [search, setSearch] = createState("");
    const [results, setResults] = createState<SearchResult[]>([]);

    const [doSearch, cleanupSearch] = throttle(() => {
        manager.results(search.get()).then((results) => setResults(results));
    }, 20);
    const disposeSubscription = search.subscribe(() => {
        doSearch();
    })

    onCleanup(() => {
        disposeSubscription();
        cleanupSearch();

    });
    return (
        <box orientation={Gtk.Orientation.VERTICAL}>
            <box class="access-input" halign={Gtk.Align.FILL}>
                <entry text={search} onNotifyText={(entry) => setSearch(entry.text)} hexpand />
            </box>
            <scrolledwindow class={"access-results"} propagateNaturalHeight propagateNaturalWidth>
                <box orientation={Gtk.Orientation.VERTICAL}>
                    <For each={results}>
                        {(result) => (
                            <box class={"access-result"}>
                                <Icon icon={result.icon || result.plugin.icon}></Icon>
                                <box>
                                    <label class={"access-result-title"} label={result.title}></label>
                                    <label class={"access-result-plugin-name"} label={result.description}></label>
                                </box>
                            </box>
                        )}
                    </For>
                </box>
            </scrolledwindow>
            <box />
        </box>

    )
};


export default function AccessWindow(gdkmonitor: Gdk.Monitor) {
    const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;
    const geo = gdkmonitor.get_geometry();

    return (
        <window
            name="access"
            layer={Astal.Layer.TOP}
            widthRequest={geo.width / 3}
            height_request={geo.height / 3}
            application={app}
            keymode={Astal.Keymode.ON_DEMAND}>
            <box class="access">
                <Access />
            </box>
        </window>
    );

}
