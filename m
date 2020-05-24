Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D337B1E03E6
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 01:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbgEXXjr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 May 2020 19:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388335AbgEXXjq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 May 2020 19:39:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6963C061A0E
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:39:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a13so6826488pls.8
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dECFMl9BmmZ3+aYimNGMaHnjr31NSpcMrgo0hG57jSE=;
        b=GCKHxVz/fL3BhDuGXbcUgVZYy3X+rDbmzbLHsW3C2IIIU7jKp9zs7WtQyBn9oXgltU
         oHAedSy3n2UqH1/xJkuE9Xxumx8S/hQzW1Yq12yF1MHOD3sW5o2uqgYtoxqTe7wSX61+
         wVj/v/yR/Dho4fLFJnHRiX62/H9onLke6YIWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dECFMl9BmmZ3+aYimNGMaHnjr31NSpcMrgo0hG57jSE=;
        b=OdA+NqlhT4hoJvfpSkj24U9WbsJD3Po0ZOsXk4Ombj7DkXeRvFybXednxPiLFb+uc+
         6zICrQANgZxlNQpq9YX3ntaRWjlMRwHpROU+6fWJ4I8z8h59VrPW+JXqfHrUL90iTTzI
         /An63HBYayL9Vzr3XDK4QflO+UM4DDk1gVj9f1vYbBm0CVymrRdxjJgbPoes6h/qe9Qx
         Anx1iXn6kVOeiZTDXgaStAn8V8Phhpq1lfE0rEHsIfqfBl7ER2gdfC2oeU4Gq73KWTZc
         7R0ZN+WTDA3tGgOvX3ZN/HN1W/kfdpyFAWEAEpv0DOin6waqFe0nI+92E5PjFh7C930O
         sGfg==
X-Gm-Message-State: AOAM533/w6L+L7O8kxaTZW07XD0CmcbPjH5cUiy6lPnN1ALO0i2Zitwo
        Q5Tr5QDitl01UyV8yVuqqoJ1tA==
X-Google-Smtp-Source: ABdhPJw5FNIgchuHVTYQM5hwt4Kd+TtTpK1LkOXfqM8KGDJ9jbvBYAllkAWh1t+0VqQBHZxp31QU/A==
X-Received: by 2002:a17:90a:690f:: with SMTP id r15mr18203328pjj.65.1590363585776;
        Sun, 24 May 2020 16:39:45 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b16sm11633177pfi.74.2020.05.24.16.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:39:45 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, christian.brauner@ubuntu.com,
        tycho@tycho.ws, keescook@chromium.org, cyphar@cyphar.com,
        Jeffrey Vander Stoep <jeffv@google.com>, jannh@google.com,
        rsesek@google.com, palmer@google.com
Subject: [PATCH 0/5] Add seccomp notifier ioctl that enables adding fds
Date:   Sun, 24 May 2020 16:39:37 -0700
Message-Id: <20200524233942.8702-1-sargun@sargun.me>
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

Addfd is not implemented as a separate syscall, a la pidfd_getfd, as
VFS makes some optimizations in regards to the fdtable, and assumes
that they are not modified by external processes. Although a mechanism
that scheduled something in the context of the task could work, it is
somewhat simpler to do it in the context of the ioctl as we control
the task while in kernel.

There is an additional flag (move) that was added to enable cgroup
v1 controllers (netprio, classid), and moving sockets, as a socket
can only be associated with one cgroup at a time.

[1]: https://lore.kernel.org/lkml/20190918084833.9369-2-christian.brauner@ubuntu.com/
[2]: https://lore.kernel.org/lkml/20200107175927.4558-1-sargun@sargun.me/

Sargun Dhillon (5):
  seccomp: Add find_notification helper
  seccomp: Introduce addfd ioctl to seccomp user notifier
  selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD
  seccomp: Add SECCOMP_ADDFD_FLAG_MOVE flag to add fd ioctl
  selftests/seccomp: Add test for addfd move semantics

 include/uapi/linux/seccomp.h                  |  33 +++
 kernel/seccomp.c                              | 228 +++++++++++++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 235 ++++++++++++++++++
 3 files changed, 479 insertions(+), 17 deletions(-)

-- 
2.25.1

