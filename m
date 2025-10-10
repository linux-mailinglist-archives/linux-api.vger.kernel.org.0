Return-Path: <linux-api+bounces-5064-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B553BBCC641
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 11:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39CE135509F
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 09:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BE82C21FA;
	Fri, 10 Oct 2025 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc/QyZ0r"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CAC2C2356
	for <linux-api@vger.kernel.org>; Fri, 10 Oct 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089289; cv=none; b=pbVeWBSlHYlLG6j2NJw0SJE8lhTSO/GTDVVlyLC2zrMvbqdulk3q5QAVyTU5pDLMgNfRyR5GSeiZED53daYPNZdZZPTI9XOLA+ryLrG+HMNNd7Hi6IQSs11MKK3faGS6y4FPVqjyK+eVoU1wULf1uebup8+FoDYmzWugIe5KfsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089289; c=relaxed/simple;
	bh=MuTIfJDXeKuuHRy0YR/4p4wSgA5RdL8NKtUcZ5ZUNMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XYVLS+zJ3OD0VX1OzWd9vXqAEF3Smch8GMJONg3gMfFY94M45jNiL5yJ0bbM5JCng3wmCBKe98dx1ScCA72Buxfi0Nx5GhwTQ1D9Z1n/e7dwzhFKNKXNQ+iziOtHf0Sg/mq+a8/siWn6HZobYgVsjVV4qzpRO9/9V7MX7BFoFQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc/QyZ0r; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so926150f8f.1
        for <linux-api@vger.kernel.org>; Fri, 10 Oct 2025 02:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760089279; x=1760694079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq9sBzt27xhVE00MKRZHgRlmEb4HHQG1wzN2xa1Axvc=;
        b=bc/QyZ0rRHG7Q1K/vSrqIr/YpYXynHJ/dwTYESMEMqgNGtN3lObS7c/K2Bx/WiE3LH
         KYaIf6Zy8LCjvEmabKooSgLqRpGBLzEkTalJ2DiNdbLYNLoYj63Xc9eX3Xzxw2G59vns
         HynK9okqQ9jqMS0e84RxzpBb6WHXCCZjEUXVVodrqFqiMm6krfZ42/Xo3K1i5hQxU9/u
         tJ2h94r5/yYjD5IytOC+NGoXDOFbUVPOOpwqpaSZadqdkuZnV3/c9z4YSrdyqOSEPkBA
         psvrXgefmXTgmWA9fQAL2946jSt6A+jDZ/Y4C0HbiWz/7+TZG5yfZtDZNzCdNCaJM/Fz
         38nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760089279; x=1760694079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wq9sBzt27xhVE00MKRZHgRlmEb4HHQG1wzN2xa1Axvc=;
        b=JbKh5v2lrj1kPsIWfu8ExyhskaMHMKAr8+4T+aclebSCLM50Ccs+1jZHpuvotb9Idf
         kfUnGq3NEdYXppl5tGlw43S5izsESFzAGWjT1+u/a8ogTgYKKcB2FGk5+xJIs6/qV7XU
         oB/PDfP1hMlzpho6LeleyOiMv2WzkZQVgP40yId/pT3fQTqmIT1MDXFMpWLB1BfBIXnV
         1U+FzGyKNExU/V19lqQ5KwYYH8JUC14JIfjywJDjexCozpSYC3OieXbRaqZKkrWMbpMl
         tFk8YYS/kSj5fr+RX5CZEYsGoC628AnfvWjgDxGnORaAOvWwqvi1OkBmVHfz8enlsZIx
         KvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7aNiE2zVevclF2qkm3Qe21+qEVVmMiRKGb/+xqlsmjUMxxXH1QD2v2+No6RonFVAxt5BnnHirbPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw77SQR+/ySSKV1zwpiFUuLJjdj2GkpB+ybh97p7gu/dI/MQ/1g
	jhG4pDb5iDL0Nycz8TyptpJkI7NLgqLKuncmMeeuVHggEnp+7UYcUVKG
X-Gm-Gg: ASbGncuhfsztZy2JeECALo+dj9VPbeJXue5SrEg8EpoD75q9cLJpCT/CRHiP+st/WAC
	t1iMHhE6pRE6wuGtcwxXH+IG66PsYpEiCcqJZVi1BR6zTlOGO9nUPvNbMkxzFFu4He6oFbccubx
	nurwyuczOTIWyu5lEEHa2hQMaGN8MnY94bv1sDPmCIg8bG9uLR9OqjhAQ1XBoHhArROL3ERHoz7
	HzBYEdkcp+lH30nvaC2OIveZwGjtPee5zRzac/p/pkZ0jeTswiRz/kgMCT7NRHY7RPYmBsNo8m9
	MnDJuhQJIth9TldZIC7S66Fw9Eok33WyYGdOdQJRu/p5+P8EjoOmZ69z96uXUUdyyUl0SKzcNqd
	mBe5lvLl5I4Lya7aukIv8fa4CqVGMpWQqx9nm6Q==
X-Google-Smtp-Source: AGHT+IF3lD9WVSidKuzagqFJR/FrlQ6zmxKPnguDbIw0mAThtrjLUEb36T/KN6an53yanBEG5SPxvw==
X-Received: by 2002:a05:6000:186f:b0:425:75b7:4b67 with SMTP id ffacd0b85a97d-4266e8da717mr6986662f8f.58.1760089278315;
        Fri, 10 Oct 2025 02:41:18 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce582b44sm3304938f8f.16.2025.10.10.02.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 02:41:17 -0700 (PDT)
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
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Young <dyoung@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Nicolas Schichan <nschichan@freebox.fr>,
	David Disseldorp <ddiss@suse.de>,
	patches@lists.linux.dev
