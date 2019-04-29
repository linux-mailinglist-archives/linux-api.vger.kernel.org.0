Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17755E662
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 17:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfD2P3Y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 11:29:24 -0400
Received: from mail.efficios.com ([167.114.142.138]:56700 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfD2P3Y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 11:29:24 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 965A81C1C8F;
        Mon, 29 Apr 2019 11:29:22 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id KhiAxotBqAbr; Mon, 29 Apr 2019 11:29:22 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3B8541C1C8C;
        Mon, 29 Apr 2019 11:29:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3B8541C1C8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556551762;
        bh=oeB5Du+F0HQtKwSK2A3ZXitc9LMeHbag39VqK1/CHyg=;
        h=From:To:Date:Message-Id;
        b=Dplpme90ELJB7fIj6uwcV/mxKyf/prVOfa6IfRtHT93b9Dm2YlQcvjNivIe08xBNy
         ohiE1VS5Luk0R0u7BPQG1mutigvB6MgVlBqMnr7XAvFqgWpSwISWVJY1ZjsDRmUFr1
         T7tfUpGZeUpJiNw1OkpyBXNk76GxOy/XyiecYsiU/jzsGxK+4N7hPeVGNdppmKN+0g
         VlwlThxD/5RGdQ0yN9s3Gl++a61/Xs1SvewTwtPVI0w2J17MHgs/qU0LsmmnkxaebE
         PNTevuYjsxxMAD2uT2fplKslTL2gQ0wzZZEZEMEQQlYoqwMjLBDhYKflZhXdtLKtF2
         kI7YnXciAwDKw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id KPbFGPCJ8WTo; Mon, 29 Apr 2019 11:29:22 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id A5E771C1C82;
        Mon, 29 Apr 2019 11:29:21 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH for 5.2 00/12] Restartable Sequences selftests updates
Date:   Mon, 29 Apr 2019 11:27:51 -0400
Message-Id: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Those rseq selftests updates are hereby submitted to Shuah Khan,
maintainer of kernel selftests, for the next merge window (5.2).

They change the per-architecture pre-abort signatures to ensure those
are valid trap instructions.

The way exit points are presented to debuggers is enhanced, ensuring
all exit points are present, so debuggers don't have to disassemble
rseq critical section to properly skip over them.

Discussions with the glibc community is reaching a concensus of exposing
a __rseq_handled symbol from glibc to coexist with rseq early adopters.
Update the rseq selftest code to expose and use this symbol.

Support for compiling asm goto with clang is added with the
"-no-integrated-as" compiler switch, similarly to the toplevel kernel
Makefile.

Thanks,

Mathieu

Martin Schwidefsky (1):
  rseq/selftests: s390: use trap4 for RSEQ_SIG

Mathieu Desnoyers (11):
  rseq/selftests: x86: Work-around bogus gcc-8 optimisation
  rseq/selftests: Add __rseq_exit_point_array section for debuggers
  rseq/selftests: Introduce __rseq_cs_ptr_array, rename __rseq_table to
    __rseq_cs
  rseq/selftests: Use __rseq_handled symbol to coexist with glibc
  rseq/selftests: s390: use jg instruction for jumps outside of the asm
  rseq/selftests: x86: use ud1 instruction as RSEQ_SIG opcode
  rseq/selftests: arm: use udf instruction for RSEQ_SIG
  rseq/selftests: aarch64 code signature: handle big-endian environment
  rseq/selftests: powerpc code signature: generate valid instructions
  rseq/selftests: mips: use break instruction for RSEQ_SIG
  rseq/selftests: add -no-integrated-as for clang

 tools/testing/selftests/rseq/Makefile     |   8 +-
 tools/testing/selftests/rseq/rseq-arm.h   | 132 +++++++++++++--
 tools/testing/selftests/rseq/rseq-arm64.h |  74 ++++++++-
 tools/testing/selftests/rseq/rseq-mips.h  | 115 +++++++++++--
 tools/testing/selftests/rseq/rseq-ppc.h   |  90 +++++++++-
 tools/testing/selftests/rseq/rseq-s390.h  |  78 ++++++++-
 tools/testing/selftests/rseq/rseq-x86.h   | 264 +++++++++++++++++++++---------
 tools/testing/selftests/rseq/rseq.c       |  55 ++++++-
 tools/testing/selftests/rseq/rseq.h       |   1 +
 9 files changed, 688 insertions(+), 129 deletions(-)

-- 
2.11.0

