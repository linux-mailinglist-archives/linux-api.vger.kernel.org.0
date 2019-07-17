Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072296B366
	for <lists+linux-api@lfdr.de>; Wed, 17 Jul 2019 03:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfGQB3m (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jul 2019 21:29:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46887 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGQB3N (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jul 2019 21:29:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id c73so9961846pfb.13
        for <linux-api@vger.kernel.org>; Tue, 16 Jul 2019 18:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=/JCMTovNsMOTb4V8NbJUn4gtZFBomdigf57eMm4vvwA=;
        b=lx7DMwJwb44W7Tsx+wtQGpeBhtEGmLrTQeHhVfpNHKCPvBD3EZccrC+x1nOiZ399Ox
         Ce7qyy+Rjzuxnpqy8yeYrgqjTmrF1e4jLl6TgE3ixOT/U87rKHP/GwhBwHUCMYYMBtSX
         XTxaPmwymA5BLTwz52iRqFqvtSq/Vds0zwWqSBqBhCoTjEmDNRyJXxv1Z31bPto7petN
         4K4DlHQcEWAQRcfUEdZhqZdNL8Hu1gE5jSIKmzD34yWc3h67AlA1Bsy7Mb4SoM0dQh/o
         8yYfnpbjmU1EbMOju/emLtWoEWPcrjXBQNL7vtCS5P7kJATFe6R2UYNx/eNwEOEaDppF
         HG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=/JCMTovNsMOTb4V8NbJUn4gtZFBomdigf57eMm4vvwA=;
        b=icTTWPtX/5EhFxL7Bp1W1JjyKn5ddVWycsX8fMuHpLBG09PTqQmTTLVYeVtorSayyx
         lVSeOWuVlV3oWKQKUxd7A3zoqr9OAGD7FoK2jK55v6vvAq7uGuxVfnMGCYbJNdV2MlTD
         xolwnRMbddzyqUbRKIW1Lt7cYfamtaSKqm/nH91UtZI8Wui6wjv+WUiXySL5MCRc2BgB
         4ARRs+KBlulpvg2AexbRQ93uhvHtIDdZGbvI48FkB6Curw+BXF0yiC/rYh/DTbkWqNQY
         mTBWdk+oGYHqnR9/X2J/VBIVBvhiMrGbynjyMjT/639saJGiVBRgjmSLqtIndbakszEH
         WuQA==
X-Gm-Message-State: APjAAAXAMY8ePa2prrZXe+Ovt/qN/SXCKHHtF9bjxaDDEpmuthIiDhyA
        dWJLJk/fkMTFXdQg5UNWXCW47w==
X-Google-Smtp-Source: APXvYqyg4YmraVYF5BPtOY0Mh+Db31ThY69mi6xzsSYevYAi9Xz9ds0qvpgX9gVnM7rPKcCcJUwZJg==
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr5653774pjb.115.1563326953172;
        Tue, 16 Jul 2019 18:29:13 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x67sm24955724pfb.21.2019.07.16.18.29.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 18:29:12 -0700 (PDT)
Subject: [PATCH v2 1/4] Non-functional cleanup of a "__user * filename"
Date:   Tue, 16 Jul 2019 18:27:16 -0700
Message-Id: <20190717012719.5524-2-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717012719.5524-1-palmer@sifive.com>
References: <20190717012719.5524-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org,
        monstr@monstr.eu, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        peterz@infradead.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        dhowells@redhat.com, firoz.khan@linaro.org, stefan@agner.ch,
        schwidefsky@de.ibm.com, axboe@kernel.dk, christian@brauner.io,
        hare@suse.com, deepa.kernel@gmail.com, tycho@tycho.ws,
        kim.phillips@arm.com, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The next patch defines a very similar interface, which I copied from
this definition.  Since I'm touching it anyway I don't see any reason
not to just go fix this one up.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2bcef4c70183..e1c20f1d0525 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -431,7 +431,7 @@ asmlinkage long sys_chdir(const char __user *filename);
 asmlinkage long sys_fchdir(unsigned int fd);
 asmlinkage long sys_chroot(const char __user *filename);
 asmlinkage long sys_fchmod(unsigned int fd, umode_t mode);
-asmlinkage long sys_fchmodat(int dfd, const char __user * filename,
+asmlinkage long sys_fchmodat(int dfd, const char __user *filename,
 			     umode_t mode);
 asmlinkage long sys_fchownat(int dfd, const char __user *filename, uid_t user,
 			     gid_t group, int flag);
-- 
2.21.0

