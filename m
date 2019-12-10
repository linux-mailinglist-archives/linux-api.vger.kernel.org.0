Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 139F5117D40
	for <lists+linux-api@lfdr.de>; Tue, 10 Dec 2019 02:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLJBiC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Dec 2019 20:38:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:43622 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfLJBiB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Dec 2019 20:38:01 -0500
Received: by mail-il1-f197.google.com with SMTP id j17so13164672ilc.10
        for <linux-api@vger.kernel.org>; Mon, 09 Dec 2019 17:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=d/rLwgpGcOLrJAfYzylpfLq8TO3Ppq0ukiadwzb7btY=;
        b=UTPaXsRug35TNPG9OWrPWhPlcnQr8LddDohcEfPnaplrExDgdTed4t3sC6yv4yzPMQ
         JX3Az+asUxU7HQmk7kzR2EcJsRSXwK7/1Udc/Hw6/K36La5VymfS7ajH3b0kyIC217pp
         V1jM0PHlZImmkgAsiT+8/gTEjZSm9QlI9Gwph0qRnXV3tV//rjwKSyq36vadIncggAaX
         y+4tQukc3wzl0TZcrjFUNKDJkQ2UXv3lnshjBxtrRSzas3MMk3JFs6iXjL7FFLzUNaKL
         ks86Bjb18Z2x4b11HxInCR0LQnX/UGHM/fHuRsy0lY/ss1SHTtpM5jOD6ZayYXQb/CNd
         sxVQ==
X-Gm-Message-State: APjAAAVpiVNeNpPNe6FWIWm9n1qQwvOjHbtkKmgztICc7voYBMRi6cUy
        hvJTVck87kVmTITvyOZwda0FP9J52BMoOqu0oq/Zmm0Lbsns
X-Google-Smtp-Source: APXvYqx3F0Ru+DmMowW3EN6d2QYATYtlFpjQe/HbQv1AYpW3UNnTiZ8L2MNSyTDTtQA/qzP66Ug/fqFZPiweGeK/5P/FGvCtPAyx
MIME-Version: 1.0
X-Received: by 2002:a6b:5b12:: with SMTP id v18mr24150486ioh.112.1575941881185;
 Mon, 09 Dec 2019 17:38:01 -0800 (PST)
Date:   Mon, 09 Dec 2019 17:38:01 -0800
In-Reply-To: <00000000000044a65205994a7e13@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003cc8505994f9036@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in mem16_serial_out
From:   syzbot <syzbot+92f32d4e21fb246d31a2@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, asierra@xes-inc.com,
        corbet@lwn.net, ext-kimmo.rautkoski@vaisala.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        kai.heng.feng@canonical.com, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, mika.westerberg@linux.intel.com,
        paulburton@kernel.org, peter@hurleysoftware.com, sr@denx.de,
        syzkaller-bugs@googlegroups.com, yamada.masahiro@socionext.com,
        yegorslists@googlemail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

syzbot has bisected this bug to:

commit bd94c4077a0b2ecc35562c294f80f3659ecd8499
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed Oct 28 03:46:05 2015 +0000

     serial: support 16-bit register interface for console

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13723196e00000
start commit:   e42617b8 Linux 5.5-rc1
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10f23196e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17723196e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3754e2c78c1adb82
dashboard link: https://syzkaller.appspot.com/bug?extid=92f32d4e21fb246d31a2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136f7e41e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112b7c82e00000

Reported-by: syzbot+92f32d4e21fb246d31a2@syzkaller.appspotmail.com
Fixes: bd94c4077a0b ("serial: support 16-bit register interface for  
console")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
