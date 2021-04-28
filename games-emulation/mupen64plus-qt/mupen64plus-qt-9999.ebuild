# Copyright 2018-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop git-r3 qmake-utils

DESCRIPTION="A basic launcher for Mupen64Plus"
HOMEPAGE="https://github.com/dh4/mupen64plus-qt"
EGIT_REPO_URI="https://github.com/dh4/mupen64plus-qt"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtnetwork:5
	dev-qt/qtxml:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	dev-libs/quazip
"
DEPEND=">=games-emulation/mupen64plus-core-2.5
		${RDEPEND}"

src_prepare() {
	sed -i -e '/MatchWildcard/{s/Wildcard/RegExp/; s/"\*"/".*"/}' src/dialogs/settingsdialog.cpp || die
	sed -i -e '/include.*quazip5/s/quazip5/QuaZip-Qt5-1.1\/quazip/' \
		src/emulation/emulatorhandler.cpp src/common.cpp || die
	sed -i -e 's/lquazip5/lquazip1-qt5/' mupen64plus-qt.pro || die
	default
}

src_configure() {
	eqmake5
}

src_install() {
	dobin ${PN}
	dodoc README.md
	doman resources/${PN}.6
	domenu resources/${PN}.desktop
	newicon resources/images/mupen64plus.png ${PN}.png
}
