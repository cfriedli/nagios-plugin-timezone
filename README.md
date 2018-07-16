# prtg-plugins-timezone

PRTG plugin to check the current timezone.
Based on [ melmorabity's nagios-plugin-timezone](https://github.com/melmorabity/nagios-plugin-timezone)

## Authors

Mohamed El Morabity <melmorabity -(at)- fedoraproject.org>
Christian Friedli < christian.friedli -(at)- id.unibe.ch>

## Usage

    check_timezone.sh [-h|--help]
    check_timezone.sh [-w|--warning] EXPECTED_TIMEZONE

## Examples

    $ ls -l /etc/localtime
    lrwxrwxrwx. 1 root root 34 29 mars   2016 /etc/localtime -> ../usr/share/zoneinfo/Europe/Paris

    $ ./check_timezone.sh Europe/Paris
    OK: Current timezone is Europe/Paris

    $ ./check_timezone.sh UTC
    ERROR: Current timezone is Europe/Paris (expected timezone: UTC)

    $ ./check_timezone.sh --warning UTC
    WARNING: Current timezone is Europe/Paris (expected timezone: UTC)
