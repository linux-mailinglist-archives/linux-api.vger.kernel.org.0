Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1E9D51F8
	for <lists+linux-api@lfdr.de>; Sat, 12 Oct 2019 21:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfJLTQM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 15:16:12 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:44958 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbfJLTQM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 12 Oct 2019 15:16:12 -0400
Received: by mail-vk1-f201.google.com with SMTP id b204so5094360vkb.11
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 12:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cgGZvwJnEGZisI4Gx+FEE0RSIkczOwq/CnutrrsIPDg=;
        b=hY5IoaetYla5K4CZDUJpZfqMB6tRT69RksToZe2ITHKt/cs8UmADkqTQoSBtcjeu1X
         YjZa4cdGK7/lcQMgB+dwIHcDpii68wltQCkm1GHVA+l7koQ0HEnCkeQJDP5IiKUzqh4q
         gF68dv50l1radXHZ1RYp/XJ59VBdure8blXWxxCico6NvisHkGupjXsp3mL9f+xUhSiz
         Cg+lNORj8vEhDRJ1EdztXASNmJCL79Y5bDd0uNpi3gMm3mYuy2vFdkEpXGDed+W5YoVI
         p3wTX1AMC6r9lPoKLPZC4dqM1LWspSSf+43Ec/LnWiJeC9xfFHNkxpVkYghRtGqiIS0G
         uu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cgGZvwJnEGZisI4Gx+FEE0RSIkczOwq/CnutrrsIPDg=;
        b=p2aOPkA++ip2++HLz1BZMmJ4fOlD4pKZnovlqAR4dXUibz25ITEVpbhhCGwpjlilUF
         dg/0E13zZij2axCuOyRwBskgmBEP7AsvniXwzUO6MTqVgCqtfxoedfNAphK3DzHMMkTj
         Mtrj04y4FxGhTMndmXStKL2aWtStbK2D/z38e6+sMnJ5Pvhy5vwFBQ3W8kkRphewB6JR
         R9/r5onHozvdWPKt8hGlv8J4Sf0XJV3esVlb8S478FmVSrqNEYJsQCKOLiz603yWxLKC
         7Y3Aef6QC0v8keHyaUu6S69FA2uXAlATaTLqjeJrlQLRuvZLDU7S4B0ojLcRvfgyT5Yw
         vu5g==
X-Gm-Message-State: APjAAAUc45tEvS3FwnSUWMxFHYfdQza0TMHqnxzxgjIcbZnbVG8BBtt5
        w7N2oT6RaLdBehaHH9DdNep1OkES1ZwQ7tGPGosvnxN3uQxTCF8dogKM40obe9Kp4P3ycq1TUAn
        UNLMkfknpMZfsQEcQlr6KOLUW4ZjeFdtyZSKPqF4dGVuzjzXnHGGppa4ytKaBV4E2Cg==
X-Google-Smtp-Source: APXvYqwaUeRJ6x02z8elU1C3NDl027logw1VDhmfR9ix2GcHCirPapDVMNBMBWC+M+dd6v9o18pHv5gMNXM=
X-Received: by 2002:a67:ad0c:: with SMTP id t12mr12732593vsl.82.1570907771122;
 Sat, 12 Oct 2019 12:16:11 -0700 (PDT)
Date:   Sat, 12 Oct 2019 12:15:55 -0700
Message-Id: <20191012191602.45649-1-dancol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 0/7] Harden userfaultfd
From:   Daniel Colascione <dancol@google.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lokeshgidra@google.com, dancol@google.com, nnk@google.com
Cc:     nosh@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Userfaultfd in unprivileged contexts could be potentially very
useful. We'd like to harden userfaultfd to make such unprivileged use
less risky. This patch series allows SELinux to manage userfaultfd
file descriptors (via a new flag, for compatibility with existing
code) and allows administrators to limit userfaultfd to servicing
user-mode faults, increasing the difficulty of using userfaultfd in
exploit chains invoking delaying kernel faults.

A new anon_inodes interface allows callers to opt into SELinux
management of anonymous file objects. In this mode, anon_inodes
creates new ephemeral inodes for anonymous file objects instead of
reusing a singleton dummy inode. A new LSM hook gives security modules
an opportunity to configure and veto these ephemeral inodes.

Existing anon_inodes users must opt into the new functionality.

Daniel Colascione (7):
  Add a new flags-accepting interface for anonymous inodes
  Add a concept of a "secure" anonymous file
  Add a UFFD_SECURE flag to the userfaultfd API.
  Teach SELinux about a new userfaultfd class
  Let userfaultfd opt out of handling kernel-mode faults
  Allow users to require UFFD_SECURE
  Add a new sysctl for limiting userfaultfd to user mode faults

 Documentation/admin-guide/sysctl/vm.rst | 19 +++++-
 fs/anon_inodes.c                        | 89 +++++++++++++++++--------
 fs/userfaultfd.c                        | 47 +++++++++++--
 include/linux/anon_inodes.h             | 27 ++++++--
 include/linux/lsm_hooks.h               |  8 +++
 include/linux/security.h                |  2 +
 include/linux/userfaultfd_k.h           |  3 +
 include/uapi/linux/userfaultfd.h        | 14 ++++
 kernel/sysctl.c                         |  9 +++
 security/security.c                     |  8 +++
 security/selinux/hooks.c                | 68 +++++++++++++++++++
 security/selinux/include/classmap.h     |  2 +
 12 files changed, 256 insertions(+), 40 deletions(-)

-- 
2.23.0.700.g56cf767bdb-goog

