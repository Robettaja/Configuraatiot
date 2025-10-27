import app from "ags/gtk4/app";
import style from "./style.scss";
import Bar from "./shell/bar/bar";
import PowerMenu from "./shell/powermenu/powermenu";
import AccessWindow from "./shell/access/Access";
import ClipboardHistory from "./shell/clipboardHistory/cliphistory";

app.start({
    css: style,
    main() {
        app.get_monitors().map(Bar);
        PowerMenu();
        ClipboardHistory(app.get_monitors()[0]);
        AccessWindow(app.get_monitors()[0]);
    },
});
