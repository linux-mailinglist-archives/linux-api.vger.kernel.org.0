Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495A02448B4
	for <lists+linux-api@lfdr.de>; Fri, 14 Aug 2020 13:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHNLKA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Aug 2020 07:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgHNLJ7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Aug 2020 07:09:59 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677D1C061384;
        Fri, 14 Aug 2020 04:09:59 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4BSgh60PrdzQkKx;
        Fri, 14 Aug 2020 13:09:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
        t=1597403396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=URVnzukKS+P2nWYrtw5dp7rwGBO9XtEHJXqL8SP6zO8=;
        b=FKJp/2f7zJR5l/5hiMOgulaPaejhBMwSGqCGG3tB/vy9BI7AaTwJCLW/G7iq5trV1RbL7+
        SiDgA2cy2JUPu4tE7UNG5jjCenGCxflGrIg+4HTWPGI+BcfpWN/mbDBAhSwMJk02wUygoU
        dVfoI4CU/keOwYWY1tDlVEVSCtdD8PE2IghtWo8W8+HxH7beNIlz556k4j3GeOspP1ecjR
        tqKixfrfSmApcozVqeBhBLtxha3RNtJAeCp3uqUyChI+t36Vz5HDSXlDPXBUZGofyLD2aH
        0FjbCJoRhwTCm/CDP3Gtk0iIrsmjYHpaJqDZr9aRbZIRfmpQDCkma9qwOklnLA==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 25-4Vo5YHmDQ; Fri, 14 Aug 2020 13:09:55 +0200 (CEST)
From:   Devin Bayer <dev@doubly.so>
Subject: setsid2(sid) proposal - assign current process to existing session
To:     linux-api@vger.kernel.org, linux-console@vger.kernel.org
Message-ID: <ecede52e-1f5d-8357-37f8-948456688862@doubly.so>
Date:   Fri, 14 Aug 2020 13:09:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.34 / 15.00 / 15.00
X-Rspamd-Queue-Id: 139281738
X-Rspamd-UID: 42c21a
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello,

I'm wondering about the possibility of introducing a new system call for 
moving a process to an existing session. If `sid` is an existing session 
with the same owner as the current process, one could call:

	setsid2(sid)

This would have similar behavior to setpgid(), and would probably 
effectively call setpgid() internally too.

The use case is for something like `flatpak-spawn --host`, which allows 
you to launch a program in an outer namespace from an inner namespace. 
It behaves as a child of the caller but is actually a child of an 
external daemon.

It works by connecting stdin/out/err to those of the caller, for example 
a PTY for xterm running in the inner namespace. This works fine for 
non-interactive programs, but it's impossible for the spawned task to 
share the controlling TTY with the shell running in xterm.

I can't see where the problems are, though I'm surprised such 
functionally doesn't yet exist. Because it deals with such basic 
concepts, I'm wondering if such a change will even be considered.

There is a workaround; one can create a new PTY on the host and copy the 
I/O streams manually. Not ideal, but okay.

Any comments welcome.

Cheers
~ dev
