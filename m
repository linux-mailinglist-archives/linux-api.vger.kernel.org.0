Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1C3159C9D
	for <lists+linux-api@lfdr.de>; Tue, 11 Feb 2020 23:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgBKW4K (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Feb 2020 17:56:10 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50798 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbgBKW4J (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Feb 2020 17:56:09 -0500
Received: by mail-pf1-f201.google.com with SMTP id r13so135456pfr.17
        for <linux-api@vger.kernel.org>; Tue, 11 Feb 2020 14:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=z5hBZFlukE73X5tySesJV8jPEinxyOGgZx3qCpc+FhQ=;
        b=lRBeat1DM/6m8wVzhtbw3NbGYuXI5jrNZCMDH2bkPtPkorENZSb/rNayT9WHqeuj4z
         XNiVPVGX2pusznQ1ujf8QR2xOyBI/+zE5DN9wxiuYLG6WE5+drIQepezj2KwFMRbrZXL
         9pht2m3MheSA4XZzOWTsaYLJbHT7vKjw/CecQE80mFpR3gYzIRcVZib11+kBT1jsexEe
         6NcsyOlB/MGz7sS46G6OcUah1YEZi0GWN+npoLpF03tNcuX0eDaTYVVCBNhYAe7EM1DI
         GODlU6IlhvIVeuAEmd/Ih1Nu8CS43QgX1CsO4cXY4B2rg23HINcAnFHVQYeurJwrhMJN
         F/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=z5hBZFlukE73X5tySesJV8jPEinxyOGgZx3qCpc+FhQ=;
        b=X5Vj1ktUkXrXPhHAPZSCPPJ2uYGZDtl1QR3ENtsl3Dju3iDDhdgmHWSWHZoKPZ03bk
         zE97wfANJAZv6W5P9JNQljurbw1ZTcQav14KMtIA/QWn8tOhiZjJt7b6BcCGBovSFEim
         GAPwB2znuLMzQM6TDskmVcaZ3jhLVe2cyxlqLhH9a1LaRAr4mmTawWiJQb1SSo1/bHAe
         qbXV/DJ1NiqsBUnB8ZDPsTT73Qj7PAYfViVk9LcmH9gizKaUbIk66oxnLRUFQntWBboV
         6x+/sUU6FSX0swZtKuKF5V4X30fjgC/7bCAcWaZwY8LGXqCxciKTiHi5zWoJ25TeyClp
         tk6g==
X-Gm-Message-State: APjAAAUhkReQayozUhjRnGMZvF2ldh9yyjYuZtZUK3X2aCnGFr2C62wq
        GAcykJM+nyOFVc1j0NAj5X2L9a63aCQ=
X-Google-Smtp-Source: APXvYqz3X0ton3FvOV+uorjZiWOGrdx8y9Xd27MZc3lIrLJXDLMtq+k4O5/wHZSBlOtX5wMSTKh//psjJJc=
X-Received: by 2002:a65:420b:: with SMTP id c11mr5419343pgq.306.1581461769152;
 Tue, 11 Feb 2020 14:56:09 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:55:41 -0800
Message-Id: <20200211225547.235083-1-dancol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 0/6] Harden userfaultfd
From:   Daniel Colascione <dancol@google.com>
To:     dancol@google.com, timmurray@google.com, nosh@google.com,
        nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Userfaultfd in unprivileged contexts could be potentially very
useful. We'd like to harden userfaultfd to make such unprivileged use
less risky. This patch series allows SELinux to manage userfaultfd
file descriptors and allows administrators to limit userfaultfd to
servicing user-mode faults, increasing the difficulty of using
userfaultfd in exploit chains invoking delaying kernel faults.

A new anon_inodes interface allows callers to opt into SELinux
management of anonymous file objects. In this mode, anon_inodes
creates new ephemeral inodes for anonymous file objects instead of
reusing a singleton dummy inode. A new LSM hook gives security modules
an opportunity to configure and veto these ephemeral inodes.

Existing anon_inodes users must opt into the new functionality.

Daniel Colascione (6):
  Add a new flags-accepting interface for anonymous inodes
  Add a concept of a "secure" anonymous file
  Teach SELinux about a new userfaultfd class
  Wire UFFD up to SELinux
  Let userfaultfd opt out of handling kernel-mode faults
  Add a new sysctl for limiting userfaultfd to user mode faults

 Documentation/admin-guide/sysctl/vm.rst | 13 ++++
 fs/anon_inodes.c                        | 89 +++++++++++++++++--------
 fs/userfaultfd.c                        | 29 ++++++--
 include/linux/anon_inodes.h             | 27 ++++++--
 include/linux/lsm_hooks.h               |  8 +++
 include/linux/security.h                |  2 +
 include/linux/userfaultfd_k.h           |  3 +
 include/uapi/linux/userfaultfd.h        |  9 +++
 kernel/sysctl.c                         |  9 +++
 security/security.c                     |  8 +++
 security/selinux/hooks.c                | 68 +++++++++++++++++++
 security/selinux/include/classmap.h     |  2 +
 12 files changed, 229 insertions(+), 38 deletions(-)

-- 
2.25.0.225.g125e21ebc7-goog

