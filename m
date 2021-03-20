Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6AD342E60
	for <lists+linux-api@lfdr.de>; Sat, 20 Mar 2021 17:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCTQbP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 20 Mar 2021 12:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhCTQaw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 20 Mar 2021 12:30:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2543C061574;
        Sat, 20 Mar 2021 09:30:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id jy13so14486025ejc.2;
        Sat, 20 Mar 2021 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=krowSy1qOb6baq8siG2DkcMBMFG/XPZkvaDkKFj+3Jk=;
        b=V3dQbMpC5FUnNbOCzKlRG8CeS1LagpymcblrFYVop9Cek9l35jtwY6Wz1maEZ0XPwh
         ++FZ7BdeNlxVf1oyxiuqiPUL2EtglhsoPo6EXmLXx3DSRWuisf69q72/gubK2deZjYPu
         awQwAUpqD2t+PdfTL8MLhxLELJFf2Dm4UyNtIWCUENLqdh1EPt7AE61Glh9mp24BF5T/
         5O6/qAyjcbju8PzGsSCjl8GEQ7hVfVLPY2lYsPr50cvfL1SRhWz2W89bIC0vxFZDqBtz
         KGKJBxR3cDiOx5OBDJzG1B5d6jEva8BNh/0H7ukiK7B3YCjUenEA+0Un+ZHZ5ugid7hv
         Dl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=krowSy1qOb6baq8siG2DkcMBMFG/XPZkvaDkKFj+3Jk=;
        b=soQDYEBu1O/eapTwNxFoex6lit3aQ6ZWsvBWYzx0EnWOItOIdwA2vZXXr4gjgha1I1
         NO2SAuU3mASQj631iNFZdHY4eTL8WZkbQYrghHey7S3owtlYB07Cy8QwpFYMO1IWgCJN
         UfjSsNeh3zhnKHQrCDyn4i1p5gQo+y17ZWFRMzXN/JD0HkFxFKJROBja2FlwffvREun9
         V3A1e7JIr4klFl6SSy9mws3vmSTZbZfoqYQaMwmlksCnldqernH/NQUGJ5NUkBYZ8bZF
         gbJd2cfGappfv5MgkPCd9qBZa+nwvngyDhdxKoHetZ1hDcdrNXd+fwbVGNiVuTiL4ztw
         uS8w==
X-Gm-Message-State: AOAM531viiMLiimfhSjBEUBGyUnG9stwaJIHbdR0GIssHvyEs6kBYVsi
        jFclSgImGEG+nQfRV91cymZ+ZCn+rw==
X-Google-Smtp-Source: ABdhPJyJKj0ZeyRftCS1MN7KQhjxbWY8QZs+IuW/htFQlAMXfRbXdkN7aPLXrA6uYCWs6slYVqyOVg==
X-Received: by 2002:a17:906:e2d4:: with SMTP id gr20mr10683539ejb.432.1616257850724;
        Sat, 20 Mar 2021 09:30:50 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.213])
        by smtp.gmail.com with ESMTPSA id v24sm5586298ejw.17.2021.03.20.09.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 09:30:50 -0700 (PDT)
Date:   Sat, 20 Mar 2021 19:30:48 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH] Document that PF_KTHREAD _is_ ABI
Message-ID: <YFYjOB1jpbqyNPAp@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

PF_KTHREAD value is visible via field number 9 of /proc/*/stat

	$ sudo cat /proc/2/stat
	2 (kthreadd) S 0 0 0 0 -1 2129984 0 ...
				  ^^^^^^^

It is used by at least systemd to check for kernel-threadness:
https://github.com/systemd/systemd/blob/main/src/basic/process-util.c#L354
src/basic/process-util.c:is_kernel_thread()

It means that the value can't be changed despite perceived notion that
task_struct flags are internal to kernel and can be shuffled at whim.

Formally, _all_ struct task_struct::flags PF_* values are kernel ABI
which is a disaster.

I hope we can mask everything but few flags and hope for the best :^)

Note for beginner Linux programmers:
every other way you find on the interwebs and Stack Overflow
for checking if pid belongs to a kernel thread is broken one way or
another.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/sched.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1566,6 +1566,9 @@ extern struct pid *cad_pid;
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
 #define PF_LOCAL_THROTTLE	0x00100000	/* Throttle writes only against the bdi I write to,
 						 * I am cleaning dirty pages from some other bdi. */
+/*
+ * PF_KTHREAD is part of kernel ABI, visible via value #9 in /proc/$pid/stat
+ */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
