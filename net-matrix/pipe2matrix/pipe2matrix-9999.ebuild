# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9,10} )
DISTUTILS_USE_SETUPTOOLS="rdepend"
inherit git-r3 distutils-r1

DESCRIPTION="A bot that redirects a program's standard input/output into a Matrix room."
HOMEPAGE="https://gitlab.com/anton.molyboha/pipe2matrix"
# SRC_URI="https://github.com/poljar/matrix-nio/archive/${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://gitlab.com/anton.molyboha/pipe2matrix.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# TODO: the package optionally supports end-to-end encryption.
# We need to define a use flag and appropriate dependencies to enable that.

DEPEND="dev-python/matrix-nio"
RDEPEND="${DEPEND}"
BDEPEND=""