Subject: [PATCH v2 0/3] initrd: remove half of classic initrd support
Date: Fri, 10 Oct 2025 09:40:44 +0000
Message-ID: <20251010094047.3111495-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intro
====
This patchset removes half of classic initrd (initial RAM disk) support,
i. e. linuxrc code path, which was deprecated in 2020.
Initramfs still stays, RAM disk itself (brd) still stays.
And other half of initrd stays, too.
init/do_mounts* are listed in VFS entry in
MAINTAINERS, so I think this patchset should go through VFS tree.
I tested the patchset on 8 (!!!) archs in Qemu (see details below).
If you still use initrd, see below for workaround.

In 2020 deprecation notice was put to linuxrc initrd code path.
In previous version of this patchset I tried to remove initrd
fully, but Nicolas Schichan reported that he still uses
other code path (root=/dev/ram0 one) on million devices [4].
root=/dev/ram0 code path did not contain deprecation notice.

So, in this version of patchset I remove deprecated code path,
i. e. linuxrc one, while keeping other, i. e. root=/dev/ram0 one.

Also I put deprecation notice to remaining code path, i. e. to
root=/dev/ram0 one. I plan to send patches for full removal
of initrd after one year, i. e. in September 2026 (of course,
initramfs will still work).

Also, I tried to make this patchset small to make sure it
can be reverted easily. I plan to send cleanups later.

Details
====
Other user-visible changes:

- Removed kernel command line parameters "load_ramdisk" and
"prompt_ramdisk", which did nothing and were deprecated
- Removed /proc/sys/kernel/real-root-dev . It was used
for initrd only
- Command line parameters "noinitrd" and "ramdisk_start=" are deprecated

This patchset is based on current mainline (7f7072574127).

Testing
====
I tested my patchset on many architectures in Qemu using my Rust
program, heavily based on mkroot [1].

I used the following cross-compilers:

aarch64-linux-musleabi
armv4l-linux-musleabihf
armv5l-linux-musleabihf
armv7l-linux-musleabihf
i486-linux-musl
i686-linux-musl
mips-linux-musl
mips64-linux-musl
mipsel-linux-musl
powerpc-linux-musl
powerpc64-linux-musl
powerpc64le-linux-musl
riscv32-linux-musl
riscv64-linux-musl
s390x-linux-musl
sh4-linux-musl
sh4eb-linux-musl
x86_64-linux-musl

taken from this directory [2].

So, as you can see, there are 18 triplets, which correspond to 8 subdirs in arch/.

For every triplet I tested that:
- Initramfs still works (both builtin and external)
- Direct boot from disk still works
- Remaining initrd code path (root=/dev/ram0) still works

Workaround
====
If "retain_initrd" is passed to kernel, then initramfs/initrd,
passed by bootloader, is retained and becomes available after boot
as read-only magic file /sys/firmware/initrd [3].

No copies are involved. I. e. /sys/firmware/initrd is simply
a reference to original blob passed by bootloader.

This works even if initrd/initramfs is not recognized by kernel
in any way, i. e. even if it is not valid cpio archive, nor
a fs image supported by classic initrd.

This works both with my patchset and without it.

This means that you can emulate classic initrd so:
link builtin initramfs to kernel; in /init in this initramfs
copy /sys/firmware/initrd to some file in / and loop-mount it.

This is even better than classic initrd, because:
- You can use fs not supported by classic initrd, for example erofs
- One copy is involved (from /sys/firmware/initrd to some file in /)
as opposed to two when using classic initrd

Still, I don't recommend using this workaround, because
I want everyone to migrate to proper modern initramfs.
But still you can use this workaround if you want.

Also: it is not possible to directly loop-mount
/sys/firmware/initrd . Theoretically kernel can be changed
to allow this (and/or to make it writable), but I think nobody needs this.
And I don't want to implement this.

On Qemu's -initrd and GRUB's initrd
====
Don't panic, this patchset doesn't remove initramfs
(which is used by nearly all Linux distros). And I don't
have plans to remove it.

Qemu's -initrd option and GRUB's initrd command refer
to initrd bootloader mechanism, which is used to
load both initrd and (external) initramfs.

So, if you use Qemu's -initrd or GRUB's initrd,
then you likely use them to pass initramfs, and thus
you are safe.

v1: https://lore.kernel.org/lkml/20250913003842.41944-1-safinaskar@gmail.com/

v1 -> v2 changes:
- A lot. I removed most patches, see cover letter for details

[1] https://github.com/landley/toybox/tree/master/mkroot
[2] https://landley.net/toybox/downloads/binaries/toolchains/latest
[3] https://lore.kernel.org/all/20231207235654.16622-1-graf@amazon.com/
[4] https://lore.kernel.org/lkml/20250918152830.438554-1-nschichan@freebox.fr/

Askar Safin (3):
  init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command
    line parameters
  initrd: remove deprecated code path (linuxrc)
  init: remove /proc/sys/kernel/real-root-dev

 .../admin-guide/kernel-parameters.txt         |   8 +-
 Documentation/admin-guide/sysctl/kernel.rst   |   6 -
 arch/arm/configs/neponset_defconfig           |   2 +-
 fs/init.c                                     |  14 ---
 include/linux/init_syscalls.h                 |   1 -
 include/linux/initrd.h                        |   2 -
 include/uapi/linux/sysctl.h                   |   1 -
 init/do_mounts.c                              |  11 +-
 init/do_mounts.h                              |  18 +--
 init/do_mounts_initrd.c                       | 105 +-----------------
 init/do_mounts_rd.c                           |  24 +---
 11 files changed, 18 insertions(+), 174 deletions(-)


base-commit: 7f7072574127c9e971cad83a0274e86f6275c0d5
-- 
2.47.3


