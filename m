Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9E21A6FF
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2020 20:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgGIS0u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jul 2020 14:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGIS0t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jul 2020 14:26:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A52AC08C5CE
        for <linux-api@vger.kernel.org>; Thu,  9 Jul 2020 11:26:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l63so1314202pge.12
        for <linux-api@vger.kernel.org>; Thu, 09 Jul 2020 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ah/xwyUwLDcO5c6QVFl6V0itB29Y6z2+QXTTe1nwKSY=;
        b=LLdYWtX2Ocxzeqrp4lxxrExn+xcyO48LOp5c6ZDWdc234/u9a5SODz90KAgrKxCN8W
         aNWPR4t1ijUoVqeoqb3RQCycFkimFWJYaV/kEuNOn2ZjD0QBAa0ao6eHZCm5TmkfcCgS
         w6JMIfWsigDUAVICaYgQjKNjyQ0WJHCeBLKpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ah/xwyUwLDcO5c6QVFl6V0itB29Y6z2+QXTTe1nwKSY=;
        b=ojKoiPsqvusGCfPJKX+5/d+QJP0B+07ouGCn35rcjwPe9SntORrLLRoOW/Fsxdn3K1
         Bdwrz5nWI/zAHIT+AmPvCeBhybbfKgi67+j2bL581LHmSa+luJ3+IXWx6xpRgrXamZaE
         IFgbN+x1ukxNT4pVa5y/mYw9xz7XkUG75UNv6Uz0ca/C9sQ4rxuS8j/TPNaBJAy+nE/h
         dpnWdMFdEd2cl6xZ0vWkPaHUizyEg2Ery6ABpOiO94J1Tb6YIMZIiUiH4hYcXaD8gMRD
         2ajIK8VjfHQZ3uMTUX6Xn53ZGarmTXgCxQNgC8SY0Kyq510wGNlKYeCffdBz310T4EMB
         BsRQ==
X-Gm-Message-State: AOAM533APGXlx9Z0YcM5D3XE1XKoYtl6PkqqsgaWRLx2GhA99/9ubjSN
        cy/LXbtnJjiPlvSbvLbeFi33ZA==
X-Google-Smtp-Source: ABdhPJyj3kXdp3Y89vB25U3RAgnxdfxtaz0Z4xZpDPqeUGcsCQaO8cgdoenYnidhHgf9LaZ0+/Sm6A==
X-Received: by 2002:a65:6089:: with SMTP id t9mr56104275pgu.236.1594319209137;
        Thu, 09 Jul 2020 11:26:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n25sm3462318pff.51.2020.07.09.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:26:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v7 0/9] Add seccomp notifier ioctl that enables adding fds
Date:   Thu,  9 Jul 2020 11:26:33 -0700
Message-Id: <20200709182642.1773477-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello!

v7:
- break out sock usage counting fixes into more cleanly backportable pieces
- code style cleanups (christian)
- clarify addfd commit log (christian)
- add ..._SIZE_{VER0,LATEST} and BUILD_BUG_ON()s (christian)
- remove undef (christian)
- fix addfd embedded URL reference numbers
v6: https://lore.kernel.org/lkml/20200706201720.3482959-1-keescook@chromium.org/

This continues the thread-merge between [1] and [2]. tl;dr: add a way for
a seccomp user_notif process manager to inject files into the managed
process in order to handle emulation of various fd-returning syscalls
across security boundaries. Containers folks and Chrome are in need
of the feature, and investigating this solution uncovered (and fixed)
implementation issues with existing file sending routines.

I intend to carry this in the for-next/seccomp tree, unless someone
has objections. :) Please review and test!

-Kees

[1] https://lore.kernel.org/lkml/20200603011044.7972-1-sargun@sargun.me/
[2] https://lore.kernel.org/lkml/20200610045214.1175600-1-keescook@chromium.org/


Kees Cook (7):
  net/compat: Add missing sock updates for SCM_RIGHTS
  pidfd: Add missing sock updates for pidfd_getfd()
  net/scm: Regularize compat handling of scm_detach_fds()
  fs: Move __scm_install_fd() to __receive_fd()
  fs: Add receive_fd() wrapper for __receive_fd()
  pidfd: Replace open-coded receive_fd()
  fs: Expand __receive_fd() to accept existing fd

Sargun Dhillon (2):
  seccomp: Introduce addfd ioctl to seccomp user notifier
  selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD

 fs/file.c                                     |  57 +++++
 include/linux/file.h                          |  19 ++
 include/linux/seccomp.h                       |   4 +
 include/net/sock.h                            |   4 +
 include/uapi/linux/seccomp.h                  |  22 ++
 kernel/pid.c                                  |  14 +-
 kernel/seccomp.c                              | 173 ++++++++++++-
 net/compat.c                                  |  55 ++---
 net/core/scm.c                                |  50 +---
 net/core/sock.c                               |  21 ++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 229 ++++++++++++++++++
 11 files changed, 566 insertions(+), 82 deletions(-)

-- 
2.25.1

