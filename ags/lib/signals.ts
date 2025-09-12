import { onCleanup } from "ags";
import { timeout } from "ags/time";
import AstalIO from "gi://AstalIO"

type ScheduleCallback = <Args extends unknown[]> (
    callback: (...args: Args) => void,
    wait?: number,
) => [(...args: Args) => void, () => void];

export function throttle(callback: () => void, wait: number) {
    let isThrottled = false
    let lastArgs: Parameters<typeof callback>
    let timeoutInstance: AstalIO.Time | undefined;

    const throttled: typeof callback = (...args) => {
        lastArgs = args;
        if (isThrottled) return;
        isThrottled = true;
        timeout(wait, () => {
            callback(...lastArgs)
            isThrottled = false;
        });
    }

    const cleanup = () => {
        timeoutInstance?.cancel();
        isThrottled = false;
    }
    return [throttled, cleanup]
}
