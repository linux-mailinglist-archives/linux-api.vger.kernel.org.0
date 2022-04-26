Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08F450FCDD
	for <lists+linux-api@lfdr.de>; Tue, 26 Apr 2022 14:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245146AbiDZMaE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Apr 2022 08:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiDZMaD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 Apr 2022 08:30:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A61D193C7;
        Tue, 26 Apr 2022 05:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650976016; x=1682512016;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mTFPQ9fFQ/EZMYI1LHuxb9M/RC2nbjOzVP4xv+UBznY=;
  b=ji/Hw6hqIuaK7Igq0QtYJMmvYiMOcWpr8udqzkUImmFIbNvcB6MR4LOo
   EGXIfXv8iTTSkAEddqj7m4T2hrP9K16RbAvq67ocG8LQlplDXnSe6OA6D
   nqUf5ayHn+yTdFafZDhnZKBBo4Sqpq+oXgoXzRmaHWZqnUzvSlZi8MkUW
   dLfRogxBNSg9VZ4YlDVvjTgy0+eiKVUW+w3DQVsRkgZ7MPj0GEU92J57Q
   2pc3CiGOj5y459VdOTlgv2+y1pATfa5Hs1zpnmURJnJEIvvxw1+/c5Rc3
   rO1j7m6eA5r3rUcD24CG4/ka16xVU4nhDHL6q2kB4uvkJMwEvec4HHXOR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="252934663"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="252934663"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 05:26:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579864798"
Received: from mmilkovx-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.47.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 05:26:52 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vicente Bergas <vicencb@gmail.com>,
        Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-api@vger.kernel.org
Subject: [PATCH v5 00/10] Add RS485 support to DW UART
Date:   Tue, 26 Apr 2022 15:24:38 +0300
Message-Id: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patchset adds RS-485 support to the DW UART driver. The patchset
has two main parts. The first part adds HW support for RS-485 itself
in various modes of operation and the second part focuses on enabling
9th bit addressing mode that can be used on a multipoint RS-485
communications line.

To configure multipoint addressing, ADDRB flag is added to termios
and two new IOCTLs are added into serial core. Lukas Wunner brought up
during v1 review that if this addressing is only going to be used with
RS-485, doing it within rs485_config would avoid having to add those
IOCTLs. There was some counterexample w/o further details mentioned for
RS-232 usage by Andy Shevchenko. I left the IOCTL approach there but if
somebody has further input on this, please voice it as it is user-space
facing API.

I decided to rewrite the UART_CAP_NOTEMT patch from scratch myself
based on Uwe Kleine-König's earlier suggestion and include it to this
series. To make waiting for a single character easy and to avoid
storing it per purpose in the uart drivers, I decided to add
frame_time into uart_port. It turned out to beneficial also for serial
core which had to reverse calculate it from uart_port->timeout). I was
thinking of removing uart_port->timeout entirely and derive the value
timeout from frame_time and fifosize where needed but I was not sure
if that's ok to do lockingwise (not that fifosize is a variable that
is expected to change so maybe I'm just being too cautious).

Cc: linux-api@vger.kernel.org

v1 -> v2:
- Add uart_port->frame_time to avoid the need to store it per purpose
- Included NOTEMT patch rewritten from scratch
- Merge HW half & full-duplex patches
- Detect RS485 HW using RE_EN register write+read
- Removed SER_RS485_SW_RX_OR_TX
- Relocated/renamed RE polarity DT prop
- Use SER_RS485_RTS_ON_SEND rather than DT prop directly
- Removed DE polarity prop, it is still configurable but with rts one instead
- Make DE active-high by default in dwlib
- Don't unnecessarily clear DE/RE_EN for non-RS485 mode
- Prevent ADDRB and addrmode desync for RS485->RS232 transition
- Added ACPI enumeration doc
- Changed -EINVAL to -ENOTTY if no set/get_addr handler is present
- Clear ADDRB in set_termios of a few more drivers
- Added filtering for addresses to avoid them leaking into data stream
- Reworded comments & commit messages as requested

