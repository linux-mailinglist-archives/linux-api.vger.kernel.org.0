Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E802712ADC4
	for <lists+linux-api@lfdr.de>; Thu, 26 Dec 2019 19:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfLZSCg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Dec 2019 13:02:36 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:37839 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfLZSCe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Dec 2019 13:02:34 -0500
Received: by mail-il1-f193.google.com with SMTP id t8so20715435iln.4
        for <linux-api@vger.kernel.org>; Thu, 26 Dec 2019 10:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ONw/OL8JM4aZSJthnLMZow64GW9EQFEy/ugd4rWw17I=;
        b=fS/sLofaF5GDeJwaGiikpY1J3oGIbpB636hMkrOdwpxj4DA1W1Or+EdACFDbS9WupK
         dgAcbe3m1M1NFUVP1i/apRh9S04msHnLXHKpcD8unFgvlT1DrziaZFMBJno25LO4bjsH
         aYP6ibMlnCthZDCmIVYN/BE6YPb3qdCuOvhXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ONw/OL8JM4aZSJthnLMZow64GW9EQFEy/ugd4rWw17I=;
        b=LWWgHC17KLRDn6NDaDkFwGQRO2TLcbSA/Fopb/GYGHRwgUWqrcU1ePRXO04X77YVYh
         Zd4qIsCSR2ExyFSXQgswUlEJNiapOyIq0znjwrwOJ5YCR5MlO+GjiFeZJjSURM1q9TPv
         +NgcKNwYuAe6pMX9Qgb6aNo9ApQ09K+obJFlB7teGldwQLFJ4BJG5AR8VBiyYGnj9hXE
         idu4HmxO+lrleMvGRKaCQltTAQxxgaVcJoAZdBRRyac8xVvzUZw22a4+gW/2fNqxSrKI
         8t530htAX7pXGCm6y0icQ0Dqy3+jPGEJ5kP7PJfTdfymP3NEMQtGomcAqJa8u/n6nhJ4
         WQlg==
X-Gm-Message-State: APjAAAWjrHLD+wqoDjFd0fu15QEi2u2FnhqKHHzsbJB6znNnwVIaeZ8g
        gq+AgPiyUno+/9nnLSia3esNnQ==
X-Google-Smtp-Source: APXvYqz+/WtdlSrA/8bsDAuNVYEG8mox8GoQRc4mAHzJ05cj8TnZxW+3gtSpINmFkqyhgbcmCaLuDA==
X-Received: by 2002:a92:d151:: with SMTP id t17mr24010974ilg.175.1577383352464;
        Thu, 26 Dec 2019 10:02:32 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id 75sm12426869ila.61.2019.12.26.10.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 10:02:31 -0800 (PST)
Date:   Thu, 26 Dec 2019 18:02:30 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: [PATCH v7 0/3] Add pidfd_getfd syscall
Message-ID: <20191226180227.GA29389@ircssh-2.c.rugged-nimbus-611.internal>
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
under manipulation's fd still remains valid, and unmodified by the
copy operation.

It introduces a flags field. The flags field is reserved a the moment,
but the intent is to extend it with the following capabilities:
 * Close the remote FD when copying it
 * Drop the cgroup data if it's a fd pointing a socket when copying it

The syscall numbers were chosen to be one greater than openat2.

Summary of history:
This initially started as a ptrace command. It did not require the process
to be stopped, and felt like kind of an awkward fit for ptrace. After that,
it moved to an ioctl on the pidfd. Given functionality, it made sense to
make it a syscall which did not require the process to be stopped.

Previous versions:
 V6: https://lore.kernel.org/lkml/20191223210823.GA25083@ircssh-2.c.rugged-nimbus-611.internal/
 V5: https://lore.kernel.org/lkml/20191220232746.GA20215@ircssh-2.c.rugged-nimbus-611.internal/
 V4: https://lore.kernel.org/lkml/20191218235310.GA17259@ircssh-2.c.rugged-nimbus-611.internal/
 V3: https://lore.kernel.org/lkml/20191217005842.GA14379@ircssh-2.c.rugged-nimbus-611.internal/
 V2: https://lore.kernel.org/lkml/20191209070446.GA32336@ircssh-2.c.rugged-nimbus-611.internal/
 RFC V1: https://lore.kernel.org/lkml/20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal/

Changes since v6:
 * Proper attribution of get_task_file helper
 * Move all types for syscall to int to represent fd

Changes since v5:
 * Drop pidfd_getfd_options struct and replace with a flags field

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
 fs/file.c                                     |  21 +-
 include/linux/file.h                          |   2 +
 include/linux/syscalls.h                      |   1 +
 include/uapi/asm-generic/unistd.h             |   4 +-
 kernel/pid.c                                  | 103 +++++++
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   2 +-
 .../selftests/pidfd/pidfd_getfd_test.c        | 254 ++++++++++++++++++
 26 files changed, 403 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_getfd_test.c

-- 
2.20.1

