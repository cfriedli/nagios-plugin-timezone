# prtg-plugin-timezone

PRTG plugin to check the current timezone.

Based on [ melmorabity's nagios-plugin-timezone](https://github.com/melmorabity/nagios-plugin-timezone)

## Authors

Christian Friedli < christian.friedli -(at)- id.unibe.ch>

## Usage

    check_timezone.sh [-h|--help]
    check_timezone.sh  EXPECTED_TIMEZONE

## Examples

    $ ls -l /etc/localtime
    lrwxrwxrwx. 1 root root 34 29 mars   2016 /etc/localtime -> ../usr/share/zoneinfo/Europe/Paris

    $ ./check_timezone.sh Europe/Zurich
    $ 0:0: OK: Current timezone is Europe/Zurich

    $ ./check_timezone.sh Europe/Zurich
    $ 1:1: Error: Current timezone is Europe/Paris (expected timezone Europe/Zurich)                                                          

