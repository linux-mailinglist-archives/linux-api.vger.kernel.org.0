Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4624E116754
	for <lists+linux-api@lfdr.de>; Mon,  9 Dec 2019 08:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLIHEx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Dec 2019 02:04:53 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44980 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfLIHEx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Dec 2019 02:04:53 -0500
Received: by mail-io1-f67.google.com with SMTP id z23so13545076iog.11
        for <linux-api@vger.kernel.org>; Sun, 08 Dec 2019 23:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8VrpkdgQrnMuSOUeurvVW4z5wWNDdr+43CeOmu+R6D8=;
        b=HSu8OsTo4/VtQt5rmELSu4Joyw16NEM5RVv/RNBtEfBSy/DpLzQ+ESzqWonDFjw5ry
         iuBBg7SqksIqsJ2MJ9s0w3T8lk5KE7eh/5C7XChjfLivhhGUdegPB8z+1csZwHzyiiYy
         ultBTBS3b3I4zQa2RRZ7jnW+qaQKJdD6sBwQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8VrpkdgQrnMuSOUeurvVW4z5wWNDdr+43CeOmu+R6D8=;
        b=VNuNseZwomOK+iRaxsRlW8c5jpReRaEGAefgvaxmE2qKz2kHPvsEYzUeBVcmUzrGhz
         9dF8uCfsDfUo0cI8iFwDAjkziFG9se+5fr4E2PxIecsfmFZpuyNhKEJ8dUWSdJM6ZRsL
         bqrvAnqYjXwCb1H43tVPnvk3OKi45Xrfkl+16ADS/HrKB4v5sOdNa9395Ptc6hblKDym
         KQ3xNrB+5ac5yoOGsgWjEdh681CSx+5MJw21ZXnNEUU8nvzxC1/vK9c5NWDgyuQfoGBc
         +yRBkrBnlMYqhyxb6LuC6EiPs3tiRWFDLJkBusjNM7MIdvPjKx3ouTLZGVeC/6QEDnkg
         H+vw==
X-Gm-Message-State: APjAAAVzhUYfKuggCl2xKDxkiKaIpCyOJMnWiuXPGujD7pN3pwqhEKct
        Q6nVrsiKeWxlQp2iISWbUlKBBg==
X-Google-Smtp-Source: APXvYqwsZDjYTujGClfn7hASFQzQ3ywZgbD8A/L942G+ugOls0cc0a4XwERFsQxcrrOTYvGtbyueng==
X-Received: by 2002:a6b:7316:: with SMTP id e22mr20331932ioh.205.1575875092332;
        Sun, 08 Dec 2019 23:04:52 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id f76sm6543960ild.82.2019.12.08.23.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Dec 2019 23:04:51 -0800 (PST)
Date:   Mon, 9 Dec 2019 07:04:50 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2 0/4] Add ptrace get_fd request
Message-ID: <20191209070446.GA32336@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patchest introduces a mechanism to capture file descriptors from other
processes via ptrace. Although this can be achieved using SCM_RIGHTS, and
parasitic code injection, this offers a slightly more straightforward
mechainsm. It also does not mutate the tracee in any way, nor does it
require that the tracee is stopped, as to avoid causing issues with
attaching debuggers or runtimes that expect syscalls to be preemptible, or
return within a specific amount of time.

It has an options mechanism that's only usable to set CLOEXEC on the fd,
but I'm thinking that it could be extended to other aspects. For example,
for sockets, one could want to scrub the cgroup information.

In the future, the API may not require ptrace attachment, or seizing, but
right now it does as a matter of safety.

Changes since the RFC v1:

 * Introduce a new helper to fs/file.c to fetch a file descriptor from
   any process. It largely uses the code suggested by Oleg, with a few
   changes to fix locking
 * It uses an extensible options struct to supply the FD, and option.
 * I added a sample, using the code from the user-ptrace sample

Sargun Dhillon (4):
  vfs, fdtable: Add get_task_file helper
  ptrace: add PTRACE_GETFD request to fetch file descriptors from
    tracees
  samples: split generalized user-trap code into helper file
  samples: Add example of using PTRACE_GETFD in conjunction with user
    trap

 fs/file.c                          |  19 +++
 include/linux/fdtable.h            |  10 ++
 include/uapi/linux/ptrace.h        |  15 +++
 kernel/ptrace.c                    |  35 +++++-
 samples/seccomp/.gitignore         |   1 +
 samples/seccomp/Makefile           |  15 ++-
 samples/seccomp/user-trap-helper.c |  84 +++++++++++++
 samples/seccomp/user-trap-helper.h |  13 ++
 samples/seccomp/user-trap-ptrace.c | 193 +++++++++++++++++++++++++++++
 samples/seccomp/user-trap.c        |  85 +------------
 10 files changed, 382 insertions(+), 88 deletions(-)
 create mode 100644 samples/seccomp/user-trap-helper.c
 create mode 100644 samples/seccomp/user-trap-helper.h
 create mode 100644 samples/seccomp/user-trap-ptrace.c

-- 
2.20.1