v2 -> v3:
- Change ADDRB to 0x20000000 which is free for all archs
- Added TIOCSADDR/GADDR to tty_compat_ioctl

v3 -> v4:
- defined DW_UART_ADDR_MASK instead of 0xff
- Adapt to UART_CAP_NOTEMT that already exists (is currently no-op)
- Corrected delay_rts_after_send conversion to nsec
- Make 8250 DMA code to use THRE & __stop_tx
- Add roughly one extra bit to stop_delay to prevent too early RTS deassert

v4 -> v5:
- rebased series to tty-testing

Ilpo Järvinen (10):
  serial: 8250_dwlib: RS485 HW half & full duplex support
  serial: 8250_dwlib: Implement SW half duplex support
  dt_bindings: rs485: Add receiver enable polarity
  ACPI / property: Document RS485 _DSD properties
  serial: termbits: ADDRB to indicate 9th bit addressing mode
  serial: General support for multipoint addresses
  serial: 8250: make saved LSR larger
  serial: 8250: create lsr_save_mask
  serial: 8250_lpss: Use 32-bit reads
  serial: 8250_dwlib: Support for 9th bit multipoint addressing

 .../devicetree/bindings/serial/rs485.yaml     |   5 +
 .../driver-api/serial/serial-rs485.rst        |  23 +-
 .../firmware-guide/acpi/enumeration.rst       |  25 ++
 arch/alpha/include/uapi/asm/ioctls.h          |   3 +
 arch/alpha/include/uapi/asm/termbits.h        |   1 +
 arch/mips/include/uapi/asm/ioctls.h           |   3 +
 arch/mips/include/uapi/asm/termbits.h         |   1 +
 arch/parisc/include/uapi/asm/ioctls.h         |   3 +
 arch/parisc/include/uapi/asm/termbits.h       |   1 +
 arch/powerpc/include/uapi/asm/ioctls.h        |   3 +
 arch/powerpc/include/uapi/asm/termbits.h      |   1 +
 arch/sh/include/uapi/asm/ioctls.h             |   3 +
 arch/sparc/include/uapi/asm/ioctls.h          |   3 +
 arch/sparc/include/uapi/asm/termbits.h        |   1 +
 arch/xtensa/include/uapi/asm/ioctls.h         |   3 +
 drivers/char/pcmcia/synclink_cs.c             |   2 +
 drivers/ipack/devices/ipoctal.c               |   2 +
 drivers/mmc/core/sdio_uart.c                  |   2 +
 drivers/net/usb/hso.c                         |   3 +-
 drivers/s390/char/tty3270.c                   |   3 +
 drivers/staging/greybus/uart.c                |   2 +
 drivers/tty/amiserial.c                       |   6 +-
 drivers/tty/moxa.c                            |   1 +
 drivers/tty/mxser.c                           |   1 +
 drivers/tty/serial/8250/8250_core.c           |   6 +-
 drivers/tty/serial/8250/8250_dwlib.c          | 232 +++++++++++++++++-
 drivers/tty/serial/8250/8250_dwlib.h          |   5 +
 drivers/tty/serial/8250/8250_lpss.c           |   2 +-
 drivers/tty/serial/8250/8250_port.c           |  14 +-
 drivers/tty/serial/serial_core.c              |  62 +++++
 drivers/tty/synclink_gt.c                     |   2 +
 drivers/tty/tty_io.c                          |   2 +
 drivers/tty/tty_ioctl.c                       |   2 +
 drivers/usb/class/cdc-acm.c                   |   2 +
 drivers/usb/serial/usb-serial.c               |   6 +-
 include/linux/serial_8250.h                   |   7 +-
 include/linux/serial_core.h                   |   6 +
 include/uapi/asm-generic/ioctls.h             |   3 +
 include/uapi/asm-generic/termbits.h           |   1 +
 include/uapi/linux/serial.h                   |   8 +
 net/bluetooth/rfcomm/tty.c                    |   2 +
 41 files changed, 445 insertions(+), 18 deletions(-)

-- 
2.30.2

