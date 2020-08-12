Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E05B242437
	for <lists+linux-api@lfdr.de>; Wed, 12 Aug 2020 05:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHLDRS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Aug 2020 23:17:18 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:34493 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgHLDRR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Aug 2020 23:17:17 -0400
Received: by mail-io1-f69.google.com with SMTP id 127so655004iou.1
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 20:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2FxaZz2wzxy2yGxxRulgV5SYGolbOKGdFSA96kJFpbE=;
        b=leVRUS9QSvQczJ5BTg9rZaEA3oJkgztvHyXfQkOgGWSqVwsrWo2l98BciADZ8clj+B
         yaHRCTdRIabKROmBRN/W2XaTlOaujpXL60A36Phvtydx4r1SPudsRb3WEd61EqOyXmb7
         Vps3XVPFoCekzesXd5L1M0RguFKQQ7x8LYwXSzQM5HrIg95ZFNuENTJzDGsaNDGNqq7K
         NJz6+nc7AmUlPklylxrqQfQEUHe6TAuOv5ZWJzv7yW3wM0wDdUctMdtagX0nVQQiRQJJ
         Hky8gcwCycwGooP53b/XDrCLkEUb8LN/yIw1HN+b2oy9XoteMnQtM+aF9Ml7Oh5ec7Ai
         hUEA==
X-Gm-Message-State: AOAM532Pyi93xnuFwlZRsURC7KPZXNkAVYDQaRnx/x2XAztpWQiv4lwW
        0evjJXYzONG1e1gjFgvlrZzOPCaLfRL0We56smtmFDqQk0AM
X-Google-Smtp-Source: ABdhPJyhViwJRe11cEFZ/5sPX7qOSHXuy/RZXOu9nQNmAP9bJCnnNMWBXMKSc/bmO4qQY0ZfTyVqxMslTn2CbN8qkg+8DWhHrmfE
MIME-Version: 1.0
X-Received: by 2002:a5e:991a:: with SMTP id t26mr25266609ioj.7.1597202236468;
 Tue, 11 Aug 2020 20:17:16 -0700 (PDT)
Date:   Tue, 11 Aug 2020 20:17:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0724405aca59f64@google.com>
Subject: KASAN: use-after-free Read in path_init (2)
From:   syzbot <syzbot+bbeb1c88016c7db4aa24@syzkaller.appspotmail.com>
To:     arnd@arndb.de, christian.brauner@ubuntu.com, hch@lst.de,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5631c5e0 Merge tag 'xfs-5.9-merge-7' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17076984900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afba7c06f91e56eb
dashboard link: https://syzkaller.appspot.com/bug?extid=bbeb1c88016c7db4aa24
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1502ce02900000

The issue was bisected to:

commit e24ab0ef689de43649327f54cd1088f3dad25bb3
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Jul 21 08:48:15 2020 +0000

    fs: push the getname from do_rmdir into the callers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155f36c2900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=175f36c2900000
console output: https://syzkaller.appspot.com/x/log.txt?x=135f36c2900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bbeb1c88016c7db4aa24@syzkaller.appspotmail.com
Fixes: e24ab0ef689d ("fs: push the getname from do_rmdir into the callers")

==================================================================
BUG: KASAN: use-after-free in path_init+0x116b/0x13c0 fs/namei.c:2207
Read of size 8 at addr ffff88807853c940 by task syz-executor.2/8233

CPU: 0 PID: 8233 Comm: syz-executor.2 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 path_init+0x116b/0x13c0 fs/namei.c:2207
 path_parentat+0x22/0x1b0 fs/namei.c:2384
 filename_parentat+0x188/0x560 fs/namei.c:2407
 do_rmdir+0xa8/0x440 fs/namei.c:3732
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ce79
Code: 2d b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb b5 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f756fb2bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00000000000260c0 RCX: 000000000045ce79
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RBP: 000000000118bff0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bfcc
R13: 00007ffedeb9931f R14: 00007f756fb2c9c0 R15: 000000000118bfcc

Allocated by task 8233:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 kmem_cache_alloc+0x12c/0x3b0 mm/slab.c:3484
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:138
 getname_flags include/linux/audit.h:320 [inline]
 getname fs/namei.c:209 [inline]
 __do_sys_rmdir fs/namei.c:3783 [inline]
 __se_sys_rmdir fs/namei.c:3781 [inline]
 __x64_sys_rmdir+0xb1/0x100 fs/namei.c:3781
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 8233:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0xf5/0x140 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kmem_cache_free+0x7f/0x310 mm/slab.c:3694
 putname+0xe1/0x120 fs/namei.c:259
 do_rmdir+0x145/0x440 fs/namei.c:3773
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88807853c940
 which belongs to the cache names_cache of size 4096
The buggy address is located 0 bytes inside of
 4096-byte region [ffff88807853c940, ffff88807853d940)
The buggy address belongs to the page:
page:ffffea0001e14f00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffea0001e14f00 order:1 compound_mapcount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea0001e14e88 ffffea0001e14f88 ffff8880aa246380
raw: 0000000000000000 ffff88807853c940 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88807853c800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807853c880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807853c900: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                           ^
 ffff88807853c980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807853ca00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
