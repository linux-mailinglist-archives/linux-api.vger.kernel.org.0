Return-Path: <linux-api+bounces-4800-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79A6B56508
	for <lists+linux-api@lfdr.de>; Sun, 14 Sep 2025 05:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7D9423F63
	for <lists+linux-api@lfdr.de>; Sun, 14 Sep 2025 03:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1C26F47D;
	Sun, 14 Sep 2025 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnfVFf76"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5DA26B747
	for <linux-api@vger.kernel.org>; Sun, 14 Sep 2025 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822018; cv=none; b=HlS50/7tVixYIQOiR6tHgGvSinNWkbQEWXvDWtNMQiQuKKUcrrc9eQeAOtwkVbxhI9eHVqhRVND3fk2rlehggQTebNLCvIgxbpt9OIl+UNuHlnSRrrLt6iX9TScW4bmS18VBBNwiB5dw2YaCs5c3z7IwT5RYn1ogDI88GpRsAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822018; c=relaxed/simple;
	bh=FZoweijhihxtu6HrPrxAC18gjv4DF8N0f7D122SferU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMkhyI5AEXUFaxwtdKWugC5GbghvJ6rljuqKLJK/kM1/hTEKp5LQ5nfDbQMjOb6BSCvoVMzWXZVkPK/5gqBOj4uiHtovTlBD4OFmlI4Vu/miUOpZc28WzKgGNmu4y+dL0/LjdWE7eNc6pxkgIWUKaBbX1/6Im5UFUE3PDzw58z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnfVFf76; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62ef469bb2cso2847385a12.2
        for <linux-api@vger.kernel.org>; Sat, 13 Sep 2025 20:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822013; x=1758426813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB2E9PPBAv72v29AyxICCzYyZlb0WEV+ovfXoPOatKs=;
        b=lnfVFf762khiYz0FDgghMlXPGvOITxGCtk+wu9qrbN5hxLRAJ1gs2+ppk7BKe0HXlG
         G5OREfPjiRmY8EwPfB8G4xt1X/oakdJZUIVKAQidEaQcGSNKY/+M0I9BNsBTVp63txq9
         mWNSh2WPW1lcIW6EbcZonrtOLr+rPOcWu02CjDYUuTOSmFZo9hjdGaUQTIax5JlCS+NZ
         TNYxrphaJHRheaHZZPcAmZYwIMBqEB73xXkFvBqUDa4R/U5otIgxVvxeHp4zNeeaJNCP
         7lKrRo7Ge+7IBKugxANcXh/v7/I3r3NwkZPsvZtjWj9jftx6y6vKzysCIfWd+kJWivtX
         fbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822013; x=1758426813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PB2E9PPBAv72v29AyxICCzYyZlb0WEV+ovfXoPOatKs=;
        b=YvLJ0dO75OD1dKdh6Xn5eXBtQJV8cOOFpqCw2cPzxgD4j+m70wOqqxSictf10rEPSW
         v+MWAcYoudrHoJCOMOgyF1r8OqT07F+Og4FDUfEjLYKxQVc02Mt5dlYlBUagF0RWzIva
         l6jS44MFrGk6Y+HzQVMz6Zg2VQPWl34M4aabuDMgQ1lI1qsTn/GflFHxPDOA+t/8QfCv
         QZTFn8bqGsfUBIA1dC2dJ3hY4gFqzHQeQaRkFkFtmqPXed3cenWxTL1LifnpaHwRLVIA
         9yOdH/HX50eDmEOJddDa1oYvP6foOYZ1/CDxg6RW0f8m7PRtEFfzTCC+xSuCPWqL8Yce
         k9jg==
X-Forwarded-Encrypted: i=1; AJvYcCXGOcV511qdNUwcYle5Lek3OdnPCWVRuO1VEQsrV9JbI6QrkjdJhU9nXWyVAtavYQ0bX2eUtZLsHUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxGwcQhZr6G0CKXGS51JVODi/447eDykjZ3f+9f9UwySrpjRP7
	CbMUujHSasC/mDytHTLiHQMxoEl3ZqkeHclOU8GiTU9VcGP6zfZNXB89
X-Gm-Gg: ASbGnctufzVkJrv58DhjhIvl0+0I/rNqDNXAJDmSf1pWCYq4ZjIJ2mYllukCLo0vLbc
	dguMvG5RCqGcALlovtOwUUWJx0JWdSjpRHhTQi5bGsWxBV7AR3GH0o8WpMtQK81b0YXh8k15UHk
	7SX4K2nK/Hky5dmKnN8VgxbP7FryA9K6T94a98Psi+7neTRAB6Lqq0wivBeLy2G+P5StknrzLuo
	Z3tJ2IQ51426487sF8lut2QbE8lqc7waZhD+oihem7cwXypV/akjv8mQYRuIFIvmQlYJQ9UlKI4
	8b9glLCT3sgg4cm4yN5DpRVuWOV7lIk7hvbGjs2Z3tVm1UrD2lOEpaSi1KC2M33t+oiBmqHJ8Pt
	skfDplTM1Tyc5axpga60Hy/hzv79pEA==
X-Google-Smtp-Source: AGHT+IGUQXhZVcMzH5x4qrxgNQpCZ4sYyZ3ugDsvfNumu2I8pECs9df4oC+H+CMnm997jPnr5crTug==
X-Received: by 2002:a05:6402:2111:b0:61d:2096:1e92 with SMTP id 4fb4d7f45d1cf-62ed82614c4mr7020136a12.15.1757822012514;
        Sat, 13 Sep 2025 20:53:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33f3a5esm6570485a12.30.2025.09.13.20.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:53:32 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 43/62] setsid: inline ksys_setsid into the only caller
Date: Sun, 14 Sep 2025 06:53:26 +0300
Message-ID: <20250914035326.3661003-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 include/linux/syscalls.h | 1 -
 kernel/sys.c             | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 77f45e5d4413..75e9ee03d19b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1231,7 +1231,6 @@ int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 void ksys_sync(void);
 int ksys_unshare(unsigned long unshare_flags);
-int ksys_setsid(void);
 int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 			 unsigned int flags);
 ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
diff --git a/kernel/sys.c b/kernel/sys.c
index 1e28b40053ce..66e1e2dfd585 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1265,7 +1265,7 @@ static void set_special_pids(struct pid **pids, struct pid *pid)
 		change_pid(pids, curr, PIDTYPE_PGID, pid);
 }
 
-int ksys_setsid(void)
+SYSCALL_DEFINE0(setsid)
 {
 	struct task_struct *group_leader = current->group_leader;
 	struct pid *sid = task_pid(group_leader);
@@ -1300,11 +1300,6 @@ int ksys_setsid(void)
 	return err;
 }
 
-SYSCALL_DEFINE0(setsid)
-{
-	return ksys_setsid();
-}
-
 DECLARE_RWSEM(uts_sem);
 
 #ifdef COMPAT_UTS_MACHINE
-- 
2.47.2


