import { createPoll } from "ags/time";

const time = createPoll("", 1000, 'date "+%d.%m.%Y | %H.%M.%S"');

export default function Clock() {
    return (
        <box>
            <label label={time} />
        </box>
    );
}
