# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="The user to run net-matrix/maubot as."
ACCT_USER_ID=
ACCT_USER_GROUPS=( maubot )

acct-user_add_deps
