# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9,10,11} )
DISTUTILS_USE_PEP517="setuptools"
inherit distutils-r1

DESCRIPTION="A bot that redirects a program's standard input/output into a Matrix room."
HOMEPAGE="https://gitlab.com/anton.molyboha/pipe2matrix"
SRC_URI="https://gitlab.com/anton.molyboha/pipe2matrix/-/archive/${PV}/pipe2matrix-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/matrix-nio-0.20.2"
BDEPEND=""
