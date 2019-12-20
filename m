Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768B6128582
	for <lists+linux-api@lfdr.de>; Sat, 21 Dec 2019 00:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfLTX1x (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Dec 2019 18:27:53 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:38648 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfLTX1w (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Dec 2019 18:27:52 -0500
Received: by mail-il1-f196.google.com with SMTP id f5so9358679ilq.5
        for <linux-api@vger.kernel.org>; Fri, 20 Dec 2019 15:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZUqxZgsASKzXQm2M4tklMIaw/3yZpJ0Kn5yfMnOfzzY=;
        b=ijOzIAtjctijgjeGKCJEIw69D+tQ8KJziesTnkjrghSsh26P9NishfxV+v33x4HzAN
         M2qWhV2qzQhj3ofKKWr/SoDVbHNHHWbRoxpD1ie5hIoH09+/g0LNokwv07dK11OPFruH
         /Um6LDMKgFwgPdDrMF/HBA7U6Y3RJ2/dpyCoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZUqxZgsASKzXQm2M4tklMIaw/3yZpJ0Kn5yfMnOfzzY=;
        b=MMYmtaLsId85AJYQwQgI4ifSXsI8xnNTdGHeokKHSmyHdPU4trwXGmVqQdyn6RRnq+
         aYDNMWQIm7uXkbl1FvffTRCZe3E2gNAtVNSlmOwW/Uc7P6qQ8AMBsj4ZapJi77rDcY7k
         EFIEpm72/MMBcBMyTr9ad6BGf5IifRhtlrsQLsFs9x8LjUXGoqHVHrl7Tvzty9qthWB3
         6qyyCskbLbjGxmah9hluxC2m1vDegZY/piRiEDJHZPaI/R6vpmtJZBhU1V/aqIIMIjVl
         PGU601lgwBNKOQ3u6Ld7Nsmm/Hsj02puCe4CyrztRouXhjE1FDkIRo4hME0UiGzYmVUr
         W7gw==
X-Gm-Message-State: APjAAAU0W4AflmQ4EMFGZ+/ZyGBQMD4c9TS2CjP8GsQXUxDqhepHomlM
        jog5yDfCZECw/OglcKhUBtizpg==
X-Google-Smtp-Source: APXvYqx6DJF0HdWYtUyZuIY8x9eKPbK1WdvoFdpSid5cjGP9+CD+I3Cilcm+4gQY7hzUU6i6jTw7HA==
X-Received: by 2002:a92:cb10:: with SMTP id s16mr14563659ilo.176.1576884471551;
        Fri, 20 Dec 2019 15:27:51 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id m90sm1462397ilh.56.2019.12.20.15.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 15:27:51 -0800 (PST)
Date:   Fri, 20 Dec 2019 23:27:49 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: [PATCH v5 0/3] Add pidfd_getfd syscall
Message-ID: <20191220232746.GA20215@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patchset introduces a mechanism (pidfd_getfd syscall) to get file
descriptors from other processes via pidfd. Although this can be achieved
using SCM_RIGHTS, and parasitic code injection, this offers a more
straightforward mechanism, with less overhead and complexity. The process
under manipulation's fd still remains.

It includes a model for extensibility, specifically to allow for future
features around cgroup migration of sockets, and allowing for the fd
to be taken (closing the fd in the process under manipulation).

The syscall numbers were chosen to be one greater than openat2.

Summary of history:
This initially started as a ptrace command. It did not require the process
to be stopped, and felt like kind of an awkward fit for ptrace. After that,
it moved to an ioctl on the pidfd. Given functionality, it made sense to
make it a syscall which did not require the process to be stopped.

Changes since v4:
 * Turn into a syscall
 * Move to PTRACE_MODE_ATTACH_REALCREDS from PTRACE_MODE_READ_REALCREDS
 * Remove the sample code. This will come in another patchset, as the
   new self-tests cover all the functionality.

Changes since v3:
 * Add self-test
 * Move to ioctl passing fd directly, versus args struct
 * Shuffle around include files

Changes since v2:
 * Move to ioctl on pidfd instead of ptrace function
 * Add security check before moving file descriptor

Changes since the RFC v1:
 * Introduce a new helper to fs/file.c to fetch a file descriptor from
   any process. It largely uses the code suggested by Oleg, with a few
   changes to fix locking
 * It uses an extensible options struct to supply the FD, and option.
 * I added a sample, using the code from the user-ptrace sample

Sargun Dhillon (3):
  vfs, fdtable: Add get_task_file helper
  pid: Introduce pidfd_getfd syscall
  test: Add test for pidfd getfd

 MAINTAINERS                                   |   1 +
 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/arm64/include/asm/unistd32.h             |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 fs/file.c                                     |  22 +-
 include/linux/file.h                          |   2 +
 include/linux/syscalls.h                      |   4 +
 include/uapi/asm-generic/unistd.h             |   3 +-
 include/uapi/linux/pidfd.h                    |  10 +
 kernel/pid.c                                  | 115 ++++++++
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   2 +-
 .../selftests/pidfd/pidfd_getfd_test.c        | 262 ++++++++++++++++++
 28 files changed, 437 insertions(+), 5 deletions(-)
 create mode 100644 include/uapi/linux/pidfd.h
 create mode 100644 tools/testing/selftests/pidfd/pidfd_getfd_test.c

-- 
2.20.1

