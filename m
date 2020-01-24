Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18FF5147A3A
	for <lists+linux-api@lfdr.de>; Fri, 24 Jan 2020 10:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgAXJR6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Jan 2020 04:17:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45105 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbgAXJR6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Jan 2020 04:17:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so690949pgk.12
        for <linux-api@vger.kernel.org>; Fri, 24 Jan 2020 01:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FFs/EsdtRscf8mrY/Jnn+OFoGxG7CxqnjEoCeXl2Nps=;
        b=G4Cbvo9JI2cOaoZ6s2snBtga4+6+zZ+SvltXUrVS9l2l0ftyHUrsFQBF5pip5iYmTQ
         RmT6PoG48wReiyER4H92O0wJC/aLoWEvH+SW3hzCxtOpJFbejVmFC5BsD1cMjGbyKJcp
         alEdqeIiup81GNvrnPtLSqvYYHW646cUh/DdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FFs/EsdtRscf8mrY/Jnn+OFoGxG7CxqnjEoCeXl2Nps=;
        b=O4PGwkaLZ10nLupWnczuJfNqK7RsVJsn+ML3UTLzEQOEiOOnUnNVPioPf2uIlV1mpx
         tpywzEUdiujta3vVwhR4KE9kjW7h2K6XC/TFoRQQ2XcFFBR46ZwCoiegnSRUeSs46a06
         3eJH4+bPv8Kl0bkU5xvF0rlLBwY43D6IKXkd4EFNlVzmJ5+1o9y8E4oqfVs82chjlPIw
         mzQwy6UY/Qw8ScMcDg4g0zFzhkqLQ6h2aRFRBFbyzR0euP17D9AKzXWuSV0csVfcXkVC
         mSrhkEc9ASpx2NCPwa4aiP0WOOvCAb0fy5ZPaPX2rFJtyjqmDBaevNM1XsR/F5s8pLWT
         zq2A==
X-Gm-Message-State: APjAAAWQGq/TFGJFfFIY1ZKVnPVa9Sm7wbsgroTfoBI+UaPUPWn6ZQJx
        lQP90ALar3Phid10oQYQPdXOmw==
X-Google-Smtp-Source: APXvYqzLdYRkEKsSqDWOYv8GoFK+AQpSZfH5CoQU2dOQbZHX4rkib4veekPke6G0fxy+dn+UfaXSuw==
X-Received: by 2002:a63:946:: with SMTP id 67mr2925580pgj.277.1579857477139;
        Fri, 24 Jan 2020 01:17:57 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id y14sm5459507pfe.147.2020.01.24.01.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 01:17:56 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        christian.brauner@ubuntu.com
Subject: [PATCH 0/4] Add the ability to get a pidfd on seccomp user notifications
Date:   Fri, 24 Jan 2020 01:17:39 -0800
Message-Id: <20200124091743.3357-1-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patchset adds the ability for users of the seccomp user notification API
to receive the pidfd of the process which triggered the notification. It is
an optional feature that users must opt into by setting a flag when they
call the ioctl. With enhancements to other APIs, it should decrease
the need for the cookie-checking mechanism.

Sargun Dhillon (4):
  pid: Add pidfd_create_file helper
  fork: Use newly created pidfd_create_file helper
  seccomp: Add SECCOMP_USER_NOTIF_FLAG_PIDFD to get pidfd on listener
    trap
  selftests/seccomp: test SECCOMP_USER_NOTIF_FLAG_PIDFD

 include/linux/pid.h                           |   1 +
 include/uapi/linux/seccomp.h                  |   4 +
 kernel/fork.c                                 |   4 +-
 kernel/pid.c                                  |  22 ++++
 kernel/seccomp.c                              |  68 ++++++++++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 110 ++++++++++++++++++
 6 files changed, 200 insertions(+), 9 deletions(-)

-- 
2.20.1

