# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="matrix-skype program user"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( matrix-skype )
ACCT_USER_HOME=/var/lib/matrix-skype
ACCT_USER_HOME_PERMS=0700
ACCT_USER_SHELL=/bin/sh
acct-user_add_deps
SLOT="0"
