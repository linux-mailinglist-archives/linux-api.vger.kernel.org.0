Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C701E5DEA
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2020 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388120AbgE1LJX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 May 2020 07:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388038AbgE1LJW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 May 2020 07:09:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B311BC08C5C5
        for <linux-api@vger.kernel.org>; Thu, 28 May 2020 04:09:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s10so13341399pgm.0
        for <linux-api@vger.kernel.org>; Thu, 28 May 2020 04:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/hGgJc4yu0ZVUtNy8lGvcyIo3reBS9Mlu/UUHcA6ydY=;
        b=oZmPlXP3Fkb57eR2YqOUktAcUqf1BFyBetI1wYLxwwKba4RvG2oXsa35fFsmSY68cL
         PAuMQavYtaoa5Uv8qY2w+or9Yyh3A9eko8SbeIZ4ZTr3mhPLrgTfSJq/qvtELncNyrqA
         N1jCX+Gdf776DB+LYthi1GRJ+eVMWMixe+bQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/hGgJc4yu0ZVUtNy8lGvcyIo3reBS9Mlu/UUHcA6ydY=;
        b=TrLVmz6pEZggnAYAChpj+gwuAbWkxaVWPNLiQ2TVECqIiLk32XTnzGftUWKFglJDkw
         GnuGIUdLB7kLgXknGV+Cqa3RXclw7c8FbPxP8yMFQxCoRK/KDnFaUqZMze1RIHSwSJOG
         PVm8EvdGP9JUNNnuqlbbBfkf4AcA0msbGVaj2uCa/Or+C/LwGBH4+yeUvZ0px3GnldB8
         c9UxOpP5GxkkYXFL2W3A1QsjlNSR0yRVdMV49v9pS1cttk8/OR5smN2UVIOEsIzBjiLq
         h5CDTZB1ajDPhW6kkLBC45hf27b14u5IQiP0J8fpZ9nBZ+OWylB5AhIq8zV2t8ECya2g
         GOgg==
X-Gm-Message-State: AOAM530/XM/oSZ+U28Ip1IpFRAZGeBZXptBdgCREzaMoybxWDmQUkB6V
        aQPyVSjm4nKY377NzvrDLxmRujSQoWRkxGde
X-Google-Smtp-Source: ABdhPJwRbPpRRxsdydn1CGqqtA+YDG6pIeYJPk+Wn1Y7R1+f3mpkr8rEpfTfs3i4U9l8Q6CDTR9q2w==
X-Received: by 2002:a65:6854:: with SMTP id q20mr2363645pgt.448.1590664160753;
        Thu, 28 May 2020 04:09:20 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id j26sm4565759pfr.215.2020.05.28.04.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 04:09:19 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     keescook@chromium.org
Cc:     Sargun Dhillon <sargun@sargun.me>, christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws
Subject: [PATCH v2 0/3]  Add seccomp notifier ioctl that enables adding fds
Date:   Thu, 28 May 2020 04:08:55 -0700
Message-Id: <20200528110858.3265-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This adds the capability for seccomp notifier listeners to add file
descriptors in response to a seccomp notification. This is useful for
syscalls in which the previous capabilities were not sufficient. The
current mechanism works well for syscalls that either have side effects
that are system / namespace wide (mount), or that operate on a specific
set of registers (reboot, mknod), and don't require dereferencing pointers.
The problem with derefencing pointers in a supervisor is that it leaves
us vulnerable to TOC-TOU [1] style attacks. For syscalls that had a direct
effect on file descriptors pidfd_getfd was added, allowing for those file
descriptors to be directly operated upon by the supervisor [2].

Unfortunately, this leaves system calls which return file descriptors
out of the picture. These are fairly common syscalls, such as openat,
socket, and perf_event_open that return file descriptors, and have
arguments that are pointers. These require that the supervisor is able to
verify the arguments, make the call on behalf of the process on hand,
and pass back the resulting file descriptor. This is where addfd comes
into play.

There is an additional flag that allows you to "set" an FD, rather than
add it with an arbitrary number. This has dup2 style semantics, and
installs the new file at that file descriptor, and atomically closes
the old one if it existed. This is useful for a particular use case
that we have, in which we want to swap out AF_INET sockets for AF_UNIX,
AF_INET6, and sockets in another namespace when doing "upconversion".

My specific usecase at Netflix is to enable our IPv4-IPv6 transition
mechanism, in which we our namespaces have no real IPv4 reachability,
and when it comes time to do a connect(2), we get a socket from a
namespace with global IPv4 reachability.

In addition, we intend to use it for our servicemesh, and where our
service mesh needs to intercept traffic ingress traffic, the addfd
capability will act as a mechanism to do socket activation.

Google Chrome has a use case has a use case related to sandboxing.
They use SECCOMP_RET_TRAP to capture filesystem related syscalls in
their sandbox, which returns the FDs via SCM_RIGHTS. Unfortunately,
this does not work when signals are disabled, which is becoming the
default in glibc library functions. They need to switch to an
alternative before this becomes the default in Linux distros, and
they need a mechanism to addfd to move forward.

Addfd is not implemented as a separate syscall, a la pidfd_getfd, as
VFS makes some optimizations in regards to the fdtable, and assumes
that they are not modified by external processes. Although a mechanism
that scheduled something in the context of the task could work, it is
somewhat simpler to do it in the context of the ioctl as we control
the task while in kernel. In addition there are not obvious needs
for this beyond seccomp notifier.

This mechanism leaves a potential issue that if the manager is
interrupted while injecting FDs, the child process will be left with
leaked / dangling FDs. This may lead to undefined behaviour. A
mechanism to work around this is to extend the structure and add a
"rollback" mechanism for FDs to be closed if things fail.

Changes since v1:
 * find_notification has been cleaned up slightly, and it replaces a use
   case in send as well.
 * Fixes ref counting rules to get / release references in the ioctl side,
   rather than the seccomp notifier side [3].
 * Removes the optional move flag, and opts into SCM_RIGHTS
 * Rearranges the seccomp_notif_addfd datastructure for greater user
   clarity [4]. In order to avoid unnamed padding it makes size u64,
   which is a little bit of a waste of space.
 * Changes error codes to return ESRCH upon the process going away on
   notification, and EINPROGRESS is the notification is in an unexpected
   state (and added tests for this behaviour)

[1]: https://lore.kernel.org/lkml/20190918084833.9369-2-christian.brauner@ubuntu.com/
[2]: https://lore.kernel.org/lkml/20200107175927.4558-1-sargun@sargun.me/
[3]: https://lore.kernel.org/lkml/20200525000537.GB23230@ZenIV.linux.org.uk/
[4]: https://lore.kernel.org/lkml/20200525135036.vp2nmmx42y7dfznf@wittgenstein/

Sargun Dhillon (3):
  seccomp: Add find_notification helper
  seccomp: Introduce addfd ioctl to seccomp user notifier
  selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD

 include/uapi/linux/seccomp.h                  |  25 ++
 kernel/seccomp.c                              | 231 ++++++++++++++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 180 ++++++++++++++
 3 files changed, 410 insertions(+), 26 deletions(-)

-- 
2.25.1

