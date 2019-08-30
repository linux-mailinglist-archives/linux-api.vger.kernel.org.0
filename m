Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490D4A2C18
	for <lists+linux-api@lfdr.de>; Fri, 30 Aug 2019 03:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfH3BLp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Aug 2019 21:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfH3BLp (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Aug 2019 21:11:45 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A1021726;
        Fri, 30 Aug 2019 01:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567127504;
        bh=cxG/Csv0dO0dzHh0hw8hEJaJviptwRvJ+VuvpnA+zQ4=;
        h=From:To:Cc:Subject:Date:From;
        b=l/e54Qwqc4S7T7xLPRTF6aL4Jp+Ft+XfOURSQfTJJcFanYajZm4eXqJvTB/OWotdG
         e/Z4n40q+Lpn5mGyt7s9me5IKpUekh65VHkFqGcCsx0O7PwtDupXtBV+/1hsbyShOO
         lxQPHtbVUafs469dKHT7RY8OanI7Fq4cbzJy4+hM=
From:   Andy Lutomirski <luto@kernel.org>
To:     Theodore Tso <tytso@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/7] Rework random blocking
Date:   Thu, 29 Aug 2019 18:11:35 -0700
Message-Id: <cover.1567126741.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This makes two major semantic changes to Linux's random APIs:

It adds getentropy(..., GRND_INSECURE).  This causes getentropy to
always return *something*.  There is no guarantee whatsoever that
the result will be cryptographically random or even unique, but the
kernel will give the best quality random output it can.  The name is
a big hint: the resulting output is INSECURE.

The purpose of this is to allow programs that genuinely want
best-effort entropy to get it without resorting to /dev/urandom.
Plenty of programs do this because they need to do *something*
during boot and they can't afford to wait.  Calling it "INSECURE" is
probably the best we can do to discourage using this API for things
that need security.

This series also removes the blocking pool and makes /dev/random
work just like getentropy(..., 0) and makes GRND_RANDOM a no-op.  I
believe that Linux's blocking pool has outlived its usefulness.
Linux's CRNG generates output that is good enough to use even for
key generation.  The blocking pool is not stronger in any material
way, and keeping it around requires a lot of infrastructure of
dubious value.

This series should not break any existing programs.  /dev/urandom is
unchanged.  /dev/random will still block just after booting, but it
will block less than it used to.  getentropy() with existing flags
will return output that is, for practical purposes, just as strong
as before.

Andy Lutomirski (7):
  random: Don't wake crng_init_wait when crng_init == 1
  random: Add GRND_INSECURE to return best-effort non-cryptographic
    bytes
  random: Ignore GRND_RANDOM in getentropy(2)
  random: Make /dev/random be almost like /dev/urandom
  random: Remove the blocking pool
  random: Delete code to pull data into pools
  random: Remove kernel.random.read_wakeup_threshold

 drivers/char/random.c       | 234 ++++--------------------------------
 include/uapi/linux/random.h |   4 +-
 2 files changed, 27 insertions(+), 211 deletions(-)

-- 
2.21.0

