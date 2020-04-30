Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6251BF11D
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 09:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgD3HRL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 03:17:11 -0400
Received: from mail.cs.msu.ru ([188.44.42.39]:50569 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbgD3HRH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 Apr 2020 03:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tEDmyAeTVaJQAXX/tYgqsMG0JAQjwAQDWEMYp2A5wz8=; b=UXFgYcPfBdCPbu9QN9j6amzDOi
        nzdFHFvnQijp9FPzaHzPqFmcPjCevt6mYGNsTTyOqt1FwWZ8PY/BqCKlsGgNH4ibEtdcSbfVOXTAG
        1zG5uzQh2ehgpFQwiM0oAD24Y7yHM8rUlYnZgefnua/RH2Gt0TyoLVt0zoO1MUESwiB6bXYHOwCOr
        IKPOvHTgZfVnvvh2UoZEkxLIIF5TNlAb9k7Xu9E9EZ3nAnke8Z6PMjmvieXYGMAUlil67PRKBTDuk
        IZlXFcsD854UcFTTniBiY6nrbIxBPyDgoWqdYQGS8WVdLPe54qKdgG90qpcKRyZ9QPZAI2A/l275l
        oQapGwcA==;
Received: from [37.204.119.143] (port=42272 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93.0.4 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1jU2ut-000B4I-SG; Thu, 30 Apr 2020 09:43:28 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arseny Maslennikov <ar@cs.msu.ru>, Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, linux-api@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>
Date:   Thu, 30 Apr 2020 09:42:54 +0300
Message-Id: <20200430064301.1099452-1-ar@cs.msu.ru>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.cs.msu.ru
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_ADSP_ALL autolearn=no autolearn_force=no version=3.4.4
Subject: [PATCH v3 0/7] TTY Keyboard Status Request
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch series introduces TTY keyboard status request, a feature of
the n_tty line discipline that reserves a character in struct termios
(^T by default) and reacts to it by printing a short informational line
to the terminal and sending a Unix signal to the tty's foreground
process group. The processes may, in response to the signal, output a
textual description of what they're doing.

The feature has been present in a similar form at least in
Free/Open/NetBSD; it would be nice to have something like this in Linux
as well. There is an LKML thread[1] where users have previously
expressed the rationale for this.

The current implementation does not break existing kernel API in any
way, since, fortunately, all the architectures supported by the kernel
happen to have at least 1 free byte in the termios control character
array.

Patches 1-4 implement the semantics of the new signal and VSTATUS cc;
patches 5-7 implement the kerninfo line written to the terminal by n_tty.

The series should cleanly apply to tty-next and 5.7-rc3.

[1] https://lore.kernel.org/lkml/1415200663.3247743.187387481.75CE9317@webmail.messagingengine.com/

v2 <- v1: removed useless debugging bits.
v3 <- v2: made commit message clarifications sparked by previous
discussion, adapted 7/7 for y2038, re-Cc linux-api@.

Discussion of v1:
https://lore.kernel.org/lkml/20190605081906.28938-1-ar@cs.msu.ru/
Discussion of v2:
https://lore.kernel.org/lkml/20190625161153.29811-1-ar@cs.msu.ru/

Arseny Maslennikov (7):
  signal.h: Define SIGINFO on all architectures
  tty: termios: Reserve space for VSTATUS in .c_cc
  n_tty: Send SIGINFO to fg pgrp on status request character
  linux/signal.h: Ignore SIGINFO by default in new tasks
  tty: Add NOKERNINFO lflag to termios
  n_tty: ->ops->write: Cut core logic out to a separate function
  n_tty: Provide an informational line on VSTATUS receipt

 arch/alpha/include/asm/termios.h         |   4 +-
 arch/alpha/include/uapi/asm/termbits.h   |   2 +
 arch/arm/include/uapi/asm/signal.h       |   1 +
 arch/h8300/include/uapi/asm/signal.h     |   1 +
 arch/ia64/include/asm/termios.h          |   4 +-
 arch/ia64/include/uapi/asm/signal.h      |   1 +
 arch/ia64/include/uapi/asm/termbits.h    |   2 +
 arch/m68k/include/uapi/asm/signal.h      |   1 +
 arch/mips/include/asm/termios.h          |   4 +-
 arch/mips/include/uapi/asm/signal.h      |   1 +
 arch/mips/include/uapi/asm/termbits.h    |   2 +
 arch/parisc/include/asm/termios.h        |   4 +-
 arch/parisc/include/uapi/asm/signal.h    |   1 +
 arch/parisc/include/uapi/asm/termbits.h  |   2 +
 arch/powerpc/include/asm/termios.h       |   4 +-
 arch/powerpc/include/uapi/asm/signal.h   |   1 +
 arch/powerpc/include/uapi/asm/termbits.h |   2 +
 arch/s390/include/asm/termios.h          |   4 +-
 arch/s390/include/uapi/asm/signal.h      |   1 +
 arch/sparc/include/asm/termios.h         |   4 +-
 arch/sparc/include/uapi/asm/signal.h     |   2 +
 arch/sparc/include/uapi/asm/termbits.h   |   2 +
 arch/x86/include/uapi/asm/signal.h       |   1 +
 arch/xtensa/include/uapi/asm/signal.h    |   1 +
 arch/xtensa/include/uapi/asm/termbits.h  |   2 +
 drivers/tty/Makefile                     |   3 +-
 drivers/tty/n_tty.c                      |  70 ++++-
 drivers/tty/n_tty_status.c               | 338 +++++++++++++++++++++++
 include/asm-generic/termios.h            |   4 +-
 include/linux/sched.h                    |   7 +
 include/linux/signal.h                   |   5 +-
 include/linux/tty.h                      |   7 +-
 include/uapi/asm-generic/signal.h        |   1 +
 include/uapi/asm-generic/termbits.h      |   2 +
 34 files changed, 458 insertions(+), 33 deletions(-)
 create mode 100644 drivers/tty/n_tty_status.c

-- 
2.26.2

